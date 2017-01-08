//
//  TableHeaderView.swift
//  MBNetwork
//
//  Created by Perry on 15/7/3.
//  Copyright © 2015年 MmoaaY. All rights reserved.
//

import UIKit

class TableHeaderView: NSObject {
    @IBOutlet var contentView: UIView!

    static let shared = TableHeaderView()

    func getView() -> UIView! {
        Bundle.main.loadNibNamed("TableHeaderView", owner: self, options: nil)
        return self.contentView
    }
}
