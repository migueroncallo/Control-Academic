//
//  SubProcesoCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/27/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class SubProcesoCell: UITableViewCell {
    
    @IBOutlet var subProcessNameLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var percentageLabel: UILabel!
    
    @IBOutlet var notasView: UIView!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var spacing: CGFloat = 8.0
    var totalHeight = 0.0
    var labels = 0
    
    var set = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ subprocess: Subproceso){
        if !set{
            self.heightConstraint.constant = 0

            self.subProcessNameLabel.text = subprocess.nombre
            self.gradeLabel.text = subprocess.totalNota
            self.percentageLabel.text = "Porcentaje: \(subprocess.procentaje!)%"
            
            
            for nota in Array(subprocess.definicionNotas){
                let lbl = UILabel()
                lbl.font = lbl.font.withSize(15)
                
                let frame = CGRect(x: 8, y: spacing, width: self.notasView.frame.width - 28, height: 20 )
                lbl.frame = frame
                lbl.numberOfLines = 2
                lbl.text = nota.descripcion
                lbl.sizeToFit()
                totalHeight += Double(spacing)
                totalHeight += Double(lbl.frame.height)
                let noteLbl = UILabel()
                noteLbl.font = noteLbl.font.withSize(15)
                let noteFrame = CGRect(x: self.notasView.frame.width - 28, y: lbl.frame.height + spacing, width: 20, height: 20)
                noteLbl.frame = noteFrame
                noteLbl.text = nota.notaEstud.nota
                noteLbl.sizeToFit()
                totalHeight += Double(noteLbl.frame.height)
                spacing = spacing + 10
                
                let fechaLbl = UILabel()
                fechaLbl.font = fechaLbl.font.withSize(15)
                
                let fechaFrame = CGRect(x: 8, y: noteLbl.frame.height + spacing, width: self.notasView.frame.width - 16, height: 20 )
                fechaLbl.frame = fechaFrame
                fechaLbl.text = nota.fecha
                fechaLbl.font = UIFont.systemFont(ofSize: 12)
                fechaLbl.sizeToFit()
                
                spacing = spacing + 15 + fechaLbl.frame.height + 10
                self.notasView.addSubview(lbl)
                self.notasView.addSubview(noteLbl)
                self.notasView.addSubview(fechaLbl)
                self.labels += 2
                
            }
            
            
            self.heightConstraint.constant = CGFloat(28 * self.labels)
            set = true
        }
        
    }
    
}
