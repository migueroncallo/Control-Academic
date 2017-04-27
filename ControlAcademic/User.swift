//
//  User.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/9/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class User: Object{
    dynamic var cod = ""
    dynamic var usuario = ""
    dynamic var nombres = ""
    dynamic var apellidos = ""
    dynamic var email = ""
    dynamic var codtipousuario = ""
    dynamic var urlimage = ""
    dynamic var familiaridad = ""
    
    func userFromJson(_ json: JSON) -> User{
        let user = User()
        
        user.cod = json["cod"].stringValue
        user.usuario = json["usuario"].stringValue
        user.nombres = json["nombres"].stringValue
        user.apellidos = json["apellidos"].stringValue
        user.email = json["email"].stringValue
        user.codtipousuario = json["codtipousuario"].stringValue
        user.urlimage = json["url_image"].stringValue
        user.familiaridad = json["familiaridad"].stringValue
        
        return user
    }
}

//o	cod: "1777",
//o	identificacion: null,
//o	usuario: "72233545",
//o	pass: null,
//o	nombres: "CARLOS ANDRES",
//o	apellidos: "FERRER GUZMAN",
//o	email: " ",
//o	codtipousuario: "6",
//o	url_image: "",
//o	familiaridad: "Padre"
