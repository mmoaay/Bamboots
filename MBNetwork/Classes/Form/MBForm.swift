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

public protocol MBRequestFormable: MBFormable {
    /// encoding
    ///
    /// - Returns: encoding
    func encoding() -> ParameterEncoding
    
    /// request parameters
    ///
    /// - Returns: parameters
    func parameters() -> [String: Any]
}

public protocol MBDownloadFormable: MBRequestFormable {
    var destination: DownloadRequest.DownloadFileDestination { get }
}

public protocol MBDownloadResumeFormable: MBDownloadFormable {
    var resumeData: Data { get }
}

public protocol MBUploadFileFormable: MBFormable {
    var fileURL: URL { get }
}

public protocol MBUploadDataFormable: MBFormable {
    var data: Data { get }
}

public protocol MBUploadStreamFormable: MBFormable {
    var stream: InputStream { get }
}

public protocol MBUploadMultiFormDataFormable: MBFormable {
    var encodingCompletion: ((SessionManager.MultipartFormDataEncodingResult) -> Void)? { get }
    
    var encodingMemoryThreshold: UInt64 { get }
    
    var multipartFormData: (MultipartFormData) -> Void { get }
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
}
