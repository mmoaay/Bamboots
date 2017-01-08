//
//  MBLoader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation



// MARK: - MBLoadType
extension MBLoadType: MBLoadable {
    public func maskContainer() -> MBContainable? {
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
public enum MBLoadType {
    case none
    case `default`(container: MBContainable)
}

/// Protocol used for showing mask on specified container when requesting (such as add `UIActivityIndicatorView` on `UIViewcontroller`'s view when request begins, and remove it when request ends). Object conforms to this protocol can be used by load method of DataRequest
public protocol MBLoadable {
    /// Mask
    ///
    /// - Returns: Object that conforms to `MBMaskable` protocol
    func mask() -> MBMaskable?
    
    /// Inset
    ///
    /// - Returns: The inset between mask and maskContainer
    func inset() -> UIEdgeInsets
    
    /// Mask Container
    ///
    /// - Returns: Object that conforms to `MBContainable` protocol
    func maskContainer() -> MBContainable?
    
    /// Request begin
    func begin()
    
    /// Request end
    func end()
}


// MARK: - MBLoadable
public extension MBLoadable {
    func mask() -> MBMaskable? {
        return MBMaskView()
    }
    
    func inset() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func maskContainer() -> MBContainable? {
        return nil
    }
    
    func begin() {
        show()
    }

    func end() {
        hide()
    }
    
    /// Default show method for `MBLoadable`, calling this method will add mask on maskContainer
    func show() {
        if let mask = self.mask() as? UIView {
            var isHidden = false
            if let latestMask = self.maskContainer()?.latestMask() {
                isHidden = true
            }
            self.maskContainer()?.containerView()?.addMBSubView(mask, insets: self.inset())
            mask.isHidden = isHidden
            
            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    /// Default hide method for `MBLoadable`, calling this method will remove mask from maskContainer
    func hide() {
        if let latestMask = self.maskContainer()?.latestMask() {
            latestMask.removeFromSuperview()
            
            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                if false == latestMask.isHidden {
                    scrollView.isScrollEnabled = true
                }
            }
        }
    }
}


