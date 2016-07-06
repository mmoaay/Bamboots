//
//  MBForm.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import Foundation

extension NSObject {
    func getParameters() -> Dictionary<String, AnyObject> {
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.alloc(0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        
        for(var i=0;i<countInt;i++){
            let temp = buff[i]
            let tempPro = property_getName(temp)
            let proper = String.init(UTF8String: tempPro)
            result.append(proper!)
            
        }
    }
}
