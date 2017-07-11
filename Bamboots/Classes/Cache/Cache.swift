//
//  Cache.swift
//  Pods
//
//  Created by ZhengYidong on 14/04/2017.
//
//

import Foundation

import RealmSwift

public protocol Cacheable {
    associatedtype ObjectType
    
    func create(_ object: ObjectType)
    
    func read(_ query:(ObjectType) -> Bool, type: ObjectType.Type) -> [ObjectType]
    
    func update(_ object: ObjectType)
    
    func delete(_ object: ObjectType)
}

public protocol CacheMappable {
    
    associatedtype ObjectType
    
    func encode() -> ObjectType
    
    func decode(object:ObjectType)
}

public struct RealmCache<T:Object> : Cacheable {
    
    public typealias ObjectType = T
    
    let realm = try! Realm()
    
    public func delete(_ object: T) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    public func update(_ object: T) {
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    public func read(_ query:(T) -> Bool, type: T.Type)  -> [T] {
        return realm.objects(type).filter({ (T) -> Bool in
            return query(T)
        })
    }
    
    public func create(_ object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
    
}


