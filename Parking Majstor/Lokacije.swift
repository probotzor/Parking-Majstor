//
//  Lokacije.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/29/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import Foundation

class Lokacije {
    private var _grad: String!
    private var _zona: String!
    private var _opis: String!
    private var _broj: String!
    private var _boja: String!
    
    var grad: String! {
        return _grad
    }
    var zona: String! {
        return _zona
    }
    var opis: String! {
        return _opis
    }
    var broj: String! {
        return _broj
    }
    var boja: String! {
        return _boja
    }
    
    init(grad: String, zona: String, opis: String, broj: String, boja: String) {
        self._grad = grad
        self._zona = zona
        self._opis = opis
        self._broj = broj
        self._boja = boja
    }
    
    
    
}
