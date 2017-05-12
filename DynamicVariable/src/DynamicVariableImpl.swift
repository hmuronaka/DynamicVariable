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
