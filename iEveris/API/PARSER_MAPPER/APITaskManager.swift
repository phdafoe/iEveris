//
//  APITaskManager.swift
//  iEveris
//
//  Created by Andres on 31/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

class APITaskManager{
    
    //contiene un objeto del tipo APITaskManager - con static se consigue que se ejecute una unica vez
    static let sharedInstance = APITaskManager()
    
    //Creamos un Array de diccionarios
    var fotoPost : arrayDiccionario = [[:]]
    var descripcionPost : arrayDiccionario = [[:]]
    
    func salvarDatos(){
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.set(fotoPost, forKey: CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST)
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.set(descripcionPost, forKey: CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST)
        
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.synchronize()
    }
    
    
    func cargarDatos(){
        
        if let myArrayImagenes = CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.array(forKey: CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST) as? arrayDiccionario{
            fotoPost = myArrayImagenes
        }
        
        if let myArrayDescripcion = CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.array(forKey: CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST) as? arrayDiccionario{
            descripcionPost = myArrayDescripcion
        }
        
    }
}
