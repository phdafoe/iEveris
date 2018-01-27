//
//  PeliculasViewController.swift
//  iEveris
//
//  Created by Andres Felipe Ocampo Eljaiesk on 23/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import APESuperHUD

class PeliculasViewController: UIViewController {
    
    //MARK: - Variables locales
    var refresh : UIRefreshControl?
    var arrayGenerico : [GenericModelData] = []
    var customCellData : GenericCollectionViewCell?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PELICULAS"
        
        //LLAMADA A DATOS
        llamadaGenerica()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        refresh?.addTarget(self, action: #selector(self.refreshControll), for: .valueChanged)
        myCollectionView!.addSubview(refresh!)

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - UTILS
    func llamadaGenerica(){
        let providerService = ProviderService()
        let parserGenerico = ParserGenerico()
        let idName = "topmovies"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOfertaSegue"{
            let detalleVC = segue.destination as! DetalleGenericoTableViewController
            let selectInd = myCollectionView.indexPathsForSelectedItems?.first?.row//myCollectionView.indexPathForSelectedRow?.row
            let objInd = arrayGenerico[selectInd!]
            //Asignar la oferta seleccionada
            detalleVC.movie = objInd
            //Recuperar la imagen de la lista local
            detalleVC.detalleImagenData = diccionarioImagenes[objInd.id!]!
        }
    }
    
    @objc func refreshControll(){
        llamadaGenerica()
        myCollectionView!.reloadData()
        self.refresh?.endRefreshing()
        
    }
    
    
    

}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension PeliculasViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        customCellData = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imagenSeleccionada = customCellData?.myImagePoster.image
        performSegue(withIdentifier: "showOfertaSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSpacing = CGFloat(1) //Define the space between each cell
        let leftRightMargin = CGFloat(20) //If defined in Interface Builder for "Section Insets"
        let numColumns = CGFloat(2) //The total number of columns you want
        let totalCellSpace = cellSpacing * (numColumns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - leftRightMargin - totalCellSpace) / numColumns
        var height = CGFloat(270) //whatever height you want
        height = width * height / 180
        return CGSize(width: width, height: height)
    }
    
    
}



