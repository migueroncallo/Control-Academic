//
//  Asistencia.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/27/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Asistencia: Object{
    var cod: String!
    var fechahora: String!
    var codtutoria: String!
    var codtipoasistencia: Int!
    var updatedday: String!
    var codgradocurso: Int!
    var descripcion: String!
    var codestudiante: String!
    var codestumatricula: String!
    var tipo: Int!
    var codasignatura: String!
    var nombre: String!
    var excusas: Int!
    
    func asistenciaFromJson(_ json: JSON) -> Asistencia{
        let a = Asistencia()
        
        a.cod = json["cod"].stringValue
        a.fechahora = json["fechahora"].stringValue
        a.codtutoria = json["codtutoria"].stringValue
        a.codtipoasistencia = json["codtipoasistencia"].intValue
        a.updatedday = json["updatedday"].stringValue
        a.codgradocurso = json["codgradocurso"].intValue
        a.descripcion = json["descripcion"].stringValue
        a.codestudiante = json["codestudiante"].stringValue
        a.codestumatricula = json["codestumatricula"].stringValue
        a.tipo = json["tipo"].intValue
        a.codasignatura = json["codasignatura"].stringValue
        a.nombre = json["nombre"].stringValue
        a.excusas = json["excusas"].intValue
        
        return a
    }
}


//COD
//2 = llego tarde amarillo
//3 = no asisito rojo
//4 = excusa morado

