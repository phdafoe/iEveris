//
//  ParserGenerico.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ProviderGenerico: NSObject {
            
    /// getDatosGenerico()
    ///
    /// - Parameter idName: idName : String
    /// - Returns: Promise<JSON>
    func getDatosGenerico(_ idName : String, idCountry : String , idNumber : String ) -> Promise<JSON>{
        
        let format = CONSTANTES.LLAMADAS.BASE_ITUNES_GENERAL
        let arguments : [CVarArg] = [idCountry, idName, idNumber]
        let urlString = String(format: format, arguments: arguments)

        let request = URLRequest(url: URL(string: urlString)!)
        /*let request = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_ITUNES_TOP + idName + CONSTANTES.LLAMADAS.LASTPATH_COMPONENT)!)*/
        print(request)
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            jsonDataGenerico = JSON(data)
            return jsonDataGenerico!
        }
    }
    
}
