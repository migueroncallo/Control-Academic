//
//  AsignaturaDimVal.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class AsignaturaDimVal: Object{
    
    dynamic var codasignatura: String!
    dynamic var nombre: String!
    dynamic var codgrado: String!
    var procesos = List<ProcesoDimVal>()
    
    func asignaturaFromJson(_ json: JSON) -> AsignaturaDimVal{
        let a = AsignaturaDimVal()
        
        a.codasignatura = json["codasignatura"].stringValue
        a.nombre = json["nombre"].stringValue
        a.codgrado = json["codgrado"].stringValue
        for  (_,subJson):(String, JSON) in json["procesos"] {
            a.procesos.append(ProcesoDimVal().procesoFromJson(subJson))
        }
        
        return a
    }
    
//    "codasignatura": "8",
//    "nombre": "Lengua Castellana",
//    "codgrado": "3",
//    "procesos"
}


class ProcesoDimVal: Object{
    
    dynamic var cod: String!
    dynamic var nombre: String!
    dynamic var codperiodo: String!
    dynamic var codasignatura: String!
    dynamic var codgrado: String!
    var subprocesos = List<SubProcesoDimVal>()
    
    func procesoFromJson(_ json: JSON) -> ProcesoDimVal{
        let p = ProcesoDimVal()
        
        p.cod = json["cod"].stringValue
        p.nombre = json["nombre"].stringValue
        p.codperiodo = json["codperiodo"].stringValue
        p.codasignatura = json["codasignatura"].stringValue
        p.codgrado = json["codgrado"].stringValue
        
        for  (_,subJson):(String, JSON) in json["subprocesos"] {
            p.subprocesos.append(SubProcesoDimVal().subProcesoFromJson(subJson))
        }
        
        return p
    }
    
//    "cod": "356",
//    "nombre": "Desarrollar la atención, concentración,percepción y memoria para afianzar su expresión oral y habilidades motora fina.",
//    "codperiodo": "6",
//    "codasignatura": "8",
//    "codgrado": "3",
//    "subprocesos
    
}

class SubProcesoDimVal: Object{
    
    dynamic var cod: String!
    dynamic var nombre: String!
    dynamic var codprocesodim: String!
    dynamic var conse: String!
    dynamic var abr: String!
    dynamic var hex: String!
    
    func subProcesoFromJson(_ json: JSON)-> SubProcesoDimVal{
        let s = SubProcesoDimVal()
        
        s.cod = json["cod"].stringValue
        s.nombre = json["nombre"].stringValue
        s.codprocesodim = json["codprocesosdim"].stringValue
        s.conse = json["conse"].stringValue
        
        s.abr = json["abr"].stringValue
        s.hex = json["hex"].stringValue
        
        return s
    }
    
//    cod": "931",
//    "nombre": "Discrimina, escribe palabras y frases sencillas con los fonemas estudiados.",
//    "codprocesosdim": "356",
//    "conse": "4",
//    "nombreDimen": null,
//    "abr": "LA",
//    "coddimenval": null,
//    "color": null,
//    "gano": null,
//    "hex": "#DF7401",
//    "nombreColor": "Naranja"
}
