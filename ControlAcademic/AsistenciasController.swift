//
//  AsistenciasController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher

class AsistenciasController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet var studentNameLabel: UILabel!
    
    @IBOutlet var studentClassLabel: UILabel!
    
    @IBOutlet var missedClassLabel: UILabel!
    
    @IBOutlet var lateClassLabel: UILabel!
    
    @IBOutlet var excusesLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var studentImage: UIImageView!
    
    
    var inasistenciasCount = 0
    var llegadasTardeCount = 0
    var excusasCount = 0
    
    var faltas = [Asistencia]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        tableView.tableFooterView = UIView()
        
        
        if DataService.sharedInstance.studentSelected.path != ""{
            studentImage.kf.setImage(with: URL(string: DataService.sharedInstance.studentSelected.path)!)
        }
        
        self.startAnimating(message: "Cargando", type: NVActivityIndicatorType.ballScaleRipple)
        DataService.sharedInstance.loadAsistance { (error, asistencias) in
            if let e = error{
                self.stopAnimating()
                self.studentNameLabel.text = "\(DataService.sharedInstance.studentSelected.primernombre!) \(DataService.sharedInstance.studentSelected.segundonombre!) \(DataService.sharedInstance.studentSelected.primerapellido!) \(DataService.sharedInstance.studentSelected.segundoapellido!)"
                self.studentClassLabel.text = DataService.sharedInstance.studentSelected.descripcion
                
                self.excusesLabel.text = "Excusas \n\(self.excusasCount)"
                self.lateClassLabel.text = "Llegadas tarde \n\(self.llegadasTardeCount)"
                self.missedClassLabel.text = "No asistió \n\(self.inasistenciasCount)"
                
                self.tableView.reloadData()

                print(e)
            }else{
                self.faltas = asistencias!
                for f in self.faltas{
                    switch f.codtipoasistencia {
                    case 2:
                        //Llegada tarde
                        self.llegadasTardeCount += 1
                    case 3:
                        //No asistió
                        self.inasistenciasCount += 1
                    case 4:
                        //Excusa
                        self.excusasCount += 1
                    default:
                        break
                    }
                }
                
                self.studentNameLabel.text = "\(DataService.sharedInstance.studentSelected.primernombre!) \(DataService.sharedInstance.studentSelected.segundonombre!) \(DataService.sharedInstance.studentSelected.primerapellido!) \(DataService.sharedInstance.studentSelected.segundoapellido!)"
                self.studentClassLabel.text = DataService.sharedInstance.studentSelected.descripcion
                
                self.excusesLabel.text = "Excusas \n\(self.excusasCount)"
                self.lateClassLabel.text = "Llegadas tarde \n\(self.llegadasTardeCount)"
                self.missedClassLabel.text = "No asistió \n\(self.inasistenciasCount)"
                
                self.tableView.reloadData()
                self.stopAnimating()
            }
        }
        
    }

    //Supporting functions
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Asistencia"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
//        let syncButton = UIBarButtonItem(image: UIImage(named: "sync"), style: .plain, target: self, action: nil)
        //        let notificationButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
//        self.navigationItem.rightBarButtonItems = [syncButton]
        
        self.tabBarController?.tabBar.isHidden = true
    }

}

extension AsistenciasController: UITableViewDelegate, UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.faltas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Asistencias Cell") as! AsistenciaCell
        
        cell.config(faltas[indexPath.row])
        
        return cell
    }
}
