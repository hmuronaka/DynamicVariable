//
//  String+DynamicVariable.swift
//  DynamicVariable
//
//  Created by MuronakaHiroaki on 2017/05/13.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import Foundation

internal extension String {
    
    func dv_nsrange() -> NSRange {
        return NSMakeRange(0, self.characters.count)
    }
    
    func dv_range(from nsrange: NSRange) -> Range<String.Index> {
        let startIdx = self.index(self.startIndex, offsetBy: nsrange.location)
        let endIdx = self.index(startIdx, offsetBy: nsrange.length)
        return startIdx..<endIdx
    }
    
    func dv_substring(with nsrange: NSRange) -> String {
        return self.substring(with: self.dv_range(from: nsrange))
    }
    
    func dv_toDouble() -> Double? {
        return Double(self)
    }
    
    func dv_toCGFloat() -> CGFloat? {
        guard let value = dv_toDouble() else {
            return nil
        }
        return CGFloat(value)
    }
}
