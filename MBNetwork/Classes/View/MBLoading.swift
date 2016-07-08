//
//  MBLoading.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


struct MBLoading {
    static func loading() -> UIView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicatorView.startAnimating()
        activityIndicatorView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        return activityIndicatorView
    }
}
