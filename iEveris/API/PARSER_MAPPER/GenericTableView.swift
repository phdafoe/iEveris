//
//  GenericTableView.swift
//  iEveris
//
//  Created by Andres on 31/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Kingfisher

public class EVERISRellenarCeldas{
    
    
    func tipoGenericoOfertas(_ customCell : GenericTableViewCell, arrayGenerico : GenericModelData, row : Int) -> GenericTableViewCell {
        
        customCell.myNombreOferta.text = arrayGenerico.nombre
        customCell.myFechaOferta.text = arrayGenerico.fechaFin
        customCell.myInformacionOferta.text = arrayGenerico.masInformacion
        customCell.myImporteOferta.text = arrayGenerico.importe
        
        if var pathImagen = arrayGenerico.imagen {
            pathImagen = CONSTANTES.LLAMADAS.BASE_URL + pathImagen
            let pathComplete = getImagePath(CONSTANTES.LLAMADAS.OFERTAS, id: arrayGenerico.id!, name: arrayGenerico.imagen!)
            customCell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathComplete)!),
                                                  placeholder: #imageLiteral(resourceName: "placeholder"),
                                                  options: [.transition(ImageTransition.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: { (imageData, error, cacheType, imageUrl) in
                                                    //guardamos las imágenes en un diccionario
                                                    diccionarioImagenes[arrayGenerico.id!] = imageData!
            })
        }
        return customCell
    }
    
    func tipoGenericoPerfil(_ customCell : MiPerfilCustomCell) -> MiPerfilCustomCell{
        customCell.myNombrePerfilUsuario.text = "Andres"
        customCell.myUsernameSportReviewLBL.text = "Ocampo"
        customCell.myFotoPerfilUsuario.image = #imageLiteral(resourceName: "steve_jobs")
        return customCell
    }
    
    
}

