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
    func getDatosGenerico(_ idName : String) -> Promise<JSON>{
        let request = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_ITUNES_TOP + idName + CONSTANTES.LLAMADAS.LASTPATH_COMPONENT)!)
        print(request)
        return Alamofire.request(request).responseJSON().then{(data) -> JSON in
            self.jsonDataGenerico = JSON(data)
            return self.jsonDataGenerico!
        }
    }
    
    /// getParserGenerico()
    ///
    /// - Returns: [GenericModelData]
    func getParserGenerico() -> [GenericModelData]{
        var arrayMovies = [GenericModelData]()
        for c_movie in (jsonDataGenerico?["feed"]["entry"].arrayValue)!{
            let modelData = GenericModelData(pId: dimeString(c_movie["id"]["attributes"], nombre: "im:id"),
                                             pTitle: dimeString(c_movie["im:name"], nombre: "label"),
                                             pSummary: dimeString(c_movie["summary"], nombre: "label"),
                                             pImage: dimeString(c_movie["im:image"][2], nombre: "label".replacingOccurrences(of: "170x170", with: "500x500")),
                                             pCategory: dimeString(c_movie["category"]["attributes"], nombre: "label"),
                                             pDirector: dimeString(c_movie["im:artist"], nombre: "label"),
                                             pReleaseDate: dimeString(c_movie["im:releaseDate"]["attributes"], nombre: "label"),
                                             pRentalPrice: dimeString(c_movie["im:price"], nombre: "label"),
                                             pLink: dimeString(c_movie["link"][0]["attributes"], nombre: "href"))
            arrayMovies.append(modelData)
        }
        return arrayMovies
    }
}
