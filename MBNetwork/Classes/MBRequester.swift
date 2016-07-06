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


public extension MBRequestable  {
    func requester() -> MBRequester {
        return MBRequester()
    }
}

public protocol MBRequestable : class{
    
}

public class MBRequester {
    
    public func send(target:AnyObject)  {
        
        showLoading(target)
        
        Alamofire.request(.GET, "http://www.baidu.com").validate().responseJSON { response in
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
            if loading.loadingType == .FULL {
                if let nav = vc.navigationController {
                    nav.view.addSubview(loading.loadingView)
                } else if let tab = vc.tabBarController {
                    tab.view.addSubview(loading.loadingView)
                }
            } else {
                vc.view.addSubview(loading.loadingView)
            }
            loading.loadingView.fillSuperView()
        }
    }
    
    private func hideLoading(target:AnyObject) {
        if let loading = target as? MBLoadable {
            loading.loadingView.removeFromSuperview()
        }
    }
}




