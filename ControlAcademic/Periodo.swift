//
//  Periodo.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Periodo: Object{
    dynamic var cod: String!
    dynamic var numero: String!
    dynamic var fechaini: String!
    dynamic var fechafin: String!
    var estado: Int!
    
    func periodoFromJson(_ json:JSON)-> Periodo{
        let periodo = Periodo()
        
        periodo.cod = json["cod"].stringValue
        periodo.numero = json["numero"].stringValue
        periodo.fechaini = json["fechaini"].stringValue
        periodo.fechafin = json["fechafin"].stringValue
        periodo.estado = json["estado"].intValue
        
        return periodo
    }
    
}
