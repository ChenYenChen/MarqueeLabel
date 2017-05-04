//
//  ViewController.swift
//  MarqueeLabel
//
//  Created by 陳彥辰 on 2017/5/2.
//  Copyright © 2017年 Ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var marquee: MarqueeLabelAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.marquee.textColor = UIColor.purple
        self.marquee.text = "這裡是一個跑馬燈  我很努力的很過這個山頭  發現還有好幾個山頭  不知道什麼時候才有結束的一天阿...."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

