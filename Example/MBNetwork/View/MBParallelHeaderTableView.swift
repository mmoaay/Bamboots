//
//  MBParallelHeaderTableView.swift
//  MBPageControllerFromMomo
//
//  Created by Perry on 15/7/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBParallelHeaderTableView:UITableView {
    
}

extension MBParallelHeaderTableView : UIScrollViewDelegate{
    private struct AssociatedKeys {
        static var parallelHeaderViewHeightKey = "parallelHeaderViewHeightKey"
        static var parallelHeaderViewKey = "parallelHeaderViewKey"
    }
    
    var parallelHeaderViewHeight:CGFloat{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.parallelHeaderViewHeightKey) as! CGFloat
        }
        set(height) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.parallelHeaderViewHeightKey,
                height as CGFloat?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    weak var parallelHeaderView:UIView?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.parallelHeaderViewKey) as? UIView
        }
        set(view) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.parallelHeaderViewKey,
                view as UIView?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            
            self.parallelHeaderViewHeight = (view?.bounds.size.height)!
            
            self.backgroundColor = UIColor.clear
            
            let scrollView = self as UIScrollView
            scrollView.delegate = self
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPos = scrollView.contentOffset.y
        
        if yPos < 0.0 {
            let transform = CGAffineTransform(translationX: 0.0, y: -yPos/2.0)
            self.parallelHeaderView?.transform = transform.scaledBy(x: 1.0-(yPos/self.parallelHeaderViewHeight)*2.0, y: 1.0-(yPos/self.parallelHeaderViewHeight)*2.0)
        }else {
            let transform = CGAffineTransform(translationX: 0.0, y: -yPos/2.0)
            self.parallelHeaderView?.transform = transform.scaledBy(x: 1.0, y: 1.0)
        }
    }
}
