//
//  MuroTableViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher

class MuroTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImage = UIImage(named: "title_So_Ever")
        self.navigationItem.titleView = UIImageView(image: logoImage)
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //TODO: - Registro de celda //ISPostCustomCell
        tableView.register(UINib(nibName: MiPerfilCustomCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: MiPerfilCustomCell.defaultReuseIdentifier)
        tableView.register(UINib(nibName: GenericTableViewCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: GenericTableViewCell.defaultReuseIdentifier)
        
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
            return taskManager.descripcionPost.count
        }
       
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            let customCell = tableView.dequeueReusableCell(withIdentifier: MiPerfilCustomCell.defaultReuseIdentifier, for: indexPath) as! MiPerfilCustomCell
            let customPerfilCell = EVERISRellenarCeldas().tipoGenericoPerfil(customCell)
            return customPerfilCell
        default:
            
            let postCustomCell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.defaultReuseIdentifier, for: indexPath) as! GenericTableViewCell
            
            let arrayDescripcion = taskManager.descripcionPost[indexPath.row]
            let arrayFotoTareas = taskManager.fotoPost[indexPath.row]
            
            postCustomCell.myInformacionOferta.text = arrayDescripcion[CONSTANTES.NSURSER_DEFAULT.KEY_DESCRIPCION_POST] as! String?
            
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
             return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
