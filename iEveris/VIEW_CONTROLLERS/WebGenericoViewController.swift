//
//  WebGenericoViewController.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class WebGenericoViewController: UIViewController {

    //MARK: - Variables Locales
    var urlWeb : String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: UIWebView!
    
    
    @IBAction func myCerrarVentanaACTION(_ sender: UIButton) {
        appDelegate.puedoRotar = false
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         appDelegate.puedoRotar = true
        
        //Mostrar activity inicialmente
        myActivityIndicator.isHidden = false
        
        //Crear delegados para la web
        myWebView.delegate = self
        
        //Cargar datos de la página
        let url = URL(string: "http://" + urlWeb!)
        let peticion = URLRequest(url: url!)
        myWebView.loadRequest(peticion)
    }
    
    //DEBERIA AUTORITARSE
    override var shouldAutorotate: Bool{
        return true
    }
    
}

extension WebGenericoViewController : UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivityIndicator.isHidden = true
        myActivityIndicator.stopAnimating()
    }
}
