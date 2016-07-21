//
//  MBLoader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

// MARK: - MBLoader

/**
 加载配置对象
 - 实现 url 指定请求地址
 - 实现 parameters 设置请求参数
 - 实现 method 设置请求方式
 - 实现 id 设置请求编号，如：GET_USER_INFO (注：开发者需要保证请求ID的唯一性)
 */

public class MBLoadConfig {
    
    var mask:UIView?
    var container:UIView?
    var insets:UIEdgeInsets
    
    var id:String
    
    init(id:String, mask:UIView?, container:UIView?, insets:UIEdgeInsets) {
        self.mask = mask
        self.container = container
        self.insets = insets
        self.id = id
    }
}

/**
 实现默认加载
 */
extension MBLoadable {
    func loadConfig() -> MBLoadConfig {
        return MBLoadConfig(id:"MBLOADCONFIGDEFAULT", mask:MBLoading.loading(), container:nil, insets:UIEdgeInsetsZero)
    }
}

/**
 黑魔法－使用 runtime 为 extension 增加成员变量
 */

private struct MBLoadableKeys {
    static var loadingKey = "loadingKey"
}

extension MBLoadable {
    private var mbLoadConfig:MBLoadConfig? {
        get {
            return objc_getAssociatedObject(self, &MBLoadableKeys.loadingKey) as? MBLoadConfig
        }
        set(loading) {
            objc_setAssociatedObject(
                self,
                &MBLoadableKeys.loadingKey,
                loading as MBLoadConfig?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

extension MBLoadable {
    public func showLoad() {
        if let mbLoadConfig = self.mbLoadConfig {
            if loadConfig.id == mbLoadConfig.id {
                return
            }
        }
        mbLoadConfig = loadConfig
    }
    
    public func hideLoad() {
        mbLoadConfig?.mask?.removeFromSuperview()
    }
}

// MARK: - MBLoadable

/**
 满足 MBLoadable 协议的类型可以在进行网络请求时显示加载框
  - 实现 loading() 可以自定义加载
 */
public protocol MBLoadable : class {
    var loadConfig : MBLoadConfig { get }
}


