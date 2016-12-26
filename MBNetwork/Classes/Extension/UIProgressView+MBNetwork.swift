//
//  UIProgressView+MBNetwork.swift
//  Pods
//
//  Created by ZhengYidong on 26/12/2016.
//
//

import Foundation
import Alamofire

extension UIProgressView:MBLoadProgressable {
    public func progress(_ progress:Progress) {
        self.setProgress(Float(progress.completedUnitCount).divided(by: Float(progress.totalUnitCount)), animated: true)
    }
}
