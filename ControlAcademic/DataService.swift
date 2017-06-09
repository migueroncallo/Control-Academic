//
//  DataService.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 1/30/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class DataService{
    
    static let sharedInstance = DataService()
    
    var departamentos = [Departamentos]()
    
    var colegios = [Colegio]()
    
    var destinatario = [Contacto]()
    
    let baseUrl = "https://controlacademic.co/apicloudws"
    
    var colegioSelected = Colegio()
    var currentUser = User()
    var hijos = [Estudiante]()
    let realm = try! Realm()
    var studentSelected = Estudiante()
    var modulos = [Modulo]()
    var asignaturas = [Asignatura]()
    var horarios = [Horario]()
    var periodos = [Periodo]()
    var promedios = [Promedio]()
    var procesos = [Proceso]()
    var asistencias = [Asistencia]()
    var mensajes = [Mensaje]()
    var contacts = [Contacto]()
    var dimVal = [AsignaturaDimVal]()
    
    let defaults = UserDefaults.standard
    
    func loadDepartmens(cb: @escaping (NSError?, [Departamentos]?)->()){
        
        departamentos.removeAll()
        let url = URL(string: "\(self.baseUrl)/informacion/cargarDepartamentos?tipoApp=m&conec=cloudcontrol")
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    if !json["success"].boolValue{
                        //                        print("\(json["error"].stringValue)")
                        
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los departamentos."]
                        ), nil)
                    }else{
                        
                        for  (_,subJson):(String, JSON) in json["lista"] {
                            let departamento = Departamentos().departamentoFromJson(subJson)
                            self.departamentos.append(departamento)
                        }
                        
                        cb(nil, self.departamentos)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                cb(error as NSError!, nil)
            }
            
        }
    }
    
    func loadColegios(_ codDepartamento: String, cb: @escaping (NSError?, [Colegio]?)->()){
        
        let url = URL(string: "\(baseUrl)/informacion/cargarColegios?app=2&tipoApp=m&conec=cloudcontrol")
        
        
        self.colegios.removeAll()
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Colegio.self))
        }
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            
            print("Colegios : \(response)")
            
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    if !json["success"].boolValue{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los colegios."]
                        ), nil)
                    }else{
                        
                        for  (_,subJson):(String, JSON) in json["lista"] {
                            
                            let colegio = Colegio().colegioFromJson(subJson)
                            
                            print(colegio.nombre)
                            if colegio.codDepartamento == codDepartamento{
                                
                                print(colegio.nombre)
                                self.colegios.append(colegio)
                            }
                        }
                        
                        self.realm.beginWrite()
                        self.realm.add(self.colegios)
                        try! self.realm.commitWrite()
                        
                        cb(nil, self.colegios)
                    }
                }
                
            case .failure(let error):
                cb(error as NSError!, nil)
            }
        }
    }
    
    func logIn(_ username: String, _ password: String, _ link: String, cb: @escaping(NSError?, User?)->()){
        
        print("logging in")
        let url = URL(string: "https://www.controlacademic.co/apicloudws/usuario/validarusuario?user=\(username)&pass=\(password)&tipoapp=m&conec=\(link)")
        
        
        let parameters = ["user" : username,
                          "pass" : password,
                          "tipoApp": "m",
                          "conec": link]
        
        print(parameters)
        
        Alamofire.request(url!, method: .get)
            .validate()
            .responseJSON { (response) in
                print("Login Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al iniciar sesión"]
                            ), nil)
                        }else{
                            let user = User().userFromJson(json["usuario"])
                            self.realm.beginWrite()
                            self.realm.add(user)
                            try! self.realm.commitWrite()
                            self.currentUser = user
                            
                            cb(nil, user)
                        }
                        
                    }
                    
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
        }
        
    }
    
    func fetchStudents(_ codUser: String, _ link: String, cb: @escaping(NSError?, [Estudiante]?)->()){
        
        print("Getting students")
        
        let url = URL(string: "\(baseUrl)/Usuario/ListadoEstudiantesHijos?codusuario=\(codUser)&tipoapp=m&conec=\(link)")
        
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Estudiante.self))
        }
        self.hijos.removeAll()
        
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los estudiantes"]
                            ), nil)
                        }else{
                            
                            self.hijos.removeAll()
                            for  (_,subJson):(String, JSON) in json["Estudiantes"] {
                                self.hijos.append(Estudiante().studentFromJson(subJson))
                            }
                            
                            self.realm.beginWrite()
                            self.realm.add(self.hijos)
                            try! self.realm.commitWrite()
                            cb(nil, self.hijos)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
                
        }
        
    }
    
    func loadModules(_ link: String, cb: @escaping (NSError?, [Modulo]?)->()){
        
        let url = URL(string: "\(baseUrl)/tesoreria/cargarModulos?tipoapp=m&conec=\(self.colegioSelected.link!)")
        
        self.modulos.removeAll()
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Modulo.self))
        }
        Alamofire.request(url!, method: .get)
            .validate()
            .responseJSON { (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los módulos"]
                            ), nil)
                        }else{
                            self.modulos.removeAll()
                            for  (_,subJson):(String, JSON) in json["Modulos"] {
                                if subJson["nombre"].stringValue == "excusas" || subJson["nombre"].stringValue == "agenda" || subJson["nombre"].stringValue == "incidentes" || subJson["nombre"].stringValue == "tesoreria" || subJson["nombre"].stringValue == "aula" || subJson["nombre"].stringValue == "controlfood"{
                                }else{
                                    self.modulos.append(Modulo().moduleFromJson(subJson))
                                }
                            }
                            
                            self.realm.beginWrite()
                            self.realm.add(self.modulos)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.modulos)
                        }
                        
                    }
                    
                case .failure(let error):
                    
                    cb(error as NSError!, nil)
                }
        }
        
    }
    
    
    func loadStudent(_ codusuario: String, _ cb: @escaping(NSError?, Estudiante?)->()){
        
        let parameters = [
            "codusuario": codusuario,
            "tipoapp": "m",
            "conec": self.colegioSelected.link
            ] as [String: String]
        
        print(parameters)
        let url = URL(string: "\(baseUrl)/Usuario/buscarEstudiante")
        
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseJSON{ (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los datos del estudiante"]
                            ), nil)
                        }else{
                            
                            let estud = Estudiante().studentFromJson(json["Estudiante"])
                            self.studentSelected = estud
                            print("Student selected: \(self.studentSelected)")
                            cb(nil, estud)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
                
        }
        
    }
    
    func loadSchedule(_ cb: @escaping(NSError?, [Horario]?)->()){
        
        let url = URL(string: "\(baseUrl)/horario/horarioEstudiante2")
        
        let parameters = ["codestudiante": self.studentSelected.codestumatricula!,
                          "codgradoscurso": self.studentSelected.codgradocurso!,
                          "tipoapp": "m",
                          "conec":self.colegioSelected.link!]
        
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar el horario del estudiante"]
                            ), nil)
                        }else{
                            self.horarios.removeAll()
                            for  (_,subJson):(String, JSON) in json["horarioEstudiante"] {
                                self.horarios.append(Horario().horarioFromJson(subJson))
                            }
                            self.realm.beginWrite()
                            self.realm.add(self.horarios)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.horarios)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
                
                
        }
        
    }
    
    func loadPeriods(_ cb: @escaping(NSError?, [Periodo]?)->()){
        
        let url = URL(string: "\(baseUrl)/Usuario/Periodos")
        
        let parameters = ["tipoapp": "m",
                          "conec":self.colegioSelected.link!]
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los periodos del estudiante"]
                            ), nil)
                        }else{
                            self.periodos.removeAll()
                            for  (_,subJson):(String, JSON) in json["Periodos"] {
                                self.periodos.append(Periodo().periodoFromJson(subJson))
                            }
                            self.realm.beginWrite()
                            self.realm.add(self.periodos)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.periodos)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
                
        }
    }
    
    func loadAverage(_ periodo: String!, _ cb: @escaping(NSError?, [Asignatura]?)->()) {
        let url = URL(string: "\(baseUrl)//Estudiante/ListaAsignaturas")
        let parameters = ["codgradoscursos":self.studentSelected.codgradocurso!,
                          "codperiodo": periodo,
                          "codestumatricula": self.studentSelected.codestumatricula!,
                          "tipoapp": "m",
                          "conec": self.colegioSelected.link!] as [String:String]
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Promedio.self))
            self.realm.delete(self.realm.objects(Asignatura.self))
        }
        self.promedios.removeAll()
        self.asignaturas.removeAll()
        
        print(parameters)
        Alamofire.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) in
                
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar las asignaturas del estudiante"]
                            ), nil)
                        }else{
                            
                            for  (_,subJson):(String, JSON) in json["asignaturas"] {
                                self.asignaturas.append(Asignatura().asignaturaFromJson(subJson))
                            }
                            for  (_,subJson):(String, JSON) in json["promedios"] {
                                self.promedios.append(Promedio().promedioFromJson(subJson))
                            }
                            self.realm.beginWrite()
                            
                            self.realm.add(self.promedios)
                            self.realm.add(self.asignaturas)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.asignaturas)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
        }
    }
    
    func loadNoteDetail(_ codperiodo: String, _ codgradoscursos: String, _ codgradosasig: String, cb: @escaping(NSError?, [Proceso]?)->()){
        
        let url = URL(string: "\(baseUrl)/Estudiante/notasxAsignaturaDetalle")
        
        let params = ["codestumatricula": self.studentSelected.codestumatricula!,
                      "codperiodo": codperiodo,
                      "codgradoscursos": codgradoscursos,
                      "codgradosasig": codgradosasig,
                      "tipoApp" : "m",
                      "conec": self.colegioSelected.link] as [String:String]
        
        self.procesos.removeAll()
        Alamofire.request(url!, method: .get, parameters: params)
            .validate()
            .responseJSON { (response) in
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas los procesos de la asignatura seleccionada."]
                            ), nil)
                        }else{
                            
                            for  (_,subJson):(String, JSON) in json["procesos"] {
                                self.procesos.append(Proceso().procesoFromJson(subJson))
                            }
                            
                            cb(nil, self.procesos)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
        }
        
    }
    
    
    func loadAsistance(cb: @escaping(NSError?, [Asistencia]?)->()){
        let url = URL(string: "\(baseUrl)/Inasistencia/buscarInasistenciasEstudiante")
        
        let params = ["codestumatricula":self.studentSelected.codestumatricula,
                      "tipoapp":"m",
                      "conec": self.colegioSelected.link] as [String:String]
        self.asistencias.removeAll()
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Asistencia.self))
        }
        
        Alamofire.request(url!, method: .get, parameters: params)
            .validate()
            .responseJSON { (response) in
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar las inasistencias."]
                            ), nil)
                        }else{
                            
                            for  (_,subJson):(String, JSON) in json["lista"] {
                                self.asistencias.append(Asistencia().asistenciaFromJson(subJson))
                            }
                            
                            self.realm.beginWrite()
                            self.realm.add(self.asistencias)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.asistencias)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
                
                
        }
    }
    
    func loadMessages(_ tipoCarpeta: Int, cb: @escaping(NSError?, [Mensaje]?)->()){
        
        let url = URL(string: "\(baseUrl)/Mensajeria/cargarBandeja")
        
        let params = ["codusuario":self.currentUser.cod,
                      "tipo": "\(tipoCarpeta)",
            "pagina":"1",
            "tipoapp":"m",
            "conec": self.colegioSelected.link] as [String:String]
        
        self.mensajes.removeAll()
        try! self.realm.write {
            self.realm.delete(self.realm.objects(Mensaje.self))
        }
        
        
        Alamofire.request(url!, method: .get, parameters: params)
            .validate()
            .responseJSON { (response) in
                print("Response: \(response)")
                switch response.result{
                case .success:
                    
                    if let value = response.result.value{
                        
                        let json = JSON(value)
                        print(json)
                        if !json["success"].boolValue{
                            cb(NSError(
                                domain: "root",
                                code: -99,
                                userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los mensajes."]
                            ), nil)
                        }else{
                            
                            for  (_,subJson):(String, JSON) in json["mensajes"] {
                                self.mensajes.append(Mensaje().messageFromJson(subJson))
                            }
                            
                            self.realm.beginWrite()
                            self.realm.add(self.mensajes)
                            try! self.realm.commitWrite()
                            
                            cb(nil, self.mensajes)
                        }
                    }
                case .failure(let error):
                    cb(error as NSError!, nil)
                }
        }
        
    }
    
    
    func loadAttachment(_ mensaje: String, cb: @escaping(NSError?, [Archivo]?)->()){
        let url = URL(string: "\(baseUrl)/Mensajeria/buscarAdjuntosCorreo")
        
        let params = ["codmensaje": mensaje,
                      "conec": colegioSelected.link,
                      "tipoapp":"m"] as [String:String]
        var archivos = [Archivo]()

        
        Alamofire.request(url!, method: .get, parameters: params)
        .validate()
        .responseJSON { (response) in
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    print(json)
                    if !json["success"].boolValue{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los mensajes."]
                        ), nil)
                    }else{
                        
                        for  (_,subJson):(String, JSON) in json["archivos"] {
                            archivos.append(Archivo().archivoFromJson(subJson))
                        }
                        print(archivos)
                        cb(nil, archivos)
                    }
                }
            case .failure(let error):
                cb(error as NSError!, nil)
            }
        }
    }
    
    func getContacts(_ cb: @escaping(NSError?, [Contacto]?)->()){
        let url = URL(string: "\(baseUrl)/mensajeria/traerUsuariosMensajeria")
        
        let params = ["tipoapp": "m",
        "conec": colegioSelected.link] as [String:String]
        
        Alamofire.request(url!, method: .get, parameters: params)
        .validate()
        .responseJSON { (response) in
            print(response)

            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    print(json)
                    if !json["success"].boolValue{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar los contactos."]
                        ), nil)
                    }else{
                        var contactos = [Contacto]()
                        for  (_,subJson):(String, JSON) in json["usuarios"] {
                            contactos.append(Contacto().contactoFromJson(subJson))
                        }
                        self.contacts = contactos
                        cb(nil, contactos)
                    }
                }
            case .failure(let error):
                cb(error as NSError!, nil)
            }
        }
    }
    
    func sendMessage(_ asunto: String, _ codanterior: String, _ receptor: String!, _ mensaje: String, _ tipoEnvio: String, cb: @escaping(Bool)->()){
        
        let url = URL(string: "\(baseUrl)/Mensajeria/enviarCorreo")
        let mensajeP = ["asunto": asunto,
                       "codanterior": codanterior,
                       "codusuario": currentUser.cod,
                       "mensaje": mensaje,
        "cod": ""] as [String: String]
        
        let temp: String! = receptor
        
        var jsonText = ""
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: mensajeP,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            jsonText = theJSONText!
        }
        
        let params = ["mensajeJson": jsonText,
                      "receptor": temp,
                      "tipoEnvio": tipoEnvio,
                      "tipoapp": "m",
                      "conec": colegioSelected.link] as [String : Any]
        
        print(params)
        
        Alamofire.request(url!, method: .post, parameters: params)
            .validate()
            .responseJSON { (response) in
                
                print(response.description)
                
                switch response.result{
                case .success:
                    
                    cb(true)
                case .failure:
                    cb(false)
                }

                
        }
        
        
    }
    
    func loadDimVal(_ codperiodo: String, _ cb: @escaping(NSError?, [AsignaturaDimVal]?)->()){
        let url = URL(string: "\(baseUrl)/estudiante/BuscarDimensionesValorativas")
        
        let params = ["codestumatricula": studentSelected.codestumatricula,
                      "codperiodo": codperiodo,
                      "codgradoscursos": studentSelected.codgradocurso,
                      "tipoApp": "m",
        "conec": colegioSelected.link] as [String: String]
        
        
        self.dimVal.removeAll()
        
        Alamofire.request(url!, method: .get, parameters: params)
        .validate()
        .responseJSON { (response) in
            
            print(response)
            
            switch response.result{
            case .success:
                
                if let value = response.result.value{
                    
                    let json = JSON(value)
                    print(json)
                    if !json["success"].boolValue{
                        cb(NSError(
                            domain: "root",
                            code: -99,
                            userInfo: [NSLocalizedDescriptionKey:"Problemas al cargar las asignaturas."]
                        ), nil)
                    }else{
                        
                        for  (_,subJson):(String, JSON) in json["asignaturas"] {
                            self.dimVal.append(AsignaturaDimVal().asignaturaFromJson(subJson))
                        }
                        
                        cb(nil, self.dimVal)
                    }
                }
            case .failure(let error):
                cb(error as NSError!, nil)
            }

        }
    }
    
    func initData(){
        
        let s = self.defaults.string(forKey: "sonSelected")!
        let c = self.defaults.string(forKey: "colSelected")!
        self.hijos = Array(self.realm.objects(Estudiante.self))
        self.currentUser = self.realm.objects(User.self).first!
        self.studentSelected = self.realm.objects(Estudiante.self).filter("codestudiante == '\(s)'").first!
        print("Hijo seleccionado: \(self.realm.objects(Estudiante.self).filter("codestudiante == '\(s)'").first!)")
        self.colegioSelected = self.realm.objects(Colegio.self).filter("link == '\(c)'").first!
        self.modulos = Array(self.realm.objects(Modulo.self))
        self.loadMessages(1) { (error, mensajes) in
            if let _ = error{
                
            }else{
                self.mensajes = mensajes!
            }
        }
    }
    
    func logout(cb: @escaping()->()){
        self.asignaturas.removeAll()
        self.asistencias.removeAll()
        self.colegios.removeAll()
        self.modulos.removeAll()
        self.hijos.removeAll()
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
        try! self.realm.write {
            self.realm.deleteAll()
        }
        cb()
    }
}
