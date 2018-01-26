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

class ParserGenerico: NSObject {
        
    var jsonDataGenerico : JSON?
    
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
            self.jsonDataGenerico = JSON(data)
            return self.jsonDataGenerico!
        }
    }
    
    /// getParserGenerico()
    ///
    /// - Parameter completion: @escaping (_ arrayData :[GenericModelData]?) -> ()
    func getParserGenerico(_ completion : @escaping (_ arrayData :[GenericModelData]?) -> ()) {
        var arrayMovies = [GenericModelData]()
            for c_movie in (jsonDataGenerico?["feed"]["entry"].arrayValue)!{
                let modelData = GenericModelData(json: c_movie)
                arrayMovies.append(modelData)
            }
            completion(arrayMovies)
    }
}
