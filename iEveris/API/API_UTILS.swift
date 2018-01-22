//
//  API_UTILS.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import UIKit

let CONSTANTES = Constantes()
let taskManager = APITaskManager.sharedInstance
typealias diccionario = [String : Any]
typealias arrayDiccionario = [diccionario]

var imagenSeleccionada : UIImage?
var diccionarioImagenes = [String: UIImage?]()

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let NSURSER_DEFAULT = CustomUserDefault()
    
}

struct Colores {
    let AZUL_NAV_TAB = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct LLamadas {
    
    let OFERTAS = "oferta"
    let CUPONES = "cupon"
    let CONCURSO = "concurso"
    
    let BASE_PHOTO_URL = "http://app.clubsinergias.es/uploads/promociones/"
    
    let PROMOCIONES_SERVICE = "promociones"
    
    let BASEURLIDPARSE = "http://app.clubsinergias.es/api_comercios.php?idparse="
    let BASE_URL = "http://app.clubsinergias.es/api_comercios.php?"
    let BASEURLIDCLIENTE = "http://app.clubsinergias.es/api_comercios.php?idcliente="
    let BASEIDLOCALIDAD = "idlocalidad="
    let BASEIDP = "&p="
    let BASEIDTIPO = "&tipo="
    
    
    let BASE_URL_CONCURSOS = "http://andresocampo.com/pruebas/iSaldos/concursos.json"
    let BASE_URL_CUPONES = "http://andresocampo.com/pruebas/iSaldos/cupones.json"
    let BASE_URL_OFERTAS = "http://andresocampo.com/pruebas/iSaldos/ofertas.json"
    
    let BASE_ITUNES_TOP_MOVIES = "https://itunes.apple.com/us/rss/"
    let LASTPATH_COMPONENT = "/limit=50/json"
    
    
}

struct CustomUserDefault {
    
    let USER_DEFAULT = UserDefaults.standard
    let KEY_TAREAS = "tasks"
    let KEY_DESCRIPCION_POST = "descripcion"
    let KEY_IMAGEN_POST = "imagen"
}

