//
//  Reload.swift
//  Pods
//
//  Created by zhengperry on 2017/1/1.
//
//

import Foundation
import Alamofire

// MARK: - ReloadType
extension ReloadType: Reloadable {
    public var retry: Request? {
        switch self {
        case .default(_, let retry):
            return retry
        case .none:
            return nil
        }
    }
    
    public func maskContainer() -> Containable? {
        switch self {
        case .default(let container, _):
            return container
        case .none:
            return nil
        }
    }
    
    public func display() {
        show()
    }
    
    public func remove() {
        hide()
    }
}

/// Reload type enum
///
/// - none: No mask will be shown on maskContainer
/// - `default`: Show mask on container
public enum ReloadType {
    case none
    case `default`(container: Containable, retry: Request)
}

public protocol Reloadable: RequestRetrier, Displayable {
    var retry: Request? { get }
    
    func display()
    
    func remove()
}

extension Reloadable {
    public func mask() -> Maskable? {
        return MaskView()
    }
    
    public func display() {
        show()
    }
    
    public func remove() {
        hide()
    }
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
    }
}
