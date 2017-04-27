//
//  DetalleNotaController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/27/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class DetalleNotaController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var asignaturaLabel: UILabel!
    
    @IBOutlet var docenteLabel: UILabel!
    
    @IBOutlet var notaLabel: UILabel!
    
    var asignatura: Asignatura!
    var procesos = [Proceso]()
    var periodo: Periodo!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 88.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.setNavigationBar()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.startAnimating(message: "Cargando...", type: NVActivityIndicatorType.ballZigZagDeflect)
        self.asignaturaLabel.text = "Asignatura: \(self.asignatura.nombreasignatura!)"
        self.docenteLabel.text = "Docente: \(self.asignatura.docente!)"
        self.notaLabel.text = "Nota: \(self.asignatura.notaasignatura!)"
        DataService.sharedInstance.loadNoteDetail(self.periodo.cod, DataService.sharedInstance.studentSelected.codgradocurso, self.asignatura.codgradoasig) { (error, procesos) in
            if let e = error{
                self.stopAnimating()
                print(e)
            }else{
                self.procesos = procesos!
                self.tableView.reloadData()
                self.stopAnimating()
            }
        }
        // Do any additional setup after loading the view.
    }

    //Supporting functions
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Detalle de nota"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
    }

    
}

extension DetalleNotaController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(self.procesos[section].subprocesos).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Subproceso Cell") as! SubProcesoCell
        
        cell.config(self.procesos[indexPath.section].subprocesos[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Número de procesos: \(self.procesos.count)")
        return self.procesos.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Proceso Cell") as! ProcesoCell
        
        cell.config(self.procesos[section])
        
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
