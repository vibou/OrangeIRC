//
//  RoomsViewController.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 7/3/16.
//
//

import UIKit
import OrangeIRCCore

class RoomsViewController : UITableViewController {
    
    let SHOW_SERVERS_SEGUE = "ShowServers"
    let ADD_ROOM_SEGUE = "AddRoom"
    
    let CELL_IDENTIFIER = "Cell"
    
    let servers = (UIApplication.shared().delegate as! AppDelegate).servers
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for server in self.servers {
            count += server.rooms.count
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    @IBAction func addRoom(_ sender: UIBarButtonItem) {
        let roomType = NSLocalizedString("ROOM_TYPE", comment: "Room Type")
        let roomTypeDescription = NSLocalizedString("CHOOSE_ROOM_TYPE", comment: "Choose a room type")
        let roomTypeActionSheet = UIAlertController(title: roomType, message: roomTypeDescription, preferredStyle: .actionSheet)
        
        let actions: [RoomType] = [.Channel, .PrivateMessage]
        for action in actions {
            let act = UIAlertAction(title: action.localizedName(), style: UIAlertActionStyle.default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
        }
        self.present(roomTypeActionSheet, animated: true, completion: nil)
        //self.performSegue(withIdentifier: ADD_ROOM_SEGUE, sender: nil)
    }
    
    @IBAction func serversButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: SHOW_SERVERS_SEGUE, sender: nil)
    }
    
}
