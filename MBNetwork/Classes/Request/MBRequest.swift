//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public extension MBRequestable  {

    /// request
    ///
    /// - Parameters:
    ///   - form:
    @discardableResult
    public func request(_ form: MBRequestFormable) -> DataRequest  {
        return Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers())
    }
    
    @discardableResult
    public func download(_ form: MBDownloadFormable) -> DownloadRequest {
        return Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination)
    }
    
    @discardableResult
    public func download(_ form: MBDownloadResumeFormable) -> DownloadRequest {
        return Alamofire.download(resumingWith: form.resumeData, to: form.destination)
    }
    
    @discardableResult
    public func upload(_ form: MBUploadDataFormable) -> UploadRequest {
        return Alamofire.upload(form.data, to: form.url, method: form.method, headers: form.headers())
    }
    
    @discardableResult
    public func upload(_ form: MBUploadFileFormable) -> UploadRequest {
        return Alamofire.upload(form.fileURL, to: form.url, method: form.method, headers: form.headers())
    }
    
    @discardableResult
    public func upload<E: MBServerErrorable, T: BaseMappable>(_ form: MBUploadMultiFormDataFormable, load: MBLoadable = MBLoadType.none, progress:MBLoadProgressable? = nil, error: E? = nil, alert:MBAlertable = MBAlertType.none, errorHandler: ((MBServerErrorable) -> Void)? = nil, queue: DispatchQueue? = nil, serialize: MBSerializable? = nil, mapToObject object: T? = nil, context: MapContext? = nil, dataHandler: @escaping (DataResponse<T>) -> Void) {
        Alamofire.upload(multipartFormData: form.multipartFormData, usingThreshold: form.encodingMemoryThreshold, to: form.url, method: form.method, headers: form.headers(), encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(var upload, _, _):
                upload = upload.load(load: load).progress(progress:progress).alert(error: error, alert: alert, completionHandler: errorHandler).response(completionHandler: { (response: DefaultDataResponse) in
                    if let error = response.error {
                        alert.show(error: error.localizedDescription)
                    }
                }).response(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(serialize?.dataNode, mapToObject: object, context: context), completionHandler: dataHandler)
                break
            case .failure(let encodingError):
                alert.show(error: encodingError.localizedDescription)
                break
            }
        })
    }
    
    @discardableResult
    public func upload(_ form: MBUploadStreamFormable) -> UploadRequest {
        return Alamofire.upload(form.stream, to: form.url, method: form.method, headers: form.headers())
    }
}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable: class{
    
}




