//
//  MBLoading.swift
//  Pods
//
//  Created by Perry on 16/7/8.
//
//


public struct MBLoading {
    public static func loading() -> UIView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityIndicatorView.startAnimating()
        activityIndicatorView.backgroundColor = UIColor.whiteColor()
        
        return activityIndicatorView
    }
}
