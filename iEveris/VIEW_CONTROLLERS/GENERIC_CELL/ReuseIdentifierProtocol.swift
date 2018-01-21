//
//  ReuseIdentifierProtocol.swift
//  iEveris
//
//  Created by Andres on 21/1/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import Foundation
import UIKit

public protocol ReuseIdentifierProtocol : class{
    static var defaultReuseIdentifier : String{get}
}

public extension ReuseIdentifierProtocol where Self : UIView{
    static var defaultReuseIdentifier : String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
