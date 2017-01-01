//
//  MBActivityIndicator.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation

open class MBActivityIndicator: UIActivityIndicatorView, MBMaskable {
    open var maskId:String = "MBActivityIndicator"
    
    public override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle = .gray) {
        super.init(activityIndicatorStyle: style)
        
        backgroundColor = UIColor.white
        startAnimating()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        stopAnimating()
    }
}
