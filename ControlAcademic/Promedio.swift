//
//  Promedio.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/21/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Promedio: Object {
    
    dynamic var actor: String!
    var promedio: Float!
    
    func promedioFromJson(_ json:JSON)-> Promedio{
        let p = Promedio()
        
        p.actor = json["actor"].stringValue
        p.promedio = json["promedio"].floatValue
        
        return p
    }
    
}
