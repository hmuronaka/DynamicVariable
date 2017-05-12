//
//  DynamicVariable.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

public class AnyDynamicVariable {
    
    var name: String
    var defaultValue: Any
    var converter: ((String) -> (Any))
    var callback: ((Any) -> ())?
    
    var currentValue: Any {
        set(newValue) {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            ud?.set(newValue, forKey: name)
        }
        get {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            return ud?.object(forKey: name) ?? defaultValue
        }
    }
     
    public init(name: String, defaultValue: Any, converter: @escaping (String) ->(Any), callback: ((Any) ->())?) {
        self.name = name
        self.defaultValue = defaultValue
        self.converter = converter
        self.callback = callback
    }
    
    public convenience init<T: DynamicVariableBinding>(bridge: DynamicVariable<T>) {
        self.init(name: bridge.name, defaultValue: bridge.defaultValue, converter: { (str) -> (Any) in
            return T(string: str)!
        }) { value -> () in
            bridge.callback?(value as! T)
        }
    }
    
    public func value(from string: String) {
        self.currentValue = string
        self.callback?(string)
        
    }
    
}

public class DynamicVariable<T: DynamicVariableBinding> {
    
    var name: String
    var defaultValue: T
    
    typealias ValueType = T
    
    var currentValue: T {
        set(newValue) {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            ud?.set(newValue, forKey: name)
        }
        get {
            let ud = UserDefaults(suiteName: "DynamicVariable")
            return ud?.object(forKey: name) as? T ?? defaultValue
        }
    }
    
    var callback: ((T) -> ())?
    
    public init(name: String, defaultValue: T, callback: ((T) -> ())?) {
        self.name = name
        self.defaultValue = defaultValue
        self.callback = callback
    }
    
    public convenience init(bridge: AnyDynamicVariable) {
        self.init(name: bridge.name, defaultValue: bridge.defaultValue as! T, callback: { (val:T) -> () in
            bridge.callback?(val)
        })
    }
}
    
