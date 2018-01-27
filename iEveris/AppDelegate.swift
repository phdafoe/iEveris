//
//  AppDelegate.swift
//  iEveris
//
//  Created by Andres on 23/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK : - Variables locales
    var puedoRotar = false
    var orientacionDisponible : UIInterfaceOrientationMask = .portrait
    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Aqui cargamos el metodo cargarDatos() que vienen de Disco
        taskManager.cargarDatos()
        
        //Aqui personalizamos la UI de la app
        personalizaUI()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        //Aqui salvamos los datos
        taskManager.salvarDatos()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        //Aqui salvamos los datos
        taskManager.salvarDatos()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        //Aqui cargamos los datos
        taskManager.cargarDatos()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //Aqui cargamos los datos
        taskManager.cargarDatos()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //Aqui salvamos los datos
        taskManager.salvarDatos()
    }
    
    //MARK: - Orientacion del dispositivo
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if puedoRotar == true{
            return .all
        }else{
            return orientacionDisponible
        }
    }
    
    //Personalizacion de la UI de la APP en un solo sitio
    func personalizaUI(){
        let navBar = UINavigationBar.appearance()
        let tabBar = UITabBar.appearance()
        let toolBar = UIToolbar.appearance()
        
        navBar.barTintColor = CONSTANTES.COLORES.AZUL_NAV_TAB
        tabBar.barTintColor = CONSTANTES.COLORES.AZUL_NAV_TAB
        
        toolBar.barTintColor = CONSTANTES.COLORES.AZUL_NAV_TAB
        toolBar.tintColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        
        navBar.tintColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        tabBar.tintColor = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : CONSTANTES.COLORES.BLANCO_TEXTO_NAV]
    }


}

