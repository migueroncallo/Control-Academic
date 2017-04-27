//
//  Mensaje.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/31/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Mensaje: Object{
    
    dynamic var codmensaje: String!
    dynamic var codusuario: String!
    dynamic var asunto: String!
    dynamic var fecha: String!
    dynamic var emisor: String!
    var adjunto: Int!
    var enviado: Int!
    dynamic var coddestinatario: String!
    var codestado: Int!
    var codtipo: Int!
    dynamic var estado: String!
    dynamic var tipo: String!
    dynamic var destinatario: String!
    dynamic var mensaje: String!
    
    func messageFromJson(_ json: JSON)-> Mensaje{
    
        let m = Mensaje()
        
        m.codmensaje = json["codmensaje"].stringValue
        m.codusuario = json["codusuario"].stringValue
        m.asunto = json["asunto"].stringValue
        m.fecha = json["fecha"].stringValue
        m.emisor = json["emisor"].stringValue
        m.adjunto = json["adjunto"].intValue
        m.enviado = json["enviado"].intValue
        m.coddestinatario = json["coddestinatario"].stringValue
        m.codestado = json["codestado"].intValue
        m.codtipo = json["codtipo"].intValue
        m.estado = json["estado"].stringValue
        m.tipo = json["tipo"].stringValue
        m.destinatario = json["destinatario"].stringValue
        m.mensaje = json["mensaje"].stringValue
        
        return m
    }
    
}
