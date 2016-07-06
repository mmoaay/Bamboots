//
//  MBRequester.swift
//  Pods
//
//  Created by Perry on 16/7/6.
//
//

import UIKit
import SwiftyJSON
import Alamofire

extension UIView {
    func fillSuperView() {
        let views:[String:UIView] = ["content":self]
        let layoutStringH:String = "|-0-[content]-0-|"
        let layoutStringV:String = "V:|-0-[content]-0-|"
        let contraintsH:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringH, options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: views)
        let contraintsV:[NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat(layoutStringV, options:NSLayoutFormatOptions(rawValue:0), metrics:nil, views: views)
        
        if let superview = self.superview {
            superview.addConstraints(contraintsH)
            superview.addConstraints(contraintsV)
        }
    }
}

public enum MBLoadingType: String {
    case DEFAULT, FULL
}

extension MBLoadable {
    
}

public protocol MBLoadable {
    var loadingView:UIView { get }
    var loadingType:MBLoadingType { get }
}

public protocol MBReloadable {
    func reload()
}


private struct AssociatedKeys {
    static var requestKey = "requestKey"
}

public extension MBRequestable  {
    private var request:MBRequester?{
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.requestKey) as? MBRequester
        }
        set(request) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.requestKey,
                request as MBRequester?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    func requester() -> MBRequester {
        if nil == request {
            request = MBRequester()
        }
        return request!
    }
}

public protocol MBRequestable : class{
    
}

public class MBRequester {
    
    private var loadingCount = 0
    
    public func send(target:AnyObject)  {
        
        showLoading(target)
        
        Alamofire.request(.GET, "https://www.baidu.com").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    self.hideLoading(target)
                }
            case .Failure(let error):
                print(error)
                
                self.hideLoading(target)
            }
        }
    }
    
    
    private func showLoading(target:AnyObject) {
        if let loading = target as? MBLoadable, vc = target as? UIViewController {
            if 0 == loadingCount {
                if loading.loadingType == .FULL {
                    if let nav = vc.navigationController {
                        nav.view.addSubview(loading.loadingView)
                    } else if let tab = vc.tabBarController {
                        tab.view.addSubview(loading.loadingView)
                    } else {
                        vc.view.addSubview(loading.loadingView)
                    }
                } else {
                    vc.view.addSubview(loading.loadingView)
                }
                loading.loadingView.fillSuperView()
            }
            loadingCount += 1
        }
    }
    
    private func hideLoading(target:AnyObject) {
        if let loading = target as? MBLoadable {
            loadingCount -= 1
            if 0 == loadingCount {
                loading.loadingView.removeFromSuperview()
            }
        }
    }
}




