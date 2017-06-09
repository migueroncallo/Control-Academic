//
//  MainMenuController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/9/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SlideMenuControllerSwift

class MainMenuController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var studentImage: UIImageView!
    
    @IBOutlet var studentName: UILabel!
    
    @IBOutlet var studentChangeButton: UIButton!
    

    
    var modulos = [Modulo]()
    var student = Estudiante()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
//        self.createMenuView()
        setNavigationBarItem()

        self.setNavigationBar()
        self.student = DataService.sharedInstance.studentSelected
        
        if DataService.sharedInstance.hijos.count < 2{
            self.studentChangeButton.isHidden = true
        }
        
        self.studentName.text = "\(self.student.primernombre!) \(self.student.segundonombre!) \(self.student.primerapellido!) \(self.student.segundoapellido!)"
        
        
        self.startAnimating(message: "Cargando", type: NVActivityIndicatorType.ballClipRotatePulse)
        
        if DataService.sharedInstance.modulos.count > 0{
            self.stopAnimating()
            self.modulos = DataService.sharedInstance.modulos
        }else{
            DataService.sharedInstance.loadModules(DataService.sharedInstance.colegioSelected.link) { (error, modulos) in
                self.stopAnimating()
                if let e = error{
                    print(e)
                }else{
                    self.modulos = modulos!
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    //Button actions
    
    
    @IBAction func changeStudent(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Kids Select VC") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //Supporting functions
    func selectMenu(_ modulo: Modulo){
        
        var vc: UIViewController!
        switch modulo.nombre {
        case "academico":
        //academico
            
            if self.student.coddimenval == "2"{
                vc = self.storyboard?.instantiateViewController(withIdentifier: "DimVal VC") as! DimValController
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                
                vc = self.storyboard?.instantiateViewController(withIdentifier: "Academico VC") as! AcademicoController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case "agenda":
        //agenda
            break
        case "asistencia":
        //asistencia
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Asistencia VC") as! AsistenciasController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "excusas":
        //excusas
            break
        case "horario":
        //horario
            vc = self.storyboard?.instantiateViewController(withIdentifier: "Horario VC") as! HorarioController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "incidentes":
        //incidentes
            break
        case "mensajeria":
        //mensajería

            vc = self.storyboard?.instantiateViewController(withIdentifier: "Mensajes VC") as! MensajeController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "tesoreria":
        //tesorería
            break
        default:
            break
        }
        
    }
    
//    private func createMenuView() {
//        
//        // create viewController code...
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main Menu VC") as! MainMenuController
//        let leftViewController = storyboard.instantiateViewController(withIdentifier: "Left Menu VC") as! LeftMenuController
//        
//        
//        let nvc = UINavigationController(rootViewController: mainViewController)
//        
//                
//        SlideMenuOptions.leftViewWidth = screenSize.width*0.75
//        
//        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
//        slideMenuController.delegate = mainViewController
//        AppDelegate.getDelegate().window?.rootViewController = slideMenuController
//        AppDelegate.getDelegate().window?.makeKeyAndVisible()
//    }
    
    
    func setNavigationBar(){
        
        let titleLabel = UILabel()
        titleLabel.text = "Menú Principal"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        
        let messageButton = UIBarButtonItem(image: UIImage(named: "message"), style: .plain, target: self, action: #selector(self.messageButton(_:)))
//        let notificationButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItems = [messageButton]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            messageButton.addBadge(number: DataService.sharedInstance.mensajes.count)

        })

        self.tabBarController?.tabBar.isHidden = true
    }
    
    func messageButton(_ sender: UIBarButtonItem){
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "Mensajes VC") as! MensajeController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainMenuController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.selectMenu(self.modulos[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modulos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main Menu Cell") as! MainMenuCell
        
        cell.config(self.modulos[indexPath.row])
        
        return cell
    }
}

extension MainMenuController: SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
extension CAShapeLayer {
    func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        var badgeWidth = 8
        var numberOffset = 4
        
        if number > 9 {
            badgeWidth = 12
            numberOffset = 6
        }
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(7)
        let location = CGPoint(x: view.frame.width - (radius + offset.x), y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = "\(number)"
        label.alignmentMode = kCAAlignmentCenter
        label.fontSize = 11
        label.frame = CGRect(origin: CGPoint(x: location.x - CGFloat(numberOffset), y: offset.y), size: CGSize(width: badgeWidth, height: 16))
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
}
