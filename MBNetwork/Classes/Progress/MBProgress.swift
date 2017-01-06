//
//  MBProgress.swift
//  Pods
//
//  Created by ZhengYidong on 04/01/2017.
//
//

import Foundation

/// Progress protocol for request, Objects conforms to this protocol can get the progress of the request. Object conforms to this protocol can be used by progress method of DataRequest
public protocol MBProgressable {
    func progress(_ progress:Progress)
}
