//
//  AsistenciaCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class AsistenciaCell: UITableViewCell {

    @IBOutlet var typeFaultLabel: UILabel!
    
    @IBOutlet var dateFaultLabel: UILabel!
    
    @IBOutlet var subjectFaultLabel: UILabel!
    
    @IBOutlet var typeFaultView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func config(_ falta: Asistencia){
        switch falta.codtipoasistencia{
        case 2:
            //Llegada tarde
            self.typeFaultView.backgroundColor = UIColor(red: 1, green: 200/255, blue: 41/255, alpha: 1)
            self.typeFaultLabel.textColor = UIColor(red: 1, green: 200/255, blue: 41/255, alpha: 1)
            self.typeFaultLabel.text = "Llegó tarde"
            self.dateFaultLabel.text = falta.fechahora
            self.subjectFaultLabel.text = falta.nombre
            
        case 3:
            //No asistió
            self.typeFaultView.backgroundColor = UIColor(red: 231/255, green: 115/255, blue: 113/255, alpha: 1)
            self.typeFaultLabel.textColor =  UIColor(red: 231/255, green: 115/255, blue: 113/255, alpha: 1)
            self.typeFaultLabel.text = "Inasistencia"
            self.dateFaultLabel.text = falta.fechahora
            self.subjectFaultLabel.text = falta.nombre
            
        case 4:
            //Excusa
            self.typeFaultView.backgroundColor = UIColor(red: 93/255, green: 52/255, blue: 180/255, alpha: 1)
            self.typeFaultLabel.textColor = UIColor(red: 93/255, green: 52/255, blue: 180/255, alpha: 1)
            self.typeFaultLabel.text = "Excusa"
            self.dateFaultLabel.text = falta.fechahora
            self.subjectFaultLabel.text = falta.nombre
            
        default:
            break
        }
    }

}
