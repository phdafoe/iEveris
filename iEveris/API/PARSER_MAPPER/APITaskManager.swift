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
    var tareas : arrayDiccionario = [[:]]
    var fotoPost : arrayDiccionario = [[:]]
    var descripcionPost : arrayDiccionario = [[:]]
    
    func salvarDatos(){
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.set(tareas, forKey: CONSTANTES.NSURSER_DEFAULT.KEY_TAREAS)
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.set(fotoPost, forKey: CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST)
        CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.set(descripcionPost, forKey: CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST)
    }
    
    
    func cargarDatos(){
        if let myArrayTask = CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.array(forKey: CONSTANTES.NSURSER_DEFAULT.KEY_TAREAS) as? arrayDiccionario{
            //Cargamos nuestro array de diccionario una vez lo solicitamos a UserDefault
            tareas = myArrayTask
        }
        
        if let myArrayImagenes = CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.array(forKey: CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST) as? arrayDiccionario{
            fotoPost = myArrayImagenes
        }
        
        if let myArrayDescripcion = CONSTANTES.NSURSER_DEFAULT.USER_DEFAULT.array(forKey: CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST) as? arrayDiccionario{
            descripcionPost = myArrayDescripcion
        }
        
    }
}
