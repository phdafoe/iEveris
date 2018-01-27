//
//  ConcursosTableViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import APESuperHUD

class ConcursosTableViewController: UITableViewController {

    //MARK: - Variables locales
    var arrayGenerico : [GenericModelData] = []
    var customCellData : GenericTableViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "APPS"
        
        
        //LLAMADA A DATOS
        llamadaGenerica()
        
        //TODO: - Registro de celda
        tableView.register(UINib(nibName: GenericTableViewCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: GenericTableViewCell.defaultReuseIdentifier)
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayGenerico.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modeldata = arrayGenerico[indexPath.row]
        let customCell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.defaultReuseIdentifier, for: indexPath) as! GenericTableViewCell
        let cell = EVERISRellenarCeldas().tipoGenerico(customCell,
                                                       arrayGenerico: modeldata,
                                                       row: indexPath.row)
        customCellData = cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imagenSeleccionada = customCellData?.myImagenOferta.image
        performSegue(withIdentifier: "showConcursoSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showConcursoSegue"{
            
            let detalleVC = segue.destination as! DetalleGenericoTableViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayGenerico[selectInd!]
            //Asignar la oferta seleccionada
            detalleVC.movie = objInd
            //Recuperar la imagen de la lista local
            detalleVC.detalleImagenData = diccionarioImagenes[objInd.id!]!
        }
    }
    
    
    
    
    //MARK: - UTILS
    func llamadaGenerica(){
        let providerService = ProviderService()
        let parserGenerico = ParserGenerico()
        let idName = "topfreeapplications"
        let idCountry = "us"
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        firstly{
            return when(resolved: providerService.getDatosGenerico(idName, idCountry: idCountry, idNumber: randonNumber ()))
            }.then{_ in
                parserGenerico.getParserGenerico({ (data) in
                    guard let dataDes = data else{return}
                    self.arrayGenerico = dataDes
                })
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            }.catch{error in
                self.present(muestraAlertVC("Lo sentimos",
                                            messageData: "Algo salió mal"),
                             animated: true,
                             completion: nil)
        }
    }
    
}
