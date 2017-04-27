//
//  StudentsCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class StudentsCell: UITableViewCell {

    @IBOutlet var studentNameLabel: UILabel!
    
    @IBOutlet var studentClassLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
