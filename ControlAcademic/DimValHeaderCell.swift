//
//  ClaseHeaderCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/11/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class DimValHeaderCell: UITableViewCell {

    @IBOutlet var claseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(_ asignatura: AsignaturaDimVal){
        claseLabel.text = asignatura.nombre!
    }

}
