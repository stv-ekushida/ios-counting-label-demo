//
//  ViewController.swift
//  ios-counting-label-demo
//
//  Created by Eiji Kushida on 2017/05/11.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: CountingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //0〜100まで1秒かけてカウントアップする
        label.count(fromValue: 0,
                    to: 100,
                    withDuration: 1,
                    andAnimationType: .EaseIn,
                    andCouterType: .Int)
    }
}

