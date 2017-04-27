//
//  ProcesoCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/27/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class ProcesoCell: UITableViewCell {

    @IBOutlet var processNameLabel: UILabel!
    
    @IBOutlet var gradeLabel: UILabel!
    
    @IBOutlet var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(_ proceso: Proceso){
        self.processNameLabel.text = proceso.nombre!
        self.gradeLabel.text = proceso.totalNota
        self.percentageLabel.text = self.percentageLabel.text! + " \(proceso.porcentaje!)%"
    }

}
