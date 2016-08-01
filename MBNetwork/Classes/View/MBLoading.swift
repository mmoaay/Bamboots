//
//  MBLoading.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


public struct MBLoading {
    public static func loading() -> UIView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicatorView.startAnimating()
        activityIndicatorView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        return activityIndicatorView
    }
}
