//
//  AlamofireProtobuf.swift
//  Pods
//
//  Created by sun on 2018/2/27.
//

import Alamofire
import SwiftProtobuf

extension DataRequest {

    enum AlamofireProtobufErrorCode: Int {
        case noData = 1
        case dataSerializationFailed = 2
    }

    internal static func newError(_ code: AlamofireProtobufErrorCode, failureReason: String) -> NSError {
        let errorDomain = "com.alamofireProtobuf.error"
        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        let returnError = NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)
        return returnError
    }

    /// Utility function for checking for errors in response
    internal static func checkResponseForError(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard let _ = data else {
            let failureReason = "Data could not be serialized. Input data was nil."
            let error = newError(.noData, failureReason: failureReason)
            return error
        }
        return nil
    }

    public static func ObjectSerializerPB<T: SwiftProtobuf.Message>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            if let error = checkResponseForError(request: request, response: response, data: data, error: error) {
                return .failure(error)
            }
            do {
                let object = try T(serializedData: data!)
                return .success(object)
            } catch let error {
                return .failure(error)
            }
        }
    }

    @discardableResult
    public func responsePBObject<T: SwiftProtobuf.Message>(queue: DispatchQueue? = nil, keyPath: String? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.ObjectSerializerPB(), completionHandler: completionHandler)
    }
}
