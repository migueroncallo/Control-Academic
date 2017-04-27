//
//  Archivo.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/7/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON

class Archivo{
    
    var cod: String!
    var codmensaje: String!
    var nombrearchivo: String!
    var nombreguardado: String!
    var ext: String!
    var tamano: String!
    var createdday: String!
    var codpathcarpeta: String!
    var url: String!
    
    func archivoFromJson(_ json: JSON) -> Archivo{
    
        let a = Archivo()
        
        a.cod = json["cod"].stringValue
        a.codmensaje = json["codmensaje"].stringValue
        a.nombrearchivo = json["nombrearchivo"].stringValue
        a.nombreguardado = json["nombreguardado"].stringValue
        a.ext = json["extension"].stringValue
        a.tamano = json["tamano"].stringValue
        a.createdday = json["createdday"].stringValue
        a.codpathcarpeta = json["codpathcarpeta"].stringValue
        a.url = json["url"].stringValue
        
        return a
    }
//    "cod": "184",
//    "codmensaje": "726",
//    "nombrearchivo": "Pagos-online (1) (1).pdf",
//    "nombreguardado": "2017-02-09_095806_303917.pdf",
//    "extension": "pdf",
//    "tamano": "1190414",
//    "createdday": "09/02/2017 9:58:06",
//    "codpathcarpeta": "7",
//    "url": "https://controlacademic.co/fileserver/testversion/Mensajeria/2017-02-09_095806_303917.pdf"
}
