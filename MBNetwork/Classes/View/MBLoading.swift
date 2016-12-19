//
//  MBLoading.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


open class MBLoading:UIActivityIndicatorView, MBMaskable {
    open var maskId:String = "MBMaskDefault"
    
    override public init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
        
        backgroundColor = UIColor.white
        startAnimating()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
