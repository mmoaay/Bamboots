//
//  Display.swift
//  Alamofire
//
//  Created by ZhengYidong on 29/11/2017.
//

import Foundation

public protocol Displayable {
    /// Mask
    ///
    /// - Returns: Object that conforms to `Maskable` protocol
    func mask() -> Maskable?
    
    /// Inset
    ///
    /// - Returns: The inset between mask and maskContainer
    func inset() -> UIEdgeInsets
    
    /// Mask Container
    ///
    /// - Returns: Object that conforms to `Containable` protocol
    func maskContainer() -> Containable?
}

public extension Displayable {
    func inset() -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func maskContainer() -> Containable? {
        return nil
    }
    
    /// Default show method for `Loadable`, calling this method will add mask on maskContainer
    func show() {
        if let mask = self.mask() as? UIView {
            var isHidden = false
            if let _ = self.maskContainer()?.latestMask() {
                isHidden = true
            }
            self.maskContainer()?.containerView()?.addSubView(mask, insets: self.inset())
            mask.isHidden = isHidden
            
            if let container = self.maskContainer(), let scrollView = container as? UIScrollView {
                scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    /// Default hide method for `Loadable`, calling this method will remove mask from maskContainer
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
