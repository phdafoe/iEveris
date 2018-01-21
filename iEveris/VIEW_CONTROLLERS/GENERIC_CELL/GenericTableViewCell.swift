//
//  GenericTableViewCell.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell, ReuseIdentifierProtocol {
    
    //MARK:- IBOutlets
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myFechaOferta: UILabel!
    @IBOutlet weak var myInformacionOferta: UILabel!
    @IBOutlet weak var myImporteOferta: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
