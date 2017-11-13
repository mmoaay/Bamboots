//
//  UIScrollView+Bamboots.swift
//  Pods
//
//  Created by ZhengYidong on 15/12/2016.
//
//

import Foundation

// MARK: - Making `UIScrollView` conforms to `Containable`
extension UIScrollView {

    /// Return latest superview that is not `UIScrollView` as container for `UIScrollView`, because add mask to `UIScrollView`(PS: Including its subclass such as `UITableView` and `UICollectionView`) will cause something abnormal
    ///
    /// - Returns: Latest `superview` that is not `UIScrollView`
// TODO: build    public override func containerView() -> UIView? {
//        var next = superview
//        while nil != next {
//            if let _ = next as? UIScrollView {
//                next = next?.superview
//            } else {
//                return next
//            }
//        }
//        return nil
//    }
}
