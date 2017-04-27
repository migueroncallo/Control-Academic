//
//  Contacto.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/7/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON

class Contacto{
    var cod: String!
    var usuario: String!
    var nombres: String!
    var apellidos: String!
    
    func contactoFromJson(_ json: JSON) -> Contacto{
        let c = Contacto()
        
        c.cod = json["cod"].stringValue
        c.usuario = json["usuario"].stringValue
        c.nombres = json["nombres"].stringValue
        c.apellidos = json["apellidos"].stringValue
        
        return c
    }
}
