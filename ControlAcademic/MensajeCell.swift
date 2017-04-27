//
//  MensajeCell.swift
//  ControlAcademic
//
//  Created by Miguel Roncallo on 3/31/17.
//  Copyright © 2017 Cloud Techonlogies. All rights reserved.
//

import UIKit

class MensajeCell: UITableViewCell {

    @IBOutlet var initialsView: UIView!
    
    @IBOutlet var initialsLabel: UILabel!
    
    @IBOutlet var emisorLabel: UILabel!
    
    @IBOutlet var asuntoLabel: UILabel!
    
    @IBOutlet var fechaLabel: UILabel!
    
    @IBOutlet var favoriteButton: UIButton!
        
    var fav = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favFunction(_ sender: UIButton) {
        if !fav{
            //ejecutar función para favorito
            fav = !fav
            self.favoriteButton.setTitleColor(
                UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1), for: .normal)
        }else{
            fav = !fav
            self.favoriteButton.setTitleColor(
                UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1), for: .normal)
        }
        
    }
    
    func config(_ mensaje: Mensaje){
        
        self.initialsView.layer.cornerRadius = self.initialsView.frame.width/2
        
        self.initialsLabel.text = "\(mensaje.emisor.characters.first!)"
        
        self.emisorLabel.text = mensaje.emisor
        
        self.asuntoLabel.text = mensaje.asunto
        self.fechaLabel.text = mensaje.fecha
        
        switch self.initialsLabel.text! {
        case "A":
            self.initialsView.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
            break
        case "B":
            self.initialsView.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            break
        case "C":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1)
            break
        case "D":
            self.initialsView.backgroundColor = UIColor(red: 28/255, green: 198/255, blue: 218/255, alpha: 1)
            break
        case "E":
            self.initialsView.backgroundColor = UIColor(red: 102/255, green: 187/255, blue: 106/255, alpha: 1)
            break
        case "F":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 167/255, blue: 28/255, alpha: 1)
            break
        case "G":
            self.initialsView.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
            break
        case "H":
            self.initialsView.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            break
        case "I":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1)
            break
        case "J":
            self.initialsView.backgroundColor = UIColor(red: 28/255, green: 198/255, blue: 218/255, alpha: 1)
            break
        case "K":
            self.initialsView.backgroundColor = UIColor(red: 102/255, green: 187/255, blue: 106/255, alpha: 1)
            break
        case "L":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 167/255, blue: 28/255, alpha: 1)
            break
        case "M":
            self.initialsView.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
            break
        case "N":
            self.initialsView.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            break
        case "O":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1)
            break
        case "P":
            self.initialsView.backgroundColor = UIColor(red: 28/255, green: 198/255, blue: 218/255, alpha: 1)
            break
        case "Q":
            self.initialsView.backgroundColor = UIColor(red: 102/255, green: 187/255, blue: 106/255, alpha: 1)
            break
        case "R":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 167/255, blue: 28/255, alpha: 1)
            break
        case "S":
            self.initialsView.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
            break
        case "T":
            self.initialsView.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            break
        case "U":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 202/255, blue: 40/255, alpha: 1)
            break
        case "V":
            self.initialsView.backgroundColor = UIColor(red: 28/255, green: 198/255, blue: 218/255, alpha: 1)
            break
        case "W":
            self.initialsView.backgroundColor = UIColor(red: 102/255, green: 187/255, blue: 106/255, alpha: 1)
            break
        case "X":
            self.initialsView.backgroundColor = UIColor(red: 255/255, green: 167/255, blue: 28/255, alpha: 1)
            break
        case "Y":
             self.initialsView.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1)
            break
        case "Z":
            self.initialsView.backgroundColor = UIColor(red: 239/255, green: 83/255, blue: 80/255, alpha: 1)
            break
        default:
            break
        }
        
        if mensaje.codestado == 4{
            self.fav = true
        }
        if fav{
            self.favoriteButton.setTitleColor(
                UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1), for: .normal)
        }else{
            self.favoriteButton.setTitleColor(
                UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1), for: .normal)
        }
    }
    

}

