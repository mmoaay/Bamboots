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
    public func request(_ form: MBFormable, load: MBLoadable = MBLoadType.none) -> DataRequest  {
        
        load.begin()
        
        return Alamofire.request(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers()).response(completionHandler: { (response:DefaultDataResponse) in
            load.end()
        })
    }
    
    public func download(_ form: MBDownloadForm, load: MBLoadable = MBLoadType.none, progress: MBLoadProgressable? = nil) -> DownloadRequest {
        
        load.begin()
        
        return Alamofire.download(form.url, method: form.method, parameters: form.parameters(), encoding: form.encoding(), headers: form.headers(), to: form.destination).response { (response:DefaultDownloadResponse) in
            load.end()
            }.downloadProgress { (prog:Progress) in
                progress?.progress(prog)
        }
    }
    
//    public func upload(_ form: MBDownloadForm, load: MBLoadable = MBLoadType.none, progress: MBLoadProgressable? = nil) -> UploadRequest {
//    }

}

// MARK: - MBRequestable

/**
 满足 MBRequestable 协议的类型可以进行网络请求
 */
public protocol MBRequestable: class{
    
}




