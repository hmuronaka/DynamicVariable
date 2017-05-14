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
    @IBOutlet var labelSize: UILabel!
    @IBOutlet var labelPoint: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let val = 3.dv_bind(name: "val") { [weak self] (newValue) in
            self?.label.text = "\(newValue)"
        }
        label.text = "\(val)"
        label.textColor = .black
        
        labelString.text = "Text".dv_bind(name: "text", block: { [weak self](newValue) in
            self?.labelString.text = newValue
        })
        
        let size = CGSize(width: 1, height: 2).dv_bind(name: "size") { [weak self] (newValue) in
            self?.labelSize.text = "\(newValue)"
            self?.labelSize.frame.size = newValue
        }
        self.labelSize.text = "\(size)"
        
        self.labelPoint.frame.origin = self.labelPoint.frame.origin.dv_bind(name: "origin") { [weak self] (point) in
            self?.labelPoint.text = "\(point)"
            self?.labelPoint.frame.origin = point
        }
        self.labelPoint.text = "\(self.labelPoint.frame.origin)"
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

