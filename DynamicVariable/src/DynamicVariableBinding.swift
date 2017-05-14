//
//  DynamicVariableBinding.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//
import UIKit

public protocol DynamicVariableBinding  {
    init?(string: String)
    func dv_bind(name: String, block: ((Self) -> ())?) -> Self
    func dv_forUserDefaults() -> Any
    static func dv_fromUserDefaults(any: Any) -> Self?
}

public extension DynamicVariableBinding {
    
    public func dv_bind(name: String, block: ((Self) -> ())?) -> Self {
        var dynamicVariable:DynamicVariable<Self>! = DynamicVariableManager.shared.get(name: name)
        
        if dynamicVariable == nil {
            dynamicVariable = DynamicVariable<Self>(name: name, defaultValue: self, callback: block)
            DynamicVariableManager.shared.add(variable: dynamicVariable)
        }
        // 現在値を返す
        return dynamicVariable.currentValue
    }
    
    public func dv_forUserDefaults() -> Any {
        return self
    }
    
    static public func dv_fromUserDefaults(any: Any) -> Self? {
        return  any as? Self
    }
    
}
