//
//  MBLoader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

/**
 实现默认加载
 */
extension MBLoadable {
    public var loading:UIView {
        return mbDefaultLoading!
    }
}

/**
 黑魔法－使用 runtime 为 extension 增加成员变量
 */

private struct MBLoadableKeys {
    static var loadCountKey = "loadCountKey"
    static var loadingKey = "loadingKey"
}

extension MBLoadable {
    private var mbDefaultLoading:UIView? {
        get {
            let view = objc_getAssociatedObject(self, &MBLoadableKeys.loadingKey) as? UIView
            if nil == view {

                let loading = MBLoading.loading()
                
                objc_setAssociatedObject(
                    self,
                    &MBLoadableKeys.loadingKey,
                    loading as UIView?,
                    objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                return loading
            }
            return view
        }
        set(view) {
            objc_setAssociatedObject(
                self,
                &MBLoadableKeys.loadingKey,
                view as UIView?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    private var mbLoadCount:Int? {
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
}

extension MBLoadable {
    public func showLoad(type:MBLoadType) {
        if let vc = self as? UIViewController {
            if .NONE != type {
                if 0 == mbLoadCount {
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
                mbLoadCount! += 1
            }
            
        }
    }
    
    public func hideLoad(type:MBLoadType) {
        if let _ = self as? UIViewController {
            if .NONE != type {
                mbLoadCount! -= 1
                if 0 == mbLoadCount {
                    loading.removeFromSuperview()
                }
            }
        }
    }
}

// MARK: - MBLoadable

/**
 满足 MBLoadable 协议的类型可以在进行网络请求时显示加载框
  - 实现 loading 可以自定义加载
 */
public protocol MBLoadable : class {
    var loading:UIView { get }
}


// MARK: - MBLoadType

/**
 加载的类型
 */
public enum MBLoadType: String {
    case DEFAULT, FULL, NONE
}


// MARK: - MBLoadSizable

/**
 满足 MBLoadSizable 协议的类型可以自定义加载的边距
 */
public protocol MBLoadSizable {
    var loadingEdgeInsets:UIEdgeInsets {get}
}


