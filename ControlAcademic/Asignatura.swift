//
//  Asignatura.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/15/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Asignatura: Object{
    
    dynamic var codgradoasig: String!
    dynamic var nombreasignatura: String!
    dynamic var abrasignatura: String!
    dynamic var docente: String!
    var notaasignatura: Double!
    
    func asignaturaFromJson(_ json: JSON) -> Asignatura{
        let asignatura = Asignatura()
        
        asignatura.codgradoasig = json["codgradosasig"].stringValue
        asignatura.nombreasignatura = json["nombreasignatura"].stringValue
        asignatura.abrasignatura = json["abrasignatura"].stringValue
        asignatura.docente = json["docente"].stringValue
        asignatura.notaasignatura = json["notaasignatura"].doubleValue
        
        return asignatura
    }
}



