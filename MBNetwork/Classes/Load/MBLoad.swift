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
    
    public var container: MBContainable? {
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
    var mask: MBMaskable? { get }
    
    var inset: UIEdgeInsets { get }
    
    var container: MBContainable? { get }
    
    /// request begin
    func begin()
    
    /// request end
    func end()
}

///
public protocol MBLoadProgressable {
    func progress(_ progress:Progress)
}


// MARK: - MBLoadable
extension MBLoadable {
    public var mask: MBMaskable? {
        return MBLoading(activityIndicatorStyle: .gray)
    }
    
    public var inset: UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    public func show() {
        if let mask = self.mask as? UIView {
            var isHidden = false
            if let latestMask = self.container?.latestMask() {
                isHidden = true
            }
            self.container?.container()?.addMBSubView(mask, insets: self.inset)
            mask.isHidden = isHidden
            
            if let container = self.container , let scrollView = container as? UIScrollView {
                scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    public func hide() {
        if let latestMask = self.container?.latestMask() {
            latestMask.removeFromSuperview()
            
            if let container = self.container , let scrollView = container as? UIScrollView {
                if false == latestMask.isHidden {
                    scrollView.isScrollEnabled = true
                }
            }
        }
    }
}


