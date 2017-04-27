//
//  LeftMenuController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/31/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import Kingfisher

class LeftMenuController: UIViewController {

    var modulos = [Modulo]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var roleLabel: UILabel!
    
    @IBOutlet var userImageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        if DataService.sharedInstance.currentUser.urlimage != ""{
            userImageLabel.kf.setImage(with: URL(string:DataService.sharedInstance.currentUser.urlimage)!)
        }
        nameLabel.text = DataService.sharedInstance.currentUser.nombres + " " + DataService.sharedInstance.currentUser.apellidos
        roleLabel.text = DataService.sharedInstance.currentUser.familiaridad
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.modulos = DataService.sharedInstance.modulos
        let m = Modulo()
        m.cod = 0
        m.nombre = "Cerrar Sesión"
        self.modulos.append(m)
        self.tableView.reloadData()
    }

    //Supporting functions
    func selectMenu(_ modulo: Modulo){
        
        var vc: UIViewController!
        switch modulo.nombre {
        case "academico":
            //academico
            vc = self.storyboard?.instantiateViewController(withIdentifier: "Academico VC") as! AcademicoController
            let academicVC = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(academicVC, close: true)
            break
        case "agenda":
            //agenda
            break
        case "asistencia":
            //asistencia
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Asistencia VC") as! AsistenciasController
            let asistenciaVC = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(asistenciaVC, close: true)
            break
        case "excusas":
            //excusas
            break
        case "horario":
            //horario
            vc = self.storyboard?.instantiateViewController(withIdentifier: "Horario VC") as! HorarioController
            let horarioVC = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(horarioVC, close: true)
            break
        case "incidentes":
            //incidentes
            break
        case "mensajeria":
            //mensajería
            
            vc = self.storyboard?.instantiateViewController(withIdentifier: "Mensajes VC") as! MensajeController
            let mensajeriaVC = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(mensajeriaVC, close: true)
            break
        case "tesoreria":
            //tesorería
            break
        case "Cerrar Sesión":
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Departamento VC") as! ViewController
            UIApplication.shared.keyWindow?.rootViewController = vc

            DataService.sharedInstance.logout {
            }
        default:
            break
        }
        
    }
}

extension LeftMenuController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.selectMenu(self.modulos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modulos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Left Menu Cell") as! MainMenuCell
        
        cell.config2(self.modulos[indexPath.row])
        
        return cell
    }
}
