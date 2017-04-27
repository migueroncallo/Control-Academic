//
//  DimValController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import DropDown

class DimValController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var periodoLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    let dropDown = DropDown()

    var asignaturas = [AsignaturaDimVal]()
    var periodos = [Periodo]()
    var periodosString = [String]()
    var currentPeriod = Periodo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = periodoLabel
        dropDown.direction = .bottom
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showDropDown(_:)))
        
        periodoLabel.addGestureRecognizer(tap)
        periodoLabel.isUserInteractionEnabled = true
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        
        self.startAnimating(message: "Cargando", type: NVActivityIndicatorType.ballClipRotate)
        
        DataService.sharedInstance.loadPeriods { (Error, Periodos) in
            if let e = Error{
                self.stopAnimating()
                print(e)
            }else{
                self.periodos = Periodos!
                for p in Periodos!{
                    self.periodosString.append(p.numero)
                }
                self.dropDown.dataSource = self.periodosString
                DataService.sharedInstance.loadDimVal(Periodos![0].cod, { (error, asignaturas) in
                    if let e = error{
                        self.stopAnimating()
                        print(e)
                    }else{
                        print("Loaded")
                        self.asignaturas = asignaturas!
                        self.tableView.reloadData()
                        self.stopAnimating()
                    }
                })
            }
        }
        
        self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.periodoLabel.text = item
            self.currentPeriod = self.periodos[index]
            self.startAnimating()
            DataService.sharedInstance.loadDimVal(self.currentPeriod.cod, { (error, asignaturas) in
                if let e = error{
                    self.stopAnimating()
                    print(e)
                }else{
                    
                    self.asignaturas = asignaturas!
                    self.tableView.reloadData()
                    self.stopAnimating()
                }
            })
            
        }
        
    }
    
    //MARK: Supporting functions
    
    func showDropDown(_ tap: UIGestureRecognizer){
        dropDown.show()
    }
}


extension DimValController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asignaturas[section].procesos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return asignaturas.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DimVal Cell") as! DimValCell
        
        
        cell.config(asignaturas[indexPath.section].procesos[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Header Cell") as! DimValHeaderCell
        
        
        cell.config(asignaturas[section])
        cell.contentView.backgroundColor = UIColor.white
        
        
        return cell.contentView
    }
}
