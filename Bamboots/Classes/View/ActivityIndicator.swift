//
//  ActivityIndicator.swift
//  Pods
//
//  Created by ZhengYidong on 01/01/2017.
//
//

import Foundation

public class ActivityIndicator: UIActivityIndicatorView, Maskable {

    public var maskId: String = "ActivityIndicator"

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
