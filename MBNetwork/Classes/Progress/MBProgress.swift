//
//  MBProgress.swift
//  Pods
//
//  Created by ZhengYidong on 04/01/2017.
//
//

import Foundation

/// Progress protocol for request, object conforms to this protocol can be used by `progress` method of `DataRequest` and `DownloadRequest`
public protocol MBProgressable {
    func progress(_ progress: Progress)
}
