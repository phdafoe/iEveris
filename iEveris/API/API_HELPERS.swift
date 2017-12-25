//
//  API_HELPERS.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

let customPrefs = UserDefaults.standard

/**
 MUESTRA ALERT CONTROLLER GENERICO,
 + Parameter: titleData -> este titulo generico
 + Parameter: messageData -> este mensaje generico
*/
func muestraAlertVC(_ titleData : String, messageData : String) -> UIAlertController{
    let alert = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
}

//MARK: - ENVIO DE CORREO DE CONTACTO
func configuredMailComposeViewController() -> MFMailComposeViewController{
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients(["info@info.com"])
    mailCompose.setSubject("Ayuda desde IOS")
    mailCompose.setMessageBody("Escriba su mensaje, nos pondremos en contacto con usted lo antes posible.", isHTML: false)
    return mailCompose
}

//MARK: - NULL TO String
/*public func dimeString(_ j : JSON, nombre : String) -> String{
    if let stringResult = j[nombre].string{
        return stringResult
    }else{
        return ""
    }
}

//MARK: - NULL TO Int
public func dimeInt(_ j : JSON, nombre : String) -> Int{
    if let intResult = j[nombre].int{
        return intResult
    }else{
        return 0
    }
}

//MARK: - NULL TO Float
public func dimeFloat(_ j : JSON, nombre : String) -> Float{
    if let floatResult = j[nombre].float{
        return floatResult
    }else{
        return 0
    }
}

//MARK: - NULL TO Double
public func dimeDouble(_ j : JSON, nombre : String) -> Double{
    if let doubleResult = j[nombre].double{
        return doubleResult
    }else{
        return 0
    }
}*/
