//
//  AcademicoController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import DropDown
import NVActivityIndicatorView

class AcademicoController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var periodoLabel: UILabel!
    
    @IBOutlet var studentAvgLabel: UILabel!
    
    @IBOutlet var classGeneralLabel: UILabel!
    
    @IBOutlet var studentProgressBar: UIProgressView!

    @IBOutlet var generalProgressBar: UIProgressView!
    
    @IBOutlet var tableView: UITableView!
    var periodos = [Periodo]()
    var currentPeriod = Periodo()
    var asignaturas = [Asignatura]()
    var nombrePeriodos = [String]()
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBar()
        dropDown.anchorView = self.periodoLabel
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showPeriods(_:)))
        self.periodoLabel.addGestureRecognizer(tap)
        self.periodoLabel.isUserInteractionEnabled = true
        
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        self.studentProgressBar.transform = transform
        self.generalProgressBar.transform = transform
        self.startAnimating(message: "Cargando...", type: NVActivityIndicatorType.ballClipRotateMultiple)
        
        DataService.sharedInstance.loadPeriods { (error, periodos) in
            if let e = error{
                print(e)
            }else{
                self.periodos = periodos!
                self.currentPeriod = self.periodos[0]
                DataService.sharedInstance.loadAverage(self.currentPeriod.cod, { (error, asignaturas) in
                    self.stopAnimating()
                    if let e = error{
                        print(e)
                    }else{
                        self.asignaturas = asignaturas!
                        print(DataService.sharedInstance.promedios[0])
                        self.setGeneralAverage(DataService.sharedInstance.promedios[1].promedio)
                        self.setStudentAverage(DataService.sharedInstance.promedios[0].promedio)
                        
                        for p in periodos!{
                            self.nombrePeriodos.append(p.numero)
                        }
                        self.dropDown.dataSource = self.nombrePeriodos
                        self.periodoLabel.text = self.nombrePeriodos[0]
                        self.tableView.reloadData()
                        
                    }
                })
            }
        }
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.periodoLabel.text = item
            self.currentPeriod = self.periodos[index]
            self.startAnimating()
            DataService.sharedInstance.loadAverage(self.currentPeriod.cod, { (error, asignaturas) in
                if let e = error{
                    self.asignaturas = [Asignatura]()
                    self.studentProgressBar.isHidden = true
                    self.generalProgressBar.isHidden = true
                    self.studentAvgLabel.isHidden = true
                    self.classGeneralLabel.isHidden = true
                    self.tableView.reloadData()
                    self.stopAnimating()
                    print(e)
                }else{
                    self.studentProgressBar.isHidden = false
                    self.generalProgressBar.isHidden = false
                    self.studentAvgLabel.isHidden = false
                    self.classGeneralLabel.isHidden = false
                    self.asignaturas = asignaturas!
                    self.setGeneralAverage(DataService.sharedInstance.promedios[1].promedio)
                    self.setStudentAverage(DataService.sharedInstance.promedios[0].promedio)
                    self.tableView.reloadData()
                    self.stopAnimating()
                }
            })
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    //Supporting functions
    
    func setStudentAverage(_ average: Float){
        let sAverage = average / 10
        self.studentAvgLabel.text = "\(average)"
        self.studentProgressBar.progress = sAverage
        
    }
    
    func setGeneralAverage(_ average: Float){
        let gAverage = average / 10
        
        self.classGeneralLabel.text = "\(average)"
        self.generalProgressBar.progress = gAverage
    }
    
    func setRandomColor()-> UIColor{
        
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    }

    func showPeriods(_ tap: UIGestureRecognizer){
        self.dropDown.show()
    }
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Estado Académico"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
//        let messageButton = UIBarButtonItem(image: UIImage(named: "message"), style: .plain, target: self, action: nil)
                let updateButton = UIBarButtonItem(image: UIImage(named: "sync"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [updateButton]
        
    }
    
}

extension AcademicoController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detalle Nota VC") as! DetalleNotaController
        vc.asignatura = self.asignaturas[indexPath.row]
        vc.periodo = self.currentPeriod
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.asignaturas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Asignatura Cell") as! AsignaturaCell
        
        cell.config(self.asignaturas[indexPath.row], setRandomColor())
        
        return cell
    }
}
