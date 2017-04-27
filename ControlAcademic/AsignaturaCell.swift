//
//  AsignaturaCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/21/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class AsignaturaCell: UITableViewCell {

    
    @IBOutlet var subjectNameLabel: UILabel!
    
    @IBOutlet var subjectGradeProgress: UIProgressView!
    
    
    @IBOutlet var subjectGradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func config(_ asignatura: Asignatura, _ color: UIColor){
        
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 6.0)
        self.subjectNameLabel.text = asignatura.nombreasignatura
        
        self.subjectGradeLabel.text = "\(asignatura.notaasignatura!)"
        let progressGrade = asignatura.notaasignatura/10
        self.subjectGradeProgress.progress = Float(progressGrade)
        self.subjectGradeProgress.progressTintColor = color
        self.subjectGradeProgress.transform = transform
        
    }
    
}
