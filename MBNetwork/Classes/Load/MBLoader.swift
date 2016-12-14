//
//  MBLoader.swift
//  Pods
//
//  Created by Perry on 16/7/7.
//
//

import Foundation

// MARK: - MBLoader

extension MBLoadType: MBLoadable {
    public var mask:MBMaskable? {
        switch self {
        case .default(let container):
            return MBLoading()
        case .none:
            return nil
        }
    }
    
    public var container:MBContainable? {
        switch self {
        case .default(let container):
            return container
        case .none:
            return nil
        }
    }
    
    /// 请求开始
    public func begin() {
        switch self {
        case .default(let container):
            break
        case .none:
            break
        }
    }
    
    /// 请求结束
    public func end() {
        switch self {
        case .default(let container):
            break
        case .none:
            break
        }
    }
}

public enum MBLoadType {
    case none
    case `default`(container:MBContainable)
}

// MARK: - MBLoadable

///  满足 MBLoadable 协议的类型可以在进行网络请求时显示加载框 - 实现 loading() 可以自定义加载
public protocol MBLoadable {    
    var mask:MBMaskable? { get }
    
    var container:MBContainable? { get }
    
    /// 请求开始
    func begin()
    
    /// 请求结束
    func end()
}

///
public protocol MBLoadProgressable {
    func progress(progress:Progress)
}

/// 黑魔法－使用 runtime 为 extension 增加成员变量
private struct MBLoadableKeys {
    static var loadingKey = "loadingKey"
}

extension MBRequestable {
    fileprivate var mbLoadConfig:MBLoadConfig? {
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

extension MBRequestable {
    public func showLoad(_ load:MBLoadable) {
        if let config = load.loadConfig { // 如果有配置则说明需要加载框
            if let mbConfig = mbLoadConfig { // 判断之前是否已经有加载框的配置
                if mbConfig.id == config.id { // 判断 id 是否一致，如果一致，则表示和之前的加载框是同一个
                    mbConfig.count += 1
                } else { // 否则用新的加载框替换旧的加载框
                    removeLoad(mbConfig)
                    addLoad(config)
                }
            } else { // 否则设置初始加载框
                addLoad(config)
            }
        }
    }
    
    public func hideLoad(_ load:MBLoadable) {
        if let config = load.loadConfig { // 如果有配置则说明需要加载框
            if let mbConfig = mbLoadConfig { // 判断之前是否已经有加载框的配置
                if mbConfig.id == config.id { // 判断 id 是否一致，如果一致，则表示和之前的加载框是同一个
                    mbLoadConfig?.count -= 1
                    if (0 == mbLoadConfig?.count) {
                        removeLoad(mbConfig)
                        mbLoadConfig = nil
                    }
                }
            }
        }
    }
    
    fileprivate func addLoad(_ loadConfig:MBLoadConfig) {
        mbLoadConfig = loadConfig
        if let mbConfig = mbLoadConfig {
            if let scrollView = mbConfig.container as? UIScrollView { // 对 UIScrollView 和 UITableView 做特殊处理
                if let superView = scrollView.superview {
                    superView.addMBSubView(mbConfig.mask, insets: mbConfig.insets)
                    scrollView.setContentOffset(scrollView.contentOffset, animated: false)
                    scrollView.isScrollEnabled = false
                }
            } else {
                mbConfig.container.addMBSubView(mbConfig.mask, insets: mbConfig.insets)
            }
        }
    }
    
    fileprivate func removeLoad(_ loadConfig:MBLoadConfig) {
        if let scrollView = loadConfig.container as? UIScrollView {
            scrollView.isScrollEnabled = true
        }
        loadConfig.mask.removeFromSuperview()
    }
}


