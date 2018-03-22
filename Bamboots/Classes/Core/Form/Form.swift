//
//  Form.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation
import Alamofire

public extension RequestFormable {
    func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }

    func parameters() -> [String: Any] {
        return [ : ]
    }

    var method: Alamofire.HTTPMethod {
        return .get
    }
}

/// Conforming to this protocol to create a request form
public protocol RequestFormable: Formable {
    /// Encoding, you can customize the encoding method by returning an encoding object that conforms to `ParameterEncoding` protocol
    ///
    /// - Returns:  object that conforms to `ParameterEncoding` protocol
    func encoding() -> ParameterEncoding

    /// Request parameters
    ///
    /// - Returns: parameters
    func parameters() -> [String: Any]
}

/// Download Form protocol, Base protocol for download request form
public protocol DownloadFormable: RequestFormable {
    var destination: DownloadRequest.DownloadFileDestination { get }
}

/// Conforming to this protocol to create a download form that can resume a download task
public protocol DownloadResumeFormable: DownloadFormable {
    var resumeData: Data { get }
}

public extension UploadMultiFormDataFormable {
    var encodingMemoryThreshold: UInt64 {
        return SessionManager.multipartFormDataEncodingMemoryThreshold
    }
}

/// Conforming to this protocol to create an upload form that contains multiformdata
public protocol UploadMultiFormDataFormable: UploadFormable {
    var encodingMemoryThreshold: UInt64 { get }

    var multipartFormData: (MultipartFormData) -> Void { get }
}

/// Conforming to this protocol to create an upload form that contains a file
public protocol UploadFileFormable: UploadFormable {
    var fileURL: URL { get }
}

/// Conforming to this protocol to create an upload form that contains a data object
public protocol UploadDataFormable: UploadFormable {
    var data: Data { get }
}

/// Conforming to this protocol to create an upload form that contains a stream object
public protocol UploadStreamFormable: UploadFormable {
    var stream: InputStream { get }
}

public extension UploadFormable {
    var method: Alamofire.HTTPMethod {
        return .post
    }
}

/// Upload Form protocol, Base protocol for upload request form
public protocol UploadFormable: Formable {

}

/// Form protocol. Object conforms to this protocol can be used by the `request`, `download`, `upload` method in `Requestable` protocol
public protocol Formable {
    /// Request url
    var url: String { get }

    /// Request method
    var method: Alamofire.HTTPMethod { get }

    /// Request headers
    ///
    /// - Returns: headers
    func headers() -> [String: String]
}
