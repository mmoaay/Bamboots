//
//  MBLoading.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


public struct MBLoading: MBMaskable {
    public var maskId:String = "MBMaskDefault"
    
    public func maskView() -> UIView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.startAnimating()
        activityIndicatorView.backgroundColor = UIColor.white
        
        return activityIndicatorView
    }
}
