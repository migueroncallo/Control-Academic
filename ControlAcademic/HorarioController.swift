//
//  HorarioController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HorarioController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var lunes = [Horario]()
    var martes = [Horario]()
    var miercoles = [Horario]()
    var jueves = [Horario]()
    var viernes = [Horario]()
    var horario = [Horario]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBar()
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.startAnimating(message: "Horario", type: NVActivityIndicatorType.ballGridBeat)
        
        DataService.sharedInstance.loadSchedule { (error, horario) in
            
            if let e = error{
                self.stopAnimating()
                print(e)
            }else{
                for h in horario!{
                    switch h.dia{
                    case 1:
                        self.lunes.append(h)
                    case 2:
                        self.martes.append(h)
                    case 3:
                        self.miercoles.append(h)
                    case 4:
                        self.jueves.append(h)
                    case 5:
                        self.viernes.append(h)
                    default:
                        break
                    }
                }
                
                self.horario = self.lunes
                self.tableView.reloadData()
                self.stopAnimating()
            }
            
        }
        
    }
    //Button actions
    
    @IBAction func switchDay(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //lunes
            print("Lunes")
            self.horario = self.lunes
            
        case 1:
            //martes
            print("Martes")
            self.horario = self.martes
            
        case 2:
            //miércoles
            print("Miércoles")
            self.horario = self.miercoles
            
        case 3:
            //jueves
            print("Jueves")
            self.horario = self.jueves
        case 4:
            //viernes
            print("Viernes")
            self.horario = self.viernes
            
        default:
            break
        }
        
        self.tableView.reloadData()
    }
    
    //Supporting functions
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Horario"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
        let syncButton = UIBarButtonItem(image: UIImage(named: "sync"), style: .plain, target: self, action: nil)
        //        let notificationButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [syncButton]
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
}

extension HorarioController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return self.horario.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.horario[indexPath.row].codtipohora == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Recreo Cell") as! RecreoCell
            
            cell.config(self.horario[indexPath.row])
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Clase Cell") as! ClaseCell
        
        cell.config(self.horario[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
