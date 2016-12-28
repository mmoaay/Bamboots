//
//  MBForm.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation
import Alamofire


// MARK: - MBFormable
public extension MBFormable {
    
    /// Default encoding
    ///
    /// - Returns: Default URLEncoding
    func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
}

public protocol MBDownloadForm:MBFormable {
    var destination: DownloadRequest.DownloadFileDestination { get }
}


/// MBFormable
public protocol MBFormable {
    /// request url
    var url: String { get }
    
    /// request method
    var method: Alamofire.HTTPMethod { get }
    
    
    /// request headers
    ///
    /// - Returns: headers
    func headers() -> [String: String]
    
    /// encoding
    ///
    /// - Returns: encoding
    func encoding() -> ParameterEncoding
    
    /// request parameters
    ///
    /// - Returns: parameters
    func parameters() -> [String: Any]
}
