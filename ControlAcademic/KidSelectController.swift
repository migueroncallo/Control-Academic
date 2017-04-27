//
//  KidSelectController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/9/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RealmSwift
import SlideMenuControllerSwift

class KidSelectController: UIViewController, NVActivityIndicatorViewable {

    var hijos = [Estudiante]()
    let screenSize: CGRect = UIScreen.main.bounds

    
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        self.tableView.tableFooterView = UIView()

        self.startAnimating(message: "Cargando...", type: .ballClipRotate)
        DataService.sharedInstance.fetchStudents(DataService.sharedInstance.currentUser.cod, DataService.sharedInstance.colegioSelected.link) { (error, estudiantes) in
            
            self.stopAnimating()
            if let e = error{
                print(e)
            }else{
                self.hijos = estudiantes!
                self.tableView.reloadData()
                
            }
        }
        
        // Do any additional setup after loading the view.
    }

    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Estudiantes"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
        let messageButton = UIBarButtonItem(image: UIImage(named: "message"), style: .plain, target: self, action: nil)
        //        let notificationButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [messageButton]
        
    }
    
    func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main Menu VC") as! MainMenuController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "Left Menu VC") as! LeftMenuController
        
        
        let nvc = UINavigationController(rootViewController: mainViewController)
        
        
        SlideMenuOptions.leftViewWidth = screenSize.width*0.75
        
        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.delegate = mainViewController
        AppDelegate.getDelegate().window?.rootViewController = slideMenuController
        AppDelegate.getDelegate().window?.makeKeyAndVisible()
    }
}

extension KidSelectController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        DataService.sharedInstance.studentSelected = self.hijos[indexPath.row]
        
        
        self.defaults.set(self.hijos[indexPath.row].codestudiante, forKey: "sonSelected")
        self.createMenuView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hijos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Kids Cell") as! StudentsCell
        
        cell.studentNameLabel.text = "\(self.hijos[indexPath.row].primernombre!) \(self.hijos[indexPath.row].segundonombre!) \(self.hijos[indexPath.row].primerapellido!) \(self.hijos[indexPath.row].segundoapellido!)"
        
        cell.studentClassLabel.text = self.hijos[indexPath.row].descripcion!
        
        return cell
    }
}
