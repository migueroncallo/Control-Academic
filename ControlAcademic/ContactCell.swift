//
//  ContactCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 4/10/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet var contactLabel: UILabel!
    
    var isContact = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(_ contacto: Contacto){
        contactLabel.text = "\(contacto.nombres!) \(contacto.apellidos!)"
        /* if isContact{
         self.contentView.backgroundColor = UIColor.green
         }else{
         self.backgroundView?.backgroundColor = UIColor.clear
         }
         */
    }

}
