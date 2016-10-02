//
//  Commands.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 6/29/16.
//
//

import Foundation

public struct Command {
    
    static let JOIN = "JOIN"
    static let NICK = "NICK"
    static let PART = "PART"
    static let PASS = "PASS"
    static let PING = "PING"
    static let PONG = "PONG"
    static let QUIT = "QUIT"
    static let USER = "USER"
    static let ERROR = "ERROR"
    
    static let NOTICE = "NOTICE"
    static let PRIVMSG = "PRIVMSG"
    static let IDENTIFY = "IDENTIFY"
    
    struct Reply {
        
        static let WELCOME = "001"
        static let YOURHOST = "002"
        static let CREATED = "003"
        static let MYINFO = "004"
        
        static let BOUNCE = "005"
        
        static let USERHOST = "302"
        static let ISON = "303"
        
        static let AWAY = "301"
        static let UNAWAY = "305"
        static let NOWAWAY = "306"
        
        static let WHOISUSER = "311"
        static let WHOISSERVER = "312"
        static let WHOISOPERATOR = "313"
        static let WHOISIDLE = "317"
        static let ENDOFWHOIS = "318"
        static let WHOISCHANNELS = "319"
        static let WHOWASUSER = "314"
        static let ENDOFWHOWAS = "369"
        
        static let LISTSTART = "321"
        static let LIST = "322"
        static let LISTEND = "323"
        
        static let UNIQOPIS = "325"
        static let CHANNELMODEIS = "324"
        
        static let NOTOPIC = "331"
        static let TOPIC = "332"
        
        static let INVITING = "341"
        static let SUMMONING = "342"
        
        static let INVITELIST = "346"
        static let ENDOFINVITELIST = "346"
        
        static let EXCEPTLIST = "348"
        static let ENDOFEXCEPTLIST = "349"
        
        static let VERSION = "351"
        
        static let WHOREPLY = "352"
        static let ENDOFWHO = "315"
        
        static let NAMREPLY = "353"
        static let ENDOFNAMES = "366"
        
        static let MOTDSTART = "375"
        static let MOTD = "372"
        static let ENDOFMOTD = "376"
        
    }
    
    struct Services {
        
        static let NickServ = "NickServ"
    }
    
}
