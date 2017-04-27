
//
//  MainMenuCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class MainMenuCell: UITableViewCell {
    @IBOutlet var menuOptionLabel: UILabel!
    
    @IBOutlet var menuOptionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func config(_ modulo: Modulo){
        
        
        switch modulo.nombre {
        case "academico":
            //academico
            self.menuOptionLabel.text = "Estado Académico"
            self.menuOptionImage.image = UIImage(named: "grafico")
            break
        case "agenda":
            self.menuOptionLabel.text = "Agenda"
            self.menuOptionImage.image = UIImage(named: "calendarioFecha")
            break
        case "asistencia":
            //asistencia
            self.menuOptionLabel.text = "Asistencia"
            self.menuOptionImage.image = UIImage(named: "check")
            break
        case "excusas":
            //excusas
            self.menuOptionLabel.text = "Excusas"
            self.menuOptionImage.image = UIImage(named: "documento")
            break
        case "horario":
            //horario
            self.menuOptionLabel.text = "Horario"
            self.menuOptionImage.image = UIImage(named: "calendario")
            break
        case "incidentes":
            //incidentes
            self.menuOptionLabel.text = "Incidentes"
            self.menuOptionImage.image = UIImage(named: "ojo")
            break
        case "mensajeria":
            //mensajería
            self.menuOptionLabel.text = "Mensajería"
            self.menuOptionImage.image = UIImage(named: "correo")
            break
        case "tesoreria":
            //tesorería
            self.menuOptionLabel.text = "Tesorería"
            self.menuOptionImage.image = UIImage(named: "pago")
            break
        case "controlfood":
            self.menuOptionLabel.text = "Tienda Virtual"
            self.menuOptionImage.image = UIImage(named: "tienda")
            break
        default:
            self.menuOptionLabel.text = modulo.nombre
        }
        
    }
    
    func config2(_ modulo: Modulo){
        
        
        switch modulo.nombre {
        case "academico":
            //academico
            self.menuOptionLabel.text = "Estado Académico"
            self.menuOptionImage.image = UIImage(named: "chart")
            break
        case "agenda":
            self.menuOptionLabel.text = "Agenda"
            self.menuOptionImage.image = UIImage(named: "calendarDate")
            break
        case "asistencia":
            //asistencia
            self.menuOptionLabel.text = "Asistencia"
            self.menuOptionImage.image = UIImage(named: "spellcheck")
            break
        case "excusas":
            //excusas
            self.menuOptionLabel.text = "Excusas"
            self.menuOptionImage.image = UIImage(named: "docs")
            break
        case "horario":
            //horario
            self.menuOptionLabel.text = "Horario"
            self.menuOptionImage.image = UIImage(named: "calendar")
            break
        case "incidentes":
            //incidentes
            self.menuOptionLabel.text = "Incidentes"
            self.menuOptionImage.image = UIImage(named: "eye")
            break
        case "mensajeria":
            //mensajería
            self.menuOptionLabel.text = "Mensajería"
            self.menuOptionImage.image = UIImage(named: "email")
            break
        case "tesoreria":
            //tesorería
            self.menuOptionLabel.text = "Tesorería"
            self.menuOptionImage.image = UIImage(named: "money")
            break
        case "controlfood":
            self.menuOptionLabel.text = "Tienda Virtual"
            self.menuOptionImage.image = UIImage(named: "store")
            break
        default:
            self.menuOptionLabel.text = modulo.nombre
        }
        
    }
    
    
}
