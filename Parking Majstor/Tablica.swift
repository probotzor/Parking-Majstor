//
//  Tablica.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import Foundation

class Tablica: NSObject, NSCoding {
    
    private var _grad: String!
    private var _broj: String!
    private var _slova: String!
    private var _cela: String!
    
    var grad: String! {
        return _grad
    }
    var broj: String! {
        return _broj
    }
    var slova: String! {
        return _slova
    }
    var cela: String! {
        return _cela
    }
    
    init(grad: String, broj: String, slova: String, cela: String) {
        self._grad = grad
        self._broj = broj
        self._slova = slova
        self._cela = cela
    }
    
    required init(coder aDecoder: NSCoder) {
        _grad = aDecoder.decodeObject(forKey: "grad") as! String
        _broj = aDecoder.decodeObject(forKey: "broj") as! String
        _slova = aDecoder.decodeObject(forKey: "slova") as! String
        _cela = aDecoder.decodeObject(forKey: "cela") as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(_grad, forKey: "grad")
        aCoder.encode(_broj, forKey: "broj")
        aCoder.encode(_slova, forKey: "slova")
        aCoder.encode(_cela, forKey: "cela")
    }
    
    
    
}
