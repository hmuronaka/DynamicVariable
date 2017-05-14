//
//  Int+DynamicVariable.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

extension Int: DynamicVariableBinding {
    public init?(string: String) {
        self.init(string)
    }
}

extension Float: DynamicVariableBinding {
    public init?(string: String) {
        self.init(string)
    }
}

extension CGFloat: DynamicVariableBinding {
    public init?(string: String) {
        self.init(Double(string)!)
    }
}

extension String: DynamicVariableBinding {
    public init?(string: String) {
        self.init(string)
    }
}

//"123, 345"
//"width: 123, height: 345"
//"w: 123, h:345"
extension CGSize: DynamicVariableBinding {
    public init?(string: String) {
//        let pattern = "^\\s*(?:w:|width:)?\\s*([-]?\\d+)\\s*,\\s*(?:h:|height:)?\\s*([-]?\\d+)\\s*$"
        let patterns = [("w|width", "[-]?\\d+"), ("h|height", "[-]?\\d+")]
        guard let match = string.dv_match(patterns:patterns), match.numberOfRanges == 3 else {
            return nil
        }
        
        guard let width = match.dv_capturingGroup(at: 1, source: string)?.dv_toCGFloat(),
            let height = match.dv_capturingGroup(at: 2, source: string)?.dv_toCGFloat() else {
            return nil
        }
        self.init(width: width, height: height)
    }
    
    public func dv_forUserDefaults() -> Any {
        return NSStringFromCGSize(self)
    }
    
    static public func dv_fromUserDefaults(any: Any) -> CGSize? {
        return CGSizeFromString(any as! String)
    }
}

//"123, 345"
//"x: 123, y: 345"
extension CGPoint: DynamicVariableBinding {
    public init?(string: String) {
//        let pattern = "^\\s*(?:x:)?\\s*([-]?\\d+)\\s*,\\s*(?:h:)?\\s*([-]?\\d+)\\s*$"
        let patterns = [("x", "[-]?\\d+"), ("y", "[-]?\\d+")]
        guard let match = string.dv_match(patterns: patterns), match.numberOfRanges == 3 else {
            return nil
        }
        
        guard let x = match.dv_capturingGroup(at: 1, source: string)?.dv_toCGFloat(),
            let y = match.dv_capturingGroup(at: 2, source: string)?.dv_toCGFloat() else {
            return nil
        }
        self.init(x: x, y: y)
    }
    
    public func dv_forUserDefaults() -> Any {
        return NSStringFromCGPoint(self)
    }
    
    static public func dv_fromUserDefaults(any: Any) -> CGPoint? {
        return CGPointFromString(any as! String)
    }
}
