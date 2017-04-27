//
//  RecreoCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/18/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class RecreoCell: UITableViewCell {
    
    @IBOutlet var horaInicioLabel: UILabel!
    
    @IBOutlet var horaFinLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(_ horario: Horario){
        
        self.horaInicioLabel.text = horario.horaini
        self.horaFinLabel.text = horario.horafin
    }
}
