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
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let time = dateFormatter.date(from: horario.horaini)
        
        let time2 = dateFormatter.date(from: horario.horafin)
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        let dateString = dateFormatter.string(from: time!)
        let date2String = dateFormatter.string(from: time2!)
        self.horaInicioLabel.text = dateString
        self.horaFinLabel.text = date2String
    }
}
