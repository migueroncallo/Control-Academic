//
//  MessageDetailController.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/6/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import QuickLook


class MessageDetailController: UIViewController, NVActivityIndicatorViewable,QLPreviewControllerDataSource,QLPreviewControllerDelegate{

    @IBOutlet var senderLabel: UILabel!
    
    @IBOutlet var subjectLabel: UILabel!
    
    @IBOutlet var messageWebView: UIWebView!
    
    @IBOutlet weak var fechaLabel: UILabel!
    
    var message: Mensaje!
    
    var archivos = [Archivo]()
    
    @IBOutlet var attachedButton: UIButton!
    var path = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageWebView.scalesPageToFit = true
        messageWebView.contentMode = UIViewContentMode.scaleAspectFit
        fechaLabel.text = message.fecha
        
        if message.adjunto == 1{
            self.startAnimating(message: "Cargando adjunto", type: NVActivityIndicatorType.ballClipRotate)
            DataService.sharedInstance.loadAttachment(message.codmensaje, cb: { (error, archivos) in
                self.stopAnimating()
                if let e = error{
                    print(e)
                }else{
                    self.attachedButton.setTitle(archivos!.first!.nombrearchivo, for: .normal)
                    self.attachedButton.isHidden = false
                    self.archivos = archivos!
                }
            })
        }else{
            
            attachedButton.isHidden = true
        }
        setNavigationBar()
        senderLabel.text = message.emisor
        senderLabel.sizeToFit()
        subjectLabel.text = message.asunto
        subjectLabel.sizeToFit()
        
        
        messageWebView.loadHTMLString(message.mensaje, baseURL: nil)
        
    }
    
    //MARK: Supporting functions
    
    func setNavigationBar(){
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Mensaje"
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.white
        
        self.navigationItem.titleView = titleLabel
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 106/255, blue: 211/255, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
    }
    
    //MARK: Button actions
    
    @IBAction func openAttachment(_ sender: UIButton) {
        
        let n = archivos[0].nombrearchivo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        startAnimating(nil, message: "Descargando", type: .ballGridPulse, color: nil, padding: nil)


        if QLPreviewController.canPreview(URL(fileURLWithPath: n) as QLPreviewItem) {
            print("doing preview!")

            HttpDownloader.loadFileAsync(archivos[0].nombrearchivo,url: URL(string:archivos[0].url)!, completion:{(path:String, error:NSError?) in
                
                
                
                if let e = error{
                    print(e.localizedDescription)
                    DispatchQueue.main.async {
                        self.stopAnimating()
                    }
                    return
                }
                
                print("pdf downloaded to: \(path)")
                self.path = path
                
                
                let preview = QLPreviewController()
                preview.dataSource = self
                preview.currentPreviewItemIndex = 0
               

                
                DispatchQueue.main.async {
                    
                    self.stopAnimating()
                    
                    self.present(preview, animated: true, completion: nil)
                }
            })
        }else{
            self.stopAnimating()
        }
    }
    
    
    //Mark: QLPreviewController delegate
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
       
        let doc = URL(fileURLWithPath: self.path)
        return doc as QLPreviewItem
    }
    
    
    

}


