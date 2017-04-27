//
//  Subproceso.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/27/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class notaEstudiante: Object{
    var nota: String!
    var codnotasdefinicion: String!
    var codgradoasig: String!
    var codnivelesgrupo: String!
    var codsubprocesos: String!
    
    func notaFromJson(_ json:JSON) -> notaEstudiante{
        let n = notaEstudiante()
        
        n.nota = json["nota"].stringValue
        n.codnotasdefinicion = json["codnotasdefinicion"].stringValue
        n.codgradoasig = json["codgradoasig"].stringValue
        n.codnivelesgrupo = json["codnivelesgrupo"].stringValue
        n.codsubprocesos = json["codsubprocesos"].stringValue
        
        return n
    }
}

class nota: Object{
    
    var conse: String!
    var descripcion: String!
    var nronota: String!
    var fecha: String!
    var codgradoasig: String!
    var codnivelesgrupo: String!
    var codperiodo: String!
    var codprocesos: String!
    var codsubprocesos: String!
    var notasEstudiantes: String!
    var notaEstud: notaEstudiante!

    func notaFromJson(_ json: JSON) -> nota{
        let n = nota()
        
        n.conse = json["conse"].stringValue
        n.descripcion = json["descripcion"].stringValue
        n.nronota = json["nronota"].stringValue
        n.fecha = json["fecha"].stringValue
        n.codgradoasig = json["codgradoasig"].stringValue
        n.codnivelesgrupo = json["codnivelesgrupo"].stringValue
        n.codperiodo = json["codperiodo"].stringValue
        n.codprocesos = json["codprocesos"].stringValue
        n.codsubprocesos = json["codsubprocesos"].stringValue
        n.notasEstudiantes = json["notasEstudiantes"].stringValue
        n.notaEstud = notaEstudiante().notaFromJson(json["notaEstudiante"])
        
        
        return n
    }
}

class Subproceso: Object{
    
    var cod: String!
    var codprocesogradosasiq: String!
    var codprocesosnivelesgrupo: String!
    var nombre: String!
    var procentaje: String!
    var codperiodo: String!
    var codprocesos: String!
    var totalNota: String!
    var definicionNotas = List<nota>()
    
    func subprocesoFromJson(_ json: JSON) -> Subproceso{
        let s = Subproceso()
        
        s.cod = json["cod"].stringValue
        s.codprocesogradosasiq = json["codprocesogradosasiq"].stringValue
        s.codprocesosnivelesgrupo = json ["codprocesosnivelesgrupo"].stringValue
        s.nombre = json["nombre"].stringValue
        s.procentaje = json["porcentaje"].stringValue
        s.codperiodo = json["codperiodo"].stringValue
        s.codprocesos = json["codprocesos"].stringValue
        s.totalNota = json["totalNota"].stringValue
        
        for  (_,subJson):(String, JSON) in json["definicionNotas"] {
            s.definicionNotas.append(nota().notaFromJson(subJson)   )
        }

        
        return s
    }
    
}

class Proceso: Object{
    var cod: String!
    var codproceso: String!
    var nombre: String!
    var nombreproceso: String!
    var porcentaje: String!
    var totalNota: String!
    var subprocesos = List<Subproceso>()
    
    func procesoFromJson(_ json: JSON)->Proceso{
        let p = Proceso()
        
        p.cod = json["cod"].stringValue
        p.codproceso = json["codproceso"].stringValue
        p.nombre = json["nombre"].stringValue
        p.nombreproceso = json["nombreproceso"].stringValue
        p.porcentaje = json["porcentaje"].stringValue
        p.totalNota = json["totalNota"].stringValue
        
        for  (_,subJson):(String, JSON) in json["subprocesos"] {
            p.subprocesos.append(Subproceso().subprocesoFromJson(subJson))
        }
        
        return p
    }
}
