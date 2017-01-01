//
//  MBInform.swift
//  Pods
//
//  Created by zhengperry on 2017/1/1.
//
//

import Foundation


extension MBInformType: MBInformable {
    public func show() {
        switch self {
        case .none:
            break
        case .alertController(let message, let container):
            let alertController = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if let container = container.containerView() {
                container.viewController()?.present(alertController, animated: true, completion: nil)
            }
            break
        }
    }
}

public enum MBInformType {
    case none
    case alertController(message: String, container: MBContainable)
}

public extension MBInformable {
    func alertContainer() -> MBContainable? {
        return nil
    }
    
    func message() -> String {
        return "Success"
    }
}

public protocol MBInformable {
    func alertContainer() -> MBContainable?
    
    func message() -> String
    
    func show()
}
