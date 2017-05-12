//
//  ViewController.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import DynamicVariable

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var labelString: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let val = 3.dv_bind(name: "val") { [weak self] (newValue) in
            self?.label.text = "\(newValue)"
        }
        label.text = "\(val)"
        label.textColor = .black
        
        labelString.text = "Text".dv_bind(name: "text", block: { (newValue) in
            self.labelString.text = newValue
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

