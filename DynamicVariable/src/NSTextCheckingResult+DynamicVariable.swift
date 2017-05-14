//
//  NSTextCheckingResult+DynamicVariable.swift
//  DynamicVariable
//
//  Created by MuronakaHiroaki on 2017/05/13.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

internal extension NSTextCheckingResult {
    
    func dv_capturingGroup(at index:Int, source: String) -> String? {
        guard index < self.numberOfRanges else {
            return nil
        }
        
        let range = self.rangeAt(index)
        return source.dv_substring(with: range)
    }
    
}
