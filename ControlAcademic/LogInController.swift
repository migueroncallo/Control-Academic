//
//  LogInController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/9/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift

class LogInController: UIViewController, NVActivityIndicatorViewable {

    var colegio = DataService.sharedInstance.colegioSelected
    
    
    @IBOutlet var schoolNameLabel: UILabel!
    
    @IBOutlet var userTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var logInButton: UIButton!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.schoolNameLabel.text = self.colegio.nombre
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button actions
    
    @IBAction func switchSchool(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Departamento VC") as! ViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {
        self.startAnimating(message: "Validando", type: .ballClipRotate)
        
        DataService.sharedInstance.logIn(self.userTextField.text!, self.passwordTextField.text!, self.colegio.link) { (error, user) in
            
            if let e = error{
                self.stopAnimating()
                let alert = UIAlertController(title: "Error", message: e.description, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                print(e)
            }else{
                
                self.defaults.setValue(self.colegio.link, forKey: "colSelected")
                if user!.codtipousuario == "6"{
                    self.stopAnimating()
                    
                    self.defaults.set(true, forKey: "logged")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Kids Select VC") as! UINavigationController
                    self.present(vc, animated: true, completion: nil)
                    
                }else if user!.codtipousuario == "2"{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main Menu VC") as! MainMenuController
                    DataService.sharedInstance.loadStudent(user!.cod, { (error, student) in
                        self.stopAnimating()
                        if let e = error{
                            print(e)
                        }else{
                            DataService.sharedInstance.studentSelected = student!
                            self.defaults.set(true, forKey: "logged")
                            self.createMenuView()
                        }
                    })
                    
                }else{
                    //No es usuario válido
                    let alert = UIAlertController(title: "Error", message: "Lo sentimos, acceso denegado. La aplicación para ti es Control Master", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
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
