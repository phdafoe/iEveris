//
//  DetalleGenericoTableViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import MapKit
import PromiseKit
import Kingfisher
import APESuperHUD

class DetalleGenericoTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var movie : GenericModelData?
    var detalleImagenData : UIImage?
    //MARK: - Variables locales
    var arrayGenerico : [GenericModelData] = []
    let latitud = 40.352494
    let longitud = -3.809620
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myFechaOferta: UILabel!
    @IBOutlet weak var myInformacionOferta: UILabel!
    @IBOutlet weak var myNombreAsociado: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myMovilAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myTelefonoFijo: UIButton!
    @IBOutlet weak var myWebURL: UIButton!
    @IBOutlet weak var myImageBackground: UIImageView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBAction func myLlamarFijoACTION(_ sender: UIButton) {
        //Recuperar el teléfono
        let telefono = sender.titleLabel?.text
        if let telefonoDes = telefono {
            llamar(telefonoDes)
        }
        
    }
    
    @IBAction func myCargarPaginaACTION(_ sender: UIButton) {
        if let web = sender.titleLabel?.text {
            muestraPaginaWebAsociado(web)
        }
    }
    
    @IBAction func muestraRutaConOtraAppACTION(_ sender: UIButton) {
        openMapForPlace()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //LLAMADA A DATOS
        llamadaGenerica()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let movieDes = movie{
            self.title = movieDes.title
            myImagenOferta.image = detalleImagenData
            myImageBackground.image = detalleImagenData
            myNombreOferta.text = movieDes.title
            myFechaOferta.text = movieDes.releaseDate
            myInformacionOferta.text = movieDes.director
            //myNombreAsociado.text = AsociadoDes.nombre
            myDescripcionAsociado.text = movieDes.summary
            myMovilAsociado.text = "663940573"
            myEmailAsociado.text = "mail@mail.com"
            myWebURL.setTitle("www.andresocampo.com", for: .normal)
            myTelefonoFijo.setTitle("663940573", for: .normal)
            
        }
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitud, longitud), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitud, longitud)
        annotation.title = movie?.title
        annotation.subtitle = movie?.title
        myMapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    ///Permite llamar a un número de teléfono
    func llamar(_ telefono : String){
        if let phoneCallURL = URL(string: "tel://\(telefono)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    ///Mostrar un viewcontroller con una web
    func muestraPaginaWebAsociado(_ url: String){
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebGenericoViewController") as! WebGenericoViewController
        webVC.urlWeb = url
        present(webVC, animated: true, completion: nil)
    }
    
    //Muestra Mapa de Apple
    func openMapForPlace() {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitud, longitud)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name =  movie?.title
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    //MARK: - UTILS
    func llamadaGenerica(){
        
        let providerService = ProviderService()
        let parserGenerico = ParserGenerico()
        let idName = "toppaidebooks"
        let idCountry = "es"
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Cargando", presentingView: self.view)
        firstly{
            return when(resolved: providerService.getDatosGenerico(idName, idCountry: idCountry, idNumber: randonNumber ()))
            }.then{_ in
                parserGenerico.getParserGenerico({ (data) in
                    guard let dataDes = data else{return}
                    self.arrayGenerico = dataDes
                })
            }.then{_ in
                self.myCollectionView.reloadData()
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


extension DetalleGenericoTableViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGenerico.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modeldata = arrayGenerico[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! GenericCollectionViewCell
        let cell = EVERISRellenarCeldas().tipoGenericoCollectionCell(customCell,
                                                                     arrayGenerico: modeldata,
                                                                     row: indexPath.row)
        //customCellData = cell
        return cell
    }
    
    
    
    
}
