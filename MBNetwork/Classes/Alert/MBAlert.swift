//
//  MBAlerter.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import ObjectMapper
import Alamofire

extension MBAlertType: MBAlertable {
    public func show(error: MBErrorable?) {
        switch self {
        case .none:
            break
        case .alertController(let container):
            let alertController = UIAlertController(title: "Warnning", message: error?.message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if let container = container.containerView() {
                container.viewController()?.present(alertController, animated: true, completion: nil)
            }
            break
        }
    }
}

public enum MBAlertType {
    case none
    case alertController(container:MBContainable)
}

extension MBAlertable {
    public func alertContainer() -> MBContainable? {
        return nil
    }
}

public protocol MBAlertable {
    func alertContainer() -> MBContainable?
    
    func show(error: MBErrorable?)
}
