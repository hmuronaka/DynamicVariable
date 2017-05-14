//
//  DynamicVariable.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

public class AnyDynamicVariable {
    
    var callback:((String) -> ())?
    var any: Any
    
    public init(any: Any, callback:@escaping (String) -> ()) {
        self.any = any
        self.callback = callback
    }
    
    public convenience init<T: DynamicVariableBinding>(bridge: DynamicVariable<T>) {
        self.init(any: bridge) { str -> () in
            bridge.fireCallback(string: str)
        }
    }
    
    public func fireCallback(string: String) {
        self.callback?(string)
    }
    
    public func get<T>() -> DynamicVariable<T>? {
        return any as? DynamicVariable<T>
    }
    
}

public class DynamicVariable<T: DynamicVariableBinding> {
    
    var name: String
    var defaultValue: T
    
    typealias ValueType = T
    
    var currentValue: T {
        set(newValue) {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            ud?.set(newValue.dv_forUserDefaults(), forKey: name)
        }
        get {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            guard let any = ud?.object(forKey: name), let value = T.dv_fromUserDefaults(any: any) else {
                return defaultValue
            }
            return value
        }
    }
    
    var callback: ((T) -> ())?
    
    public init(name: String, defaultValue: T, callback: ((T) -> ())?) {
        self.name = name
        self.defaultValue = defaultValue
        self.callback = callback
    }
    
    public func fireCallback(string: String) {
        guard let newValue = T(string: string) else {
            return 
        }
        self.currentValue = newValue
        self.callback?(self.currentValue)
    }
}
    
