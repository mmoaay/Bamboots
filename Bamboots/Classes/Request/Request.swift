//
//  Requester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import Alamofire
import AlamofireCodable

public extension Requestable {

    
    /// Creates a `DataRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `RequestFormable` protocol.
    /// - Returns: The created `DataRequest`.
    @discardableResult
    func request(_ form: RequestFormable) -> DataRequest {
        return Alamofire.request(
            form.url,
            method: form.method,
            parameters: form.parameters(),
            encoding: form.encoding(),
            headers: form.headers()
        )
    }
    
    /// Creates a `DownloadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `DownloadFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func download(_ form: DownloadFormable) -> DownloadRequest {
        return Alamofire.download(
            form.url,
            method: form.method,
            parameters: form.parameters(),
            encoding: form.encoding(),
            headers: form.headers(),
            to: form.destination
        )
    }
    
    /// Creates a `DownloadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `DownloadResumeFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func download(_ form: DownloadResumeFormable) -> DownloadRequest {
        return Alamofire.download(resumingWith: form.resumeData, to: form.destination)
    }

    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `UploadDataFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: UploadDataFormable) -> UploadRequest {
        return Alamofire.upload(form.data, to: form.url, method: form.method, headers: form.headers())
    }

    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `UploadFileFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: UploadFileFormable) -> UploadRequest {
        return Alamofire.upload(form.fileURL, to: form.url, method: form.method, headers: form.headers())
    }

    /// Encodes `form` and calls `completion` with new `UploadRequest` using the `form`
    ///
    /// - Parameters:
    ///   - form: Object conforms to `UploadMultiFormDataFormable` protocol.
    ///   - completion: The closure called when the upload is complete
    
    func upload(_ form: UploadMultiFormDataFormable, completion: ((UploadRequest) -> Void)?) {
        Alamofire.upload(
            multipartFormData: form.multipartFormData,
            usingThreshold: form.encodingMemoryThreshold,
            to: form.url,
            method: form.method,
            headers: form.headers(),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    completion?(upload)
                    break
                case .failure(let encodingError):
                    print(encodingError)
                    break
                }
        }
        )
    }

    /// Creates an `UploadRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `UploadStreamFormable` protocol.
    /// - Returns: The created `DownloadRequest`.
    @discardableResult
    func upload(_ form: UploadStreamFormable) -> UploadRequest {
        return Alamofire.upload(form.stream, to: form.url, method: form.method, headers: form.headers())
    }
}

///  Network request protocol, object conforms to this protocol can make network request
public protocol Requestable: class {

}
