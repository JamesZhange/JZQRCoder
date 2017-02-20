//
//  ViewController.swift
//  JZQRCoder
//
//  Created by Liu Rui on 2017/1/20.
//  Copyright © 2017年 James. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isFirstStart: Bool = true;
    var CodeString: String? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if (true == isFirstStart) {
            isFirstStart = false;
            
            if (nil == CodeString) {
                弹出扫描页面
            }
        }
    }
}

