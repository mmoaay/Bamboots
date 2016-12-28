//
//  UIRefreshControl+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 28/12/2016.
//
//

import Foundation

// MARK: - Making UIRefreshControl conforms to MBLoadable
extension UIRefreshControl:MBLoadable {
    
    /// There is not need to add mask for UIRefreshControl
    open var container:MBContainable? {
        return nil
    }
    
    
    /// Begin refreshing when network request begins
    open func begin() {
        self.beginRefreshing()
    }
    
    
    /// End refreshing when network request ends
    open func end() {
        self.endRefreshing()
    }
}
