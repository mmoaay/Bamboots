//
//  MBMessage.swift
//  Pods
//
//  Created by Perry on 16/8/9.
//
//

import Foundation
import ObjectMapper
import Alamofire

extension MBMessageType: MBWarnable, MBInformable {
    public func show() {
       show(error: nil)
    }

    public func show(error: MBErrorable?) {
        switch self {
        case .none:
            break
        case .alertController(let title, var message, let actions, let container):
            if let err = error {
                message = err.message
                
                if "" == err.message {
                    return
                }
            }
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            for action in actions {
                alertController.addAction(action)
            }
            
            if let container = container.containerView() {
                container.viewController()?.present(alertController, animated: true, completion: nil)
            }
            break
        }
    }
}


/// Message type enum
///
/// - none: No message will be shown
/// - alertController: Show alertController with tile, message and actions on container
public enum MBMessageType {
    case none
    case alertController(title: String, message: String? , actions: [UIAlertAction], container: MBContainable)
}

public extension MBInformable {
    func message() -> String {
        return "Successfully"
    }
}

/// Inform protocol. Conforming to this protocol to customize the way of inform messages displayed when request done successfully
public protocol MBInformable: MBMessageable {
    func show()

    func message() -> String
}

/// Warn protocol. Conforming to this protocol to customize the way of warning messages displayed when error occured
public protocol MBWarnable: MBMessageable {
    func show(error: MBErrorable?)
}

public extension MBMessageable {
    func messageContainer() -> MBContainable? {
        return nil
    }
}

/// Message protocol
public protocol MBMessageable {
    func messageContainer() -> MBContainable?
}
