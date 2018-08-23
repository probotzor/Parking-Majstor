//
//  Archive.swift
//  Parking Majstor
//
//  Created by Milos Jakovljevic on 8/30/17.
//  Copyright © 2017 Milos Jakovljevic. All rights reserved.
//

import Foundation

class ArchiveUtil {
    
    private static let TablicaKey = "TablicaKey"
    private static let JednaTablica = "JednaTablica"
    
    private static func archiveTablica(tablica : [Tablica]) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: tablica as NSArray) as NSData
    }
    
    static func loadTablica() -> [Tablica]? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: TablicaKey) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [Tablica]
        }
        
        return nil
    }
    
    static func saveTablica(tablica : [Tablica]?) {
        
        let archivedObject = archiveTablica(tablica: tablica!)
        UserDefaults.standard.set(archivedObject, forKey: TablicaKey)
        UserDefaults.standard.synchronize()
    }
    

    
}
