//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import SwiftyJSON
import Alamofire

public protocol MBReloadable {
    func reload()
}

public extension MBRequestable  {
    public func send(loadType:MBLoadType)  {
        
        if let loadable = self as? MBLoadable {
            loadable.showLoad(loadType)
        }
        
        Alamofire.request(.GET, "https://www.baidu.com").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    if let loadable = self as? MBLoadable {
                        loadable.hideLoad(loadType)
                    }
                }
            case .Failure(let error):
                print(error)
                
                if let loadable = self as? MBLoadable {
                    loadable.hideLoad(loadType)
                }
            }
        }
    }
}

public protocol MBRequestable : class{
    
}




