//
//  Loader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

// MARK: - LoadType
extension LoadType: Loadable {
    public func maskContainer() -> Containable? {
        switch self {
        case .default(let container):
            return container
        case .none:
            return nil
        }
    }

    public func begin() {
        show()
    }

    public func end() {
        hide()
    }
}

/// Load type enum
///
/// - none: No mask will be shown on maskContainer
/// - `default`: Show mask on container
public enum LoadType {
    case none
    case `default`(container: Containable)
}

/// Protocol used for showing mask on specified container when requesting (such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends). Object conforms to this protocol can be used by load method of DataRequest
public protocol Loadable: Displayable {
    /// Request begin
    func begin()

    /// Request end
    func end()
}

// MARK: - Loadable
public extension Loadable {
    public func mask() -> Maskable? {
        return MaskView()
    }
    
    func begin() {
        show()
    }

    func end() {
        hide()
    }
}
