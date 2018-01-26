//
//  InteractorGenerico.swift
//  iEveris
//
//  Created by Andres on 26/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation

class ParserGenerico : NSObject {
    
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
