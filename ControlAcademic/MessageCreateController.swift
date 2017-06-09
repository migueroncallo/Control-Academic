//
//  MessageCreateController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/7/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import DropDown
import NVActivityIndicatorView

class MessageCreateController: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet var fromLabel: UILabel!
    
    @IBOutlet weak var externalSwitch: UISwitch!

    @IBOutlet var addContactsButton: UIButton!
    
    @IBOutlet var subjectTextField: UITextField!
    
    @IBOutlet var messageTextView: UITextView!
    
    var contactos = [Contacto]()
    var destinatario = [Contacto]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        if DataService.sharedInstance.contacts.count > 0{
            self.contactos = DataService.sharedInstance.contacts
        }else{
            loadContacts()
        }
        
        
        fromLabel.text = DataService.sharedInstance.currentUser.nombres + " " + DataService.sharedInstance.currentUser.apellidos
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        destinatario = DataService.sharedInstance.destinatario
        
        print(destinatario.count)
        if destinatario.count > 0{
            if destinatario.count < 7{
                var destinatarios = ""
                for d in destinatario{
                    destinatarios = destinatarios + "\(d.nombres!),"
                }
                addContactsButton.setTitle(destinatarios, for: .normal)
            }
        }else{
           addContactsButton.setTitle("Añadir contactos", for: .normal) 
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DataService.sharedInstance.destinatario.removeAll()
    }

    //MARK: Supporting actions
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Nuevo Mensaje"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
        let messageButton = UIBarButtonItem(image: UIImage(named: "message"), style: .plain, target: self, action: #selector(self.sendMessage(_:)))
        self.navigationItem.rightBarButtonItems = [messageButton]
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func sendMessage(_ sender: UIBarButtonItem){
        
        print("Send Message")
        
        if checkData(){
            var receptor: String! = ""
            for d in destinatario{
                receptor = receptor + "\(d.cod!),"
            }
            
            var tipo = "1"
            if externalSwitch.isOn{
                tipo = "2"
            }
        DataService.sharedInstance.sendMessage(subjectTextField.text!, "", receptor, messageTextView.text, tipo, cb: {success in
            if success{
                self.navigationController?.popViewController(animated: true)
                
            }else{
                self.displayMessage("Error", message: "Error al enviar el mensaje")
            }
        })
        }
       
    }
    
    func loadContacts(){
    
        self.startAnimating(message: "Cargando contactos", type: NVActivityIndicatorType.ballClipRotate)
        
        DataService.sharedInstance.getContacts { (error, contactos) in
            
            if let e = error{
                self.stopAnimating()
                print(e)
            }else{
                self.contactos = contactos!
                self.stopAnimating()
            }
        }
    }
    
    
    func checkData() -> Bool{
        if subjectTextField.text!.isEmpty || self.destinatario.count == 0 || messageTextView.text.isEmpty{
            
            self.displayMessage("Control Academic", message: "Todos los campos son requeridos para enviar el mensaje")
            
            return false
        }
        
        return true
    }
    
    //MARK: Button Actions
    
    @IBAction func addContacts(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Contacts VC") as! ContactsController
        
        vc.contactos = self.contactos
        vc.seleccionados = self.destinatario
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
 
}

extension UIViewController{
    func displayMessage(_ title: String?,message :String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultaction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(defaultaction)
        present(alert, animated: true, completion: nil)
    }
}
