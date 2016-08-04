//
//  MBTableHeaderView.swift
//  MBPageControllerFromMomo
//
//  Created by Perry on 15/7/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class MBTableHeaderView: NSObject {
    @IBOutlet var contentView: UIView!
    
    class func shareInstance() -> MBTableHeaderView{
        struct MBSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:MBTableHeaderView? = nil
        }
        dispatch_once(&MBSingleton.predicate,{
            MBSingleton.instance=MBTableHeaderView()
            }
        )
        return MBSingleton.instance!
    }
    
    func getView() -> UIView! {
        NSBundle.mainBundle().loadNibNamed("MBTableHeaderView", owner: self, options: nil)
        return self.contentView
    }
}
