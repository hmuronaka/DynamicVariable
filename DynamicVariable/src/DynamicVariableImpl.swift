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
        let tryRegEx = try? NSRegularExpression(pattern: "^\\s*(?:w:|width:)?\\s*([-]?\\d+)\\s*,\\s*(?:h:|height:)?\\s*([-]?\\d+)\\s*$", options: .caseInsensitive)
        guard let regex = tryRegEx else {
            return nil
        }
        
        print("dv_nsrange: \(string.dv_nsrange().location), \(string.dv_nsrange().length)")
        let match:NSTextCheckingResult! = regex.firstMatch(in: string, options: [], range: string.dv_nsrange())
        
        guard match != nil && match.numberOfRanges == 3 else {
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
