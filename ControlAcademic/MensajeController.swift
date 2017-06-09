//
//  MensajeController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/31/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MensajeController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    var mensajes = [Mensaje]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarItem()

        tableView.tableFooterView = UIView()
        self.setNavigationBar()
        self.startAnimating(message: "Cargando...", type: NVActivityIndicatorType.cubeTransition)
        
        DataService.sharedInstance.loadMessages(1) { (error, mensajes) in
            if let e = error{
                
                self.tableView.reloadData()
                self.stopAnimating()
                print(e)
            }else{
                
                self.mensajes = mensajes!
                self.tableView.reloadData()
                self.stopAnimating()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    //Segmented Control actions
    
    @IBAction func selectFolder(_ sender: UISegmentedControl) {
        
        changeFolder(sender.selectedSegmentIndex + 1)
        
        
    }
    

    //Supporting functions
    
    func setNavigationBar(){
        

        let titleLabel = UILabel()
        titleLabel.text = "Bandeja de Entrada"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: nil)
        
        let messageButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(self.newMessage(_:)))
        
        self.navigationItem.rightBarButtonItems = [messageButton]

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
    }
    
    func newMessage(_ sender: UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Create Message VC") as! MessageCreateController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func changeFolder(_ folder: Int){
        
        switch folder {
        case 1:
            setNavigationBar()
            break
        case 2:
            let titleLabel = UILabel()
            titleLabel.text = "Enviados"
            titleLabel.sizeToFit()
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        case 3:
            let titleLabel = UILabel()
            titleLabel.text = "Favoritos"
            titleLabel.sizeToFit()
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        case 4:
            let titleLabel = UILabel()
            titleLabel.text = "Eliminados"
            titleLabel.sizeToFit()
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        case 5:
            let titleLabel = UILabel()
            titleLabel.text = "Borradores"
            titleLabel.sizeToFit()
            titleLabel.textColor = UIColor.white
            
            self.navigationItem.titleView = titleLabel
            
        default:
            break
        }
        DataService.sharedInstance.loadMessages(folder) { (error, mensajes) in
            if let e = error{
                self.mensajes = [Mensaje]()
                self.tableView.reloadData()
                self.stopAnimating()
                print(e)
            }else{
                
                self.mensajes = mensajes!
                self.tableView.reloadData()

                self.stopAnimating()
            }
        }
    }

}

extension MensajeController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Message Detail VC") as! MessageDetailController
        
        vc.message = self.mensajes[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mensajes.count == 0{
            self.warningLabel.isHidden = false
            self.tableView.isHidden = true
        }else{
            self.warningLabel.isHidden = true
            self.tableView.isHidden = false
        }
        
        return self.mensajes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Mensaje Cell") as! MensajeCell
        
        cell.config(self.mensajes[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
