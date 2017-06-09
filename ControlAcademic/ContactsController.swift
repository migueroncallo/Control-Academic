//
//  ContactsController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class ContactsController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var searchActive = false
    
    var contactos: [Contacto]!
    
    var filtered = [Contacto]()
    
    var seleccionados: [Contacto]!
    
    var timer: Timer? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save(_:)))
        self.navigationItem.rightBarButtonItem = saveButton

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        for s in seleccionados{
            DataService.sharedInstance.destinatario.append(s)

        }
    }
    //MARK: Button actions

    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func save(_ sender: UIBarButtonItem){
        seleccionados.removeAll()
        for i in self.tableView.indexPathsForSelectedRows!{
            seleccionados.append(contactos[i.row])
        }
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: Supporting functions
    
    func preSearch(_ timer: Timer){
        
        filtered = contactos.filter({ (contacto) -> Bool in
            
            let range1 = contacto.nombres.range(of: searchBar.text!,   options:NSString.CompareOptions.caseInsensitive)
            let range2 = contacto.apellidos.range(of: searchBar.text!,   options:NSString.CompareOptions.caseInsensitive)
            
            
            
            return range1 != nil || range2 != nil
            
        })
        
        print(filtered)
        
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
}

extension ContactsController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        if !searchActive{
//            if seleccionados.contains(where: { (contacto) -> Bool in
//                contacto === contactos[indexPath.row]
//            }){
//                for i in 0..<seleccionados.count  {
//                    if seleccionados[i] === contactos[indexPath.row]{
//                        seleccionados.remove(at: i)
//                        print("Contacto eliminado")
//                        
//                    }
//                }
//            }else{
//                seleccionados.append(contactos[indexPath.row])
//                print("Contacto añadido")
//            }
//        }else{
//            if seleccionados.contains(where: { (contacto) -> Bool in
//                contacto === filtered[indexPath.row]
//            }){
//                for i in 0..<seleccionados.count  {
//                    if seleccionados[i] === filtered[indexPath.row]{
//                        seleccionados.remove(at: i)
//                        print("Contacto eliminado")
//                        
//                    }
//                }
//            }else{
//                seleccionados.append(filtered[indexPath.row])
//                print("Contacto añadido")
//            }
//        }
//        let cell  = tableView.cellForRow(at: indexPath) as! ContactCell
//
//        
//        DispatchQueue.main.async {
//            if self.searchActive{
//                cell.config(self.filtered[indexPath.row])
//            }else{
//                cell.config(self.contactos[indexPath.row])
//            }
//        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filtered.count
        }
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts Cell") as! ContactCell
        
        
        if searchActive{
            cell.config(filtered[indexPath.row])
            
            if seleccionados.contains(where: { (contacto) -> Bool in
                contacto === filtered[indexPath.row]
            }){
                cell.isContact = true
                print("Tiene contacto")
            }else{
                print("NO tiene contacto")
                cell.isContact = false
            }
        }else{
            cell.config(contactos[indexPath.row])
            
            if seleccionados.contains(where: { (contacto) -> Bool in
                contacto === contactos[indexPath.row]
            }){
                cell.isContact = true
                print("Tiene contacto")
            }else{
                print("NO tiene contacto")
                cell.isContact = false
            }
        }
        
        
        
        return cell
    }
    
}

extension ContactsController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.filtered.removeAll()
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchBar.text!.isEmpty{
            searchActive = true
           
            self.tableView.isHidden = true
            self.searchActive = true
            
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.preSearch(_:)), userInfo: searchBar, repeats: false)
        }else{
            
            print("empty searchbar")
            self.searchActive = false
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
    }
}
