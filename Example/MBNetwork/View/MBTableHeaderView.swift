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
    
    static let shared = MBTableHeaderView()
    
    func getView() -> UIView! {
        Bundle.main.loadNibNamed("MBTableHeaderView", owner: self, options: nil)
        return self.contentView
    }
}
