//
//  ReloadView.swift
//  Alamofire
//
//  Created by ZhengYidong on 29/11/2017.
//

import UIKit

class ReloadView: UIView, Maskable {

    public var maskId: String = "ReloadView"
    
    @IBOutlet var contentView: UIView!
    
    public init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        
        Bundle(for: ReloadView.classForCoder()).loadNibNamed("ReloadView", owner: self, options: nil)
        self.addSubView(contentView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
