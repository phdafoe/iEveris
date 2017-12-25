//
//  OfertasTableViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import APESuperHUD

class OfertasTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayGenerico : [GenericModelData] = []
    
    //Diccionario para almacenar localmente las imágenes
    var imagenSeleccionada : UIImage?
    var diccionarioImagenes = [String: UIImage?]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LLAMADA A DATOS
        llamadaGenerica()

        //TODO: - Registro de celda
        tableView.register(UINib(nibName: "GenericTableViewCell", bundle: nil), forCellReuseIdentifier: "GenericTableViewCell")
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
        
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell

        let model = arrayGenerico[indexPath.row]
        
        customCell.myNombreOferta.text = model.nombre
        customCell.myFechaOferta.text = model.fechaFin
        customCell.myInformacionOferta.text = model.masInformacion
        customCell.myImporteOferta.text = model.importe
        
        //Recuperar en background la imagen
        if var pathImagen = model.imagen {
            
            pathImagen = CONSTANTES.LLAMADAS.BASE_URL + pathImagen
            
            
            let pathComplete = getImagePath(CONSTANTES.LLAMADAS.OFERTAS, id: model.id!, name: model.imagen!)
            customCell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathComplete)!),
                                                         placeholder: #imageLiteral(resourceName: "placeholder"),
                                                         options: [.transition(ImageTransition.fade(1))],
                                                         progressBlock: nil,
                                                         completionHandler: { (image, error, cacheType, imageUrl) in
                                                            //guardamos las imágenes en un diccionario
                                                            self.diccionarioImagenes[model.id!] = image!
            })
        }

        return customCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    func getImagePath(_ type: String, id : String!, name : String!) -> String{
        return CONSTANTES.LLAMADAS.BASE_PHOTO_URL + id + "/" + name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as! GenericTableViewCell
        imagenSeleccionada = customCell.myImagenOferta.image
        performSegue(withIdentifier: "showOfertaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showOfertaSegue"{
            
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
        let tipoOferta = CONSTANTES.LLAMADAS.OFERTAS
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
