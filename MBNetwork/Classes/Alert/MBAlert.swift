//
//  MBAlerter.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import ObjectMapper

extension MBAlertType: MBAlertable {
    public var container: MBContainable? {
        switch self {
        case .default(let container):
            return container
        case .none:
            return nil
        }
    }
    
    public func show(error: MBErrorSerializable) {
        switch self {
        case .none:
            break
        case .default(let container):
            let alertController = UIAlertController(title: "Warnning", message: error.message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if let container = container.container() {
                container.viewController()?.present(alertController, animated: true, completion: nil)
            }
            break
        }
    }
}

public enum MBAlertType {
    case none
    case `default`(container:MBContainable)
}

public protocol MBAlertable {
    var container: MBContainable? { get }
    
    func show(error: MBErrorSerializable)
}

public protocol MBErrorConfigurable {
    var node: String? { get }
    var codes: [String] { get }
}

public protocol MBErrorSerializable: Mappable {
    var code: String? { get }
    var message: String? { get }
}
