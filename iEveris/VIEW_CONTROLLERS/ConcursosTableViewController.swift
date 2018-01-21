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
        
        self.title = "CONCURSOS"
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //LLAMADA A DATOS
        llamadaGenerica()
        
        //TODO: - Registro de celda
        tableView.register(UINib(nibName: GenericTableViewCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: GenericTableViewCell.defaultReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = EVERISRellenarCeldas().tipoGenericoOfertas(customCell,
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
            detalleVC.oferta = objInd
            
            //Recuperar la imagen de la lista local
            detalleVC.detalleImagenData = diccionarioImagenes[objInd.id!]!
            
            /*detalleVC.oferta = objInd
             do{
             let imageData = UIImage(data: try Data(contentsOf: URL(string: CONSTANTES.LLAMADAS.BASE_PHOTO_URL + (objInd.id)! + "/" + (objInd.imagen)!)!))
             detalleVC.detalleImagenData = imageData!
             }catch let error{
             print("Error: \(error.localizedDescription)")
             }*/
            
            
        }
    }
    
    
    
    
    //MARK: - UTILS
    func llamadaGenerica(){
        
        let datosOfertas = ParserGenerico()
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.CONCURSO
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        
        firstly{
            return when(resolved: datosOfertas.getDatosGenerico(idLocalidad,
                                                                idTipo: tipoOferta,
                                                                idParametro: tipoParametro))
            }.then{_ in
                self.arrayGenerico = datosOfertas.getParserGenerico()
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
