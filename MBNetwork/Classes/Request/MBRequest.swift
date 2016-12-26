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
    ///   - load:
    ///   - serialize: 
    public func request(_ form:MBFormable, load:MBLoadable = MBLoadType.none, serialize:MBSerializable? = nil) -> DataRequest  {
        
        load.begin()
        
        Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers()).responseJSON(completionHandler: { (response:DataResponse<Any>) in
            
            load.end()
        })
    }
    
    public func download(_ form:MBDownloadForm, load:MBLoadable = MBLoadType.none, progress:MBLoadProgressable? = nil) -> DataRequest {
        
        load.begin()
        
        Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination).response { (response:DefaultDownloadResponse) in
            load.end()
            }.downloadProgress { (prog:Progress) in
                progress?.progress(prog)
            }.responseData { (data:DownloadResponse<Data>) in
            
        }
    }

}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable : class{
    
}




