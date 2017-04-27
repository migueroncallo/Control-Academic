//
//  Departamentos.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 1/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON

class Departamentos{
    
    var cod: String!
    var nombre: String!
    
    
    func departamentoFromJson(_ json: JSON) -> Departamentos{
        let dpto = Departamentos()
        
        dpto.cod = json["cod"].stringValue
        dpto.nombre = json["nombre"].stringValue
        
        return dpto
    }
}
