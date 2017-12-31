//
//  MuroTableViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class MuroTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: - Registro de celda //ISPostCustomCell
        tableView.register(UINib(nibName: "MiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "MiPerfilCustomCell")
        tableView.register(UINib(nibName: "GenericTableViewCell", bundle: nil), forCellReuseIdentifier: "GenericTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        default:
            if taskManager.descripcionPost.count == 0{
                return 0
            }else{
                return taskManager.descripcionPost.count
            }
        }
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let customPerfilCell = tableView.dequeueReusableCell(withIdentifier: "MiPerfilCustomCell", for: indexPath) as! MiPerfilCustomCell
            
            //nombre y apellido
            customPerfilCell.myNombrePerfilUsuario.text = "Andres"
            customPerfilCell.myUsernameSportReviewLBL.text = "Ocampo"
            
            customPerfilCell.myBotonAjustesPerfilUsuario.tag = indexPath.row
           /* customPerfilCell.myBotonAjustesPerfilUsuario.addTarget(self,
                                                                   action: #selector(muestraVCConfiguration),
                                                                   for: .touchUpInside)*/
            customPerfilCell.myFotoPerfilUsuario.image = UIImage(named: "steve_jobs")
            customPerfilCell.myUsuarioGenerales.tag = indexPath.row
            /*customPerfilCell.myUsuarioGenerales.addTarget(self,
                                                          action: #selector(muestraTablaUsuarios),
                                                          for: .touchUpInside)*/
            
            return customPerfilCell
        default:
            
            let postCustomCell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell
            
            let arrayDescripcion = taskManager.descripcionPost[indexPath.row]
            let arrayFotoTareas = taskManager.fotoPost[indexPath.row]
            
            
            postCustomCell.myInformacionOferta.text = arrayDescripcion[CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST] as! String?
            
//            if let imagenDes = arrayDescripcion[CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST]{
//                postCustomCell.myImagenOferta.image = UIImage(named: imagenDes as! String)
//            }else{
//                postCustomCell.myImagenOferta.image = UIImage(named: "img_no_icon")
//            }
            
            
            if let imagenPostDes = arrayFotoTareas[CONSTANTES.NSURSER_DEFAULT.KEY_IMAGEN_POST] as? Data{
                let storage = imagenPostDes
                postCustomCell.myImagenOferta.image = UIImage(data: storage)
            }
            
            return postCustomCell
        }
        
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 305
        default:
            return 310
        }
    }
    
    
    
   
    
   

}
