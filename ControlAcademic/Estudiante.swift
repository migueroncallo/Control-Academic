//
//  Estudiante.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Estudiante: Object{
    
    dynamic var codcurso: String!
    dynamic var codgrado: String!
    dynamic var codgradocurso: String!
    dynamic var descripcion: String!
    dynamic var codestudiante: String!
    dynamic var primerapellido: String!
    dynamic var segundoapellido: String!
    dynamic var primernombre: String!
    dynamic var segundonombre: String!
    dynamic var codestumatricula: String!
    dynamic var path: String!
    var tarde: Int!
    var excusa: Int!
    var nasistio: Int!
    dynamic var coddimenval: String!
    
    func studentFromJson(_ json: JSON)-> Estudiante{
        let student = Estudiante()
        
        student.codcurso = json["codcurso"].stringValue
        student.codgrado = json["codgrado"].stringValue
        student.codgradocurso = json["codgradocurso"].stringValue
        student.descripcion = json["descripcion"].stringValue
        student.codestudiante = json["codestudiante"].stringValue
        student.primerapellido = json["primerapellido"].stringValue
        student.segundoapellido = json["segundoapellido"].stringValue
        student.primernombre = json["primernombre"].stringValue
        student.segundonombre = json["segundonombre"].stringValue
        student.codestumatricula = json["codestumatricula"].stringValue
        student.path = json["path"].stringValue
        student.tarde = Int(json["tarde"].stringValue)
        student.excusa = Int(json["excusa"].stringValue)
        student.nasistio = Int(json["nasistio"].stringValue)
        student.coddimenval = json["coddimenval"].stringValue
        
        return student
    }
}


//♣	codcurso: "1",
//♣	codgrado: "3",
//♣	codgradocurso: "74",
//♣	descripcion: "Transición A",
//♣	codestudiante: "1243",
//♣	primerapellido: "FERRER",
//♣	segundoapellido: "GARCIA",
//♣	primernombre: "SARAH ",
//♣	segundonombre: "SOFIA",
//♣	codestumatricula: "1029",
//♣	path: "",
//♣	tarde: "0",
//♣	excusa: "0",
//♣	nasistio: "0",
//♣	coddimenval: "2"
