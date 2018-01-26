//
//  GenericModelData.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenericModelData: NSObject {
    
    var id : String?
    var title : String?
    var summary : String?
    var image : String?
    var category : String?
    var director : String?
    var releaseDate : String?
    var rentalPrice : String?
    var link : String?
        
    init(json : JSON) {
        self.id = dimeString(json["id"]["attributes"], nombre: "im:id")
        self.title = dimeString(json["im:name"], nombre: "label")
        self.summary = dimeString(json["summary"], nombre: "label")
        self.image = dimeString(json["im:image"][2], nombre: "label".replacingOccurrences(of: "170x170", with: "500x500"))
        self.category = dimeString(json["category"]["attributes"], nombre: "label")
        self.director = dimeString(json["im:artist"], nombre: "label")
        self.releaseDate = dimeString(json["im:releaseDate"]["attributes"], nombre: "label")
        self.rentalPrice = dimeString(json["im:price"], nombre: "label")
        self.link = dimeString(json["link"][0]["attributes"], nombre: "href")
    }
}

