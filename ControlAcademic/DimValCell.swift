//
//  DimValCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class DimValCell: UITableViewCell {
    
    @IBOutlet var descripcionLabel: UILabel!
    
    @IBOutlet var logrosView: UIView!
    
    @IBOutlet var viewHeightConstraint: NSLayoutConstraint!
    var spacing = 8
    
    var didSet = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ proceso: ProcesoDimVal){
        
        descripcionLabel.text = proceso.nombre
        descripcionLabel.sizeToFit()
        if !didSet{
            for subP in proceso.subprocesos{
                let initialsLabel = UILabel()
                
                let initialsFrame = CGRect(x: 8, y: spacing, width: 40, height: 40)
                initialsLabel.text = subP.abr
                initialsLabel.textAlignment = .center
                initialsLabel.frame = initialsFrame
                
                initialsLabel.layer.cornerRadius = 20
                initialsLabel.clipsToBounds = true
                
                initialsLabel.textColor = UIColor.white
                initialsLabel.backgroundColor = UIColor(hexString: subP.hex)
                
                let descriptionLabel = UILabel()
                let descriptionFrame = CGRect(x: 50, y: spacing, width: Int(self.contentView.frame.width - 60), height: 10)
                descriptionLabel.numberOfLines = 0
                descriptionLabel.text = subP.nombre
                descriptionLabel.frame = descriptionFrame
                descriptionLabel.font = UIFont.systemFont(ofSize: 12)
                descriptionLabel.sizeToFit()
                spacing += 58
                
                logrosView.addSubview(initialsLabel)
                logrosView.addSubview(descriptionLabel)
                
            }
            
            viewHeightConstraint.constant = CGFloat(proceso.subprocesos.count * 60)
            didSet = !didSet
        }
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        // Trim leading '#' if needed
        var cleanedHexString = hexString
        if hexString.hasPrefix("#") {
            //            cleanedHexString = dropFirst(hexString) // Swift 1.2
            cleanedHexString = String(hexString.characters.dropFirst()) // Swift 2
        }
        
        // String -> UInt32
        var rgbValue: UInt32 = 0
        Scanner(string: cleanedHexString).scanHexInt32(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
