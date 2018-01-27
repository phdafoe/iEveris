//
//  SplashViewController.swift
//  iEveris
//
//  Created by Andres on 27/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageLogoSaldos: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    func showData(){
        viewAnimator = UIViewPropertyAnimator(duration: 1.3,
                                              curve: .easeInOut,
                                              animations: {
                                                self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 2,
                                                                                            target: self,
                                                                                            selector: #selector(self.manejadorAutomatico),
                                                                                            userInfo: nil,
                                                                                            repeats: false)
        })
        viewAnimator.startAnimation()
    }
    
    //MARK: - Utils
    @objc func manejadorAutomatico(){
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut) {
                                                    self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 25,
                                                                                                         y: 25)
                                                    self.myImageLogoSaldos.alpha = 0
        }
        logoAnimacion.startAnimation()
        logoAnimacion.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp(){
        
        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabVC.modalTransitionStyle = .crossDissolve
        present(tabVC,
                animated: true,
                completion: nil)
        
    
    }

    

}
