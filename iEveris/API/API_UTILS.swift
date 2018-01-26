//
//  API_UTILS.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

let CONSTANTES = Constantes()
let taskManager = APITaskManager.sharedInstance
typealias diccionario = [String : Any]
typealias arrayDiccionario = [diccionario]
var jsonDataGenerico : JSON?

var imagenSeleccionada : UIImage?
var diccionarioImagenes = [String: UIImage?]()


struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let NSURSER_DEFAULT = CustomUserDefault()
    
}

struct Colores {
    let AZUL_NAV_TAB = #colorLiteral(red: 0.1902901828, green: 0.1902901828, blue: 0.1902901828, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct LLamadas {
    
    let BASE_ITUNES_TOP = "https://itunes.apple.com/%@/rss/"
    let LASTPATH_COMPONENT = "/limit=50/json"
    
    let BASE_ITUNES_GENERAL = "https://itunes.apple.com/%@/rss/%@/limit=%@/json"
    
    
}

struct CustomUserDefault {
    
    let USER_DEFAULT = UserDefaults.standard
    let KEY_DESCRIPCION_POST = "descripcion"
    let KEY_IMAGEN_POST = "imagen"
}

