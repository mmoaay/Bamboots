//
//  UIRefreshControl+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 28/12/2016.
//
//

import Foundation

// MARK: - Making UIRefreshControl conforms to MBLoadable
extension UIRefreshControl: MBLoadable {
    
    /// Begin refreshing when network request begins
    public func begin() {
        if false == self.isRefreshing {
            self.beginRefreshing()
        }
    }
    
    /// End refreshing when network request ends
    public func end() {
        self.endRefreshing()
    }
}
