//
//  MBForm.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation
import Alamofire

extension MBRequestFormable {
    /// Default encoding
    ///
    /// - Returns: Default URLEncoding
    public func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    public func parameters() -> [String: Any] {
        return [ : ]
    }
    
    /// request method
    public var method: Alamofire.HTTPMethod {
        return .get
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

extension MBUploadMultiFormDataFormable {
    public var encodingMemoryThreshold: UInt64 {
        return SessionManager.multipartFormDataEncodingMemoryThreshold
    }
}

public protocol MBUploadMultiFormDataFormable: MBUploadFormable {
    var encodingMemoryThreshold: UInt64 { get }
    
    var multipartFormData: (MultipartFormData) -> Void { get }
}

public protocol MBUploadFileFormable: MBUploadFormable {
    var fileURL: URL { get }
}

public protocol MBUploadDataFormable: MBUploadFormable {
    var data: Data { get }
}

public protocol MBUploadStreamFormable: MBUploadFormable {
    var stream: InputStream { get }
}

extension MBUploadFormable {
    public var method: Alamofire.HTTPMethod {
        return .post
    }
}

public protocol MBUploadFormable: MBFormable {
    
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
