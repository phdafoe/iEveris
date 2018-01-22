//
//  GenericModelData.swift
//  iEveris
//
//  Created by Andres on 25/12/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

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
    
    init(pId : String, pTitle : String, pSummary : String, pImage : String, pCategory : String, pDirector : String, pReleaseDate : String, pRentalPrice : String, pLink : String) {
        self.id = pId
        self.title = pTitle
        self.summary = pSummary
        self.image = pImage
        self.category = pCategory
        self.director = pDirector
        self.releaseDate = pReleaseDate
        self.rentalPrice = pReleaseDate
        self.link = pLink
    }
}

