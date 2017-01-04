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

public enum MBLoadType {
    case none
    case `default`(container:MBContainable)
}

// MARK: - MBLoadable
public protocol MBLoadable {
    func mask() -> MBMaskable?
    
    func inset() -> UIEdgeInsets
    
    func maskContainer() -> MBContainable?
    
    /// request begin
    func begin()
    
    /// request end
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


