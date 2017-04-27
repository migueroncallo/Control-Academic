//
//  Horario.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Horario: Object{
    var dia: Int!
    var orden: Int!
    dynamic var horaini: String!
    dynamic var horafin: String!
    var codtipohora: Int!
    dynamic var asignatura: String?
    dynamic var docente: String?
    
    func horarioFromJson(_ json: JSON)->Horario{
        let horario = Horario()
        
        horario.dia = json["dia"].intValue
        horario.orden = json["orden"].intValue
        horario.horaini = json["horaini"].stringValue
        horario.horafin = json["horafin"].stringValue
        horario.codtipohora = json["codtipohora"].intValue
        
        if let d = json["docente"].string{
            horario.docente = d
        }
        
        if let a = json["asignatura"].string{
            horario.asignatura = a
        }
        
        return horario
    }
    
}
