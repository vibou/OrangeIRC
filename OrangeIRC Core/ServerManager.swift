//
//  ServerManager.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 1/14/17.
//
//

import Foundation

public class ServerManager {
    
    // Singleton
    public static let shared = ServerManager()
    private init() { }
    
    // Saved data
    public var servers = [Server]()
    public var rooms = [Room]()
    
    // Runtime data
    public var dataPaths: (servers: URL, rooms: URL) = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("servers.plist"),
                                                 FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("rooms.plist"))
    
    // Set by whatever uses this framework
    public var serverDelegate: ServerDelegate? {
        didSet {
            for server in servers {
                server.delegate = serverDelegate
            }
        }
    }
    
    // Dynamic variables
    public var registeredServers: [Server] {
        var regServers = [Server]()
        for server in servers {
            if server.isRegistered {
                regServers.append(server)
            }
        }
        return regServers
    }
    
    public func addServer(host: String, port: Int, nickname: String, username: String, realname: String, password: String) -> Server {
        let server = Server(host: host, port: port, nickname: nickname, username: username, realname: realname, encoding: String.Encoding.utf8)
        servers.append(server)
        server.delegate = serverDelegate
        server.connect()
        saveData()
        
        // Returned so additional configuration can be done
        return server
    }
    
    public func loadData() {
        guard let servers = NSKeyedUnarchiver.unarchiveObject(withFile: dataPaths.servers.path) else {
            // Initialize the file
            saveData()
            return
        }
        
        self.servers = servers as! [Server]
        
        guard let rooms = NSKeyedUnarchiver.unarchiveObject(withFile: dataPaths.rooms.path) else {
            // Initialize the file
            self.rooms = [Room]()
            saveData()
            return
        }
        
        self.rooms = rooms as! [Room]
        for room in self.rooms {
            guard let server = server(for: room.serverUUID) else {
                fatalError("A room without a matching server was loaded")
            }
            room.server = server
            server.rooms.append(room)
        }
        
        for server in self.servers {
            server.delegate = serverDelegate
            if server.autoJoin {
                server.connect()
            }
        }
    }
    
    public func saveData() {
        NSKeyedArchiver.archiveRootObject(servers, toFile: dataPaths.servers.path)
        NSKeyedArchiver.archiveRootObject(rooms, toFile: dataPaths.rooms.path)
    }
    
    public func server(for uuid: UUID) -> Server? {
        for server in servers {
            if server.uuid == uuid {
                return server
            }
        }
        return nil
    }
    
    public func rooms(for server: Server) -> [Room] {
        var roomsOfServer = [Room]()
        for room in rooms {
            if room.serverUUID == server.uuid {
                roomsOfServer.append(room)
                room.server = server
            }
        }
        return roomsOfServer
    }
    
}
