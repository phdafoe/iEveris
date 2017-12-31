//
//  HomeNavigationViewController.swift
//  iEveris
//
//  Created by Andres on 31/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UINavigationController {
    
    //MARK: - Variables locales
    let botonFlotante = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        botonFlotante.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 64.0, height: 64.0))
        botonFlotante.setImage(UIImage(named: "boton_Menu_MiPerfil"), for: UIControlState())
        botonFlotante.center = CGPoint(x: self.view.bounds.width - 42.0, y: self.view.bounds.height - 100.0)
        botonFlotante.addTarget(self, action: #selector(self.showVCNuevoComentario), for: .touchUpInside)
        self.view.addSubview(botonFlotante)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func showVCNuevoComentario(){
        let nuevoPostVC = self.storyboard?.instantiateViewController(withIdentifier: "HerramientaPostMuroTableViewController") as! HerramientaPostMuroTableViewController
        let navController = UINavigationController(rootViewController: nuevoPostVC)
        self.present(navController, animated: true, completion: nil)
    }

}
