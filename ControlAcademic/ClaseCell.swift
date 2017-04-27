
//
//  ClaseCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class ClaseCell: UITableViewCell {

    @IBOutlet var ordenLabel: UILabel!
    
    @IBOutlet var horaInicioLabel: UILabel!
    
    @IBOutlet var horaFinLabel: UILabel!
    
    @IBOutlet var asignaturaLabel: UILabel!
    
    @IBOutlet var profesorLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(_ horario: Horario){
        
        self.ordenLabel.text = "\(horario.orden!)"
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:MM:ss"
//        let dateStart = dateFormatter.date(from: horario.horaini)
//        
//        dateFormatter.dateFormat = "h:mm a"

//        self.horaInicioLabel.text = horario.horaini
        
        self.horaInicioLabel.text = horario.horaini
        self.horaFinLabel.text = horario.horafin
        if let a = horario.asignatura{
            self.asignaturaLabel.text = a
        }else{
            self.asignaturaLabel.text = ""
        }
        
        if let d = horario.docente{
            self.profesorLabel.text = d
        }else{
            self.profesorLabel.text = ""
        }
    }
}
