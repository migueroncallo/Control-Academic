//
//  Modulo.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Modulo: Object{
    
    var cod: Int!
    dynamic var nombre: String!
    
    func moduleFromJson(_ json: JSON) -> Modulo{
        let modulo = Modulo()
        
        modulo.cod = Int(json["cod"].stringValue)
        modulo.nombre = json["nombre"].stringValue
        
        return modulo
    }
}
