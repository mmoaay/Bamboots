//
//  MBLoader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

public enum MBLoadType: String {
    case DEFAULT, FULL, NONE
}

private struct MBLoadableKeys {
    static var loadCountKey = "loadCountKey"
}

extension MBLoadable {
    private var loadCount:Int?{
        get {
            let count = objc_getAssociatedObject(self, &MBLoadableKeys.loadCountKey) as? Int
            if nil == count {
                objc_setAssociatedObject(
                    self,
                    &MBLoadableKeys.loadCountKey,
                    0 as Int?,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                return 0
            }
            return count
        }
        set(count) {
            objc_setAssociatedObject(
                self,
                &MBLoadableKeys.loadCountKey,
                count as Int?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    public func showLoad(type:MBLoadType) {
        if let vc = self as? UIViewController {
            if .NONE != type {
                if 0 == loadCount {
                    if type == .FULL {
                        if let nav = vc.navigationController {
                            nav.view.addFullSubView(loading)
                        } else if let tab = vc.tabBarController {
                            tab.view.addFullSubView(loading)
                        } else {
                            vc.view.addFullSubView(loading)
                        }
                    } else {
                        vc.view.addFullSubView(loading)
                    }
                }
                loadCount! += 1
            }
            
        }
    }
    
    public func hideLoad(type:MBLoadType) {
        if let _ = self as? UIViewController {
            if .NONE != type {
                loadCount! -= 1
                if 0 == loadCount {
                    loading.removeFromSuperview()
                }
            }
        }
    }
}

public protocol MBLoadable : class {
    var loading:UIView { get }
}

