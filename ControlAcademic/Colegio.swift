//
//  Colegio.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 1/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Colegio: Object{
    dynamic var cod: String!
    dynamic var nombre: String!
    dynamic var link: String!
    dynamic var codDepartamento: String!
    
    func colegioFromJson(_ json: JSON) -> Colegio{
        let colegio = Colegio()
        
        colegio.cod = json["cod"].stringValue
        colegio.nombre = json["nombre"].stringValue
        colegio.link = json["link"].stringValue
        colegio.codDepartamento = json ["coddepartamento"].stringValue
        
        return colegio
    }
}
