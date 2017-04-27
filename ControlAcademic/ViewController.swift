//
//  ViewController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 1/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import DropDown
import NVActivityIndicatorView


class ViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var departamentoSelectedLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var colegioSelectedLabel: UILabel!
    
    let dropDown = DropDown()
    let dropDownColegio = DropDown()
    let defaults = UserDefaults.standard
    var codDepartamentoSelected: Int!
    var nomDepartamentoSelected: String!
    var codColSelected: Int!
    var nomColSelected: String!
    var linkColSelected: String!
    var colSelected: Colegio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colegioSelectedLabel.isHidden = true
        self.nextButton.isEnabled = false
        
        dropDown.anchorView = departamentoSelectedLabel
        // Do any additional setup after loading the view, typically from a nib.
        
        DataService.sharedInstance.loadDepartmens { (error, dptos) in
            if let e = error{
                print(e)
            }else{
                
                var dNames = [String]()
                for d in dptos!{
                    print(d.cod)
                    dNames.append(d.nombre)
                
                }
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectDepartment(_:)))
                self.departamentoSelectedLabel.addGestureRecognizer(tap)
                self.departamentoSelectedLabel.isUserInteractionEnabled = true
                self.dropDown.dataSource = dNames
                
            }
        }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.departamentoSelectedLabel.text = item
            print(DataService.sharedInstance.departamentos[index].nombre)
            print(DataService.sharedInstance.departamentos[index].cod)
            self.codDepartamentoSelected = Int(DataService.sharedInstance.departamentos[index].cod)
            self.nomDepartamentoSelected = DataService.sharedInstance.departamentos[index].nombre
            
            self.startAnimating(message: "Colegios", type: .ballClipRotate)
            
            DataService.sharedInstance.loadColegios(DataService.sharedInstance.departamentos[index].cod, cb: { (error, colegios) in
                
                self.stopAnimating()
                
                
                if let e = error{
                    print(e)
                }else{
                    
                    var cNames = [String]()
                    for c in colegios!{
                        cNames.append(c.nombre)
                    }
                    self.colegioSelectedLabel.isHidden = false
                    self.dropDownColegio.anchorView = self.colegioSelectedLabel
                    
                    let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.selectSchool(_:)))
                    self.colegioSelectedLabel.addGestureRecognizer(tap2)
                    self.colegioSelectedLabel.isUserInteractionEnabled = true

                    self.dropDownColegio.dataSource = cNames
                    self.dropDownColegio.direction = .bottom
                    
                    self.dropDownColegio.selectionAction = {[unowned self] (index: Int, item: String) in
                        self.colegioSelectedLabel.text = item
                        self.codColSelected = Int(colegios![index].cod)
                        self.nomColSelected = colegios![index].nombre
                        self.linkColSelected = colegios![index].link
                        DataService.sharedInstance.colegioSelected = colegios![index]
                        self.nextButton.isEnabled = true
                    }
                }
                
                
            })
            
        }
        
    }
    
    @IBAction func seleccionarDepartamento(_ sender: UIButton) {
        
        defaults.set(self.codDepartamentoSelected, forKey: "codDepartamento")
        defaults.set(self.nomDepartamentoSelected, forKey: "nomDepartamento")
        defaults.set(self.codColSelected, forKey: "codColegio")
        defaults.set(self.nomColSelected, forKey: "nomColegio")
        defaults.set(self.linkColSelected, forKey: "linkColegio")
     
        print("Next Screen")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Log in VC") as! LogInController
        
        AppDelegate.getDelegate().window?.rootViewController = vc
        
    }
    

    //Supporting functions 
    
    func selectDepartment(_ sender: UIGestureRecognizer){
        
        self.dropDown.show()
    }
    
    func selectSchool(_ sender: UIGestureRecognizer){
        
        self.dropDownColegio.show()
    }

}

