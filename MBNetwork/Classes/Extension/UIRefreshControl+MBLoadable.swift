//
//  UIRefreshControl+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 28/12/2016.
//
//

import Foundation

// MARK: - Making `UIRefreshControl` conforms to `MBLoadable`
extension UIRefreshControl {

    /// Begin refreshing when network request begins
    public override func begin() {
        if false == self.isRefreshing {
            self.beginRefreshing()
        }
    }

    /// End refreshing when network request ends
    public override func end() {
        self.endRefreshing()
    }
}
