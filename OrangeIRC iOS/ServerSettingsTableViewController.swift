//
//  AddServerViewController.swift
//  OrangeIRC
//
//  Created by Andrew Hyatt on 7/5/16.
//
//

import UIKit
import OrangeIRCCore

class ServerSettingsTableViewController : UITableViewController {
    
    enum Mode {
        
        case Add
        case Edit
        
    }
    
    let REQUIRED = NSLocalizedString("REQUIRED", comment: "Required")
    let OPTIONAL = NSLocalizedString("OPTIONAL", comment: "Optional")
    
    var hostCell: TextFieldCell?
    var portCell: TextFieldCell?
    var nicknameCell: TextFieldCell?
    var usernameCell: TextFieldCell?
    var realnameCell: TextFieldCell?
    var passwordCell: TextFieldCell?
    var autoJoinCell: SwitchCell?
    
    // Determines whether this will edit a server
    var mode: Mode = .Add
    
    // The server to be used if editing
    var server: Server?
    
    // Used for putting this VC in edit mode
    init(style: UITableViewStyle, edit server: Server) {
        super.init(style: style)
        self.mode = .Edit
        self.server = server
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("stub")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("ADD_SERVER", comment: "Add Server")
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButton))
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        // Close this when the escape key is pressed
        addKeyCommand(UIKeyCommand(input: UIKeyInputEscape, modifierFlags: UIKeyModifierFlags(rawValue: 0), action: #selector(self.cancelButton), discoverabilityTitle: NSLocalizedString("CANCEL", comment: "")))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textFieldCell = TextFieldCell()
        let switchCell = SwitchCell()
        
        textFieldCell.textField.autocorrectionType = .no
        textFieldCell.textField.autocapitalizationType = .none
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                textFieldCell.textLabel!.text = NSLocalizedString("HOSTNAME", comment: "Hostname")
                textFieldCell.textField.placeholder = NSLocalizedString("IRC_DOT_EXAMPLE_DOT_COM", comment: "irc.example.com")
                textFieldCell.textField.keyboardType = .URL
                self.hostCell = textFieldCell
                hostCell!.tag = 0
                
                if mode == .Edit {
                    hostCell!.textField.text = server!.host
                }
                
            case 1:
                textFieldCell.textLabel!.text = NSLocalizedString("PORT", comment: "Port")
                textFieldCell.textField.placeholder = "6667"
                textFieldCell.textField.keyboardType = .numberPad
                self.portCell = textFieldCell
                portCell!.tag = 1
                
                if mode == .Edit {
                    portCell!.textField.text = String(server!.port)
                }
                
            case 2:
                textFieldCell.textLabel!.text = NSLocalizedString("PASSWORD", comment: "Password")
                textFieldCell.textField.placeholder = OPTIONAL
                textFieldCell.textField.isSecureTextEntry = true
                self.passwordCell = textFieldCell
                passwordCell!.tag = 2
                
                if mode == .Edit {
                    passwordCell!.textField.text = server!.password
                }
                
            case 3:
                self.autoJoinCell = switchCell
                switchCell.textLabel!.text = NSLocalizedString("AUTOMATICALLY_JOIN", comment: "Automatically Join")
                
                if mode == .Edit {
                    autoJoinCell!.switch.isOn = server!.autoJoin
                }
                
                return switchCell
                
            default:
                break
            }
        case 1:
            switch  indexPath.row {
            case 0:
                textFieldCell.textLabel!.text = NSLocalizedString("NICKNAME", comment: "Nickname")
                textFieldCell.textField.placeholder = REQUIRED
                self.nicknameCell = textFieldCell
                nicknameCell!.tag = 3
                
                if mode == .Edit {
                    nicknameCell!.textField.text = server!.nickname
                }
                
            case 1:
                textFieldCell.textLabel!.text = NSLocalizedString("USERNAME", comment: "Username")
                textFieldCell.textField.placeholder = REQUIRED
                self.usernameCell = textFieldCell
                usernameCell!.tag = 4
                
                if mode == .Edit {
                    usernameCell!.textField.text = server!.username
                }
                
            case 2:
                textFieldCell.textLabel!.text = NSLocalizedString("REAL_NAME", comment: "Real Name")
                textFieldCell.textField.placeholder = REQUIRED
                textFieldCell.textField.autocapitalizationType = .words
                self.realnameCell = textFieldCell
                realnameCell!.tag = 5
                
                if mode == .Edit {
                    realnameCell!.textField.text = server!.realname
                }
                
            default:
                break
                
            }
            
        default:
            break
            
        }
        
        return textFieldCell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func doneButton() {
        // TODO: Implement sanity checks
        
        switch mode {
            
        case .Add:
            // Make a new server
            let server = appDelegate.addServer(host: (hostCell?.textField.text)!, port: Int((portCell?.textField.text)!)!, nickname: (nicknameCell?.textField.text)!, username: (usernameCell?.textField.text)!, realname: (realnameCell?.textField.text)!, password: (passwordCell?.textField.text)!)
            server.autoJoin = autoJoinCell!.switch.isOn
            
            dismiss(animated: true, completion: nil)
            
        case .Edit:
            // Change an existing server
            // Reassign every setting
            
            // This boolean will be whether or not a setting was changed
            let shouldDisplayReconnectPrompt = server!.host != hostCell!.textField.text! ||
                server!.port != Int(portCell!.textField.text!)! ||
                server!.nickname != nicknameCell!.textField.text! ||
                server!.username != usernameCell!.textField.text! ||
                server!.realname != realnameCell!.textField.text! ||
                server!.password != passwordCell!.textField.text! ||
                server!.autoJoin != autoJoinCell!.switch.isOn
            
            server!.host = hostCell!.textField.text!
            server!.port = Int(portCell!.textField.text!)!
            server!.nickname = nicknameCell!.textField.text!
            server!.username = usernameCell!.textField.text!
            server!.realname = realnameCell!.textField.text!
            server!.password = passwordCell!.textField.text!
            server!.autoJoin = autoJoinCell!.switch.isOn
            
            // We should save data here
            appDelegate.saveData()
            
            if shouldDisplayReconnectPrompt {
                // Prompt the user to reconnect
                let title = NSLocalizedString("SETTINGS_CHANGED", comment: "")
                let message = NSLocalizedString("DO_YOU_WANT_TO_RECONNECT", comment: "")
                let reconnectPrompt = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let reconnectTitle = NSLocalizedString("RECONNECT", comment: "")
                let reconnect = UIAlertAction(title: reconnectTitle, style: .default, handler: { a in
                    self.server!.reconnect()
                    self.dismiss(animated: true, completion: nil)
                })
                reconnectPrompt.addAction(reconnect)
                
                let dontReconnectTitle = NSLocalizedString("DONT_RECONNECT", comment: "")
                let dontReconnect = UIAlertAction(title: dontReconnectTitle, style: .cancel, handler: { a in
                    self.dismiss(animated: true, completion: nil)
                })
                reconnectPrompt.addAction(dontReconnect)
                
                present(reconnectPrompt, animated: true, completion: nil)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
}