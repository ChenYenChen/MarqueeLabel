//
//  MarqueeLabelAction.swift
//  MarqueeLabel
//  跑馬燈
//  Created by Ray on 2017/5/2.
//  Copyright © 2017年 Ray. All rights reserved.
//

import UIKit

class MarqueeLabelAction: UIView {
    
    /// 文字
    @IBInspectable var text: String = "" {
        willSet {
            // 清空舊的  因為要更具字的長度判斷是否需要
            self.labelArray.removeAll()
            
            for view in self.subviews {
                view.removeFromSuperview()
            }
        }
        didSet {
            // 建立新的
            self.creat()
        }
    }
    /// 顏色
    @IBInspectable var textColor: UIColor = UIColor.black {
        didSet {
            guard self.labelArray.count > 0 else {
                return
            }
            
            for label in self.labelArray {
                label.textColor = self.textColor
            }
        }
    }
    /// 字型
    @IBInspectable var textFont: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            guard self.labelArray.count > 0 else {
                return
            }
            
            for label in self.labelArray {
                label.font = self.textFont
            }
        }
    }
    
    private var labelArray: [UILabel] = []
    private var rect1: CGRect!
    private var rect2: CGRect!
    private var timeInterval: TimeInterval!
    // 建立
    private func creat() {
        self.timeInterval = self.displayDurationForString(self.text)
        
        let textLab: UILabel = UILabel(frame: CGRect.zero)
        textLab.textColor = self.textColor
        textLab.text = self.text
        textLab.font = self.textFont
        
        let labelSize: CGSize = textLab.sizeThatFits(CGSize.zero)
        
        self.rect1 = CGRect(x: 0, y: 0, width: labelSize.width + 20, height: self.bounds.size.height)
        self.rect2 = CGRect(x: self.rect1.size.width, y: 0, width: self.rect1.size.width, height: self.rect1.size.height)
        textLab.frame = self.rect1
        self.addSubview(textLab)
        
        self.labelArray.append(textLab)
        
        self.start()
    }
    
    // 開始前判斷是否需要執行跑馬燈
    private func start() {
        // 判斷文字是否大於框框
        guard self.rect1.size.width > self.bounds.size.width else {
            return
        }
        
        let textLab2: UILabel = UILabel(frame: self.rect2)
        textLab2.text = self.text
        textLab2.font = self.textFont
        textLab2.textColor = self.textColor
        self.addSubview(textLab2)
        
        self.labelArray.append(textLab2)
        self.startAnimate()
    }
    
    // 開始動畫
    private func startAnimate() {
        guard self.labelArray.count > 1 else {
            return
        }
        
        let label1 = self.labelArray[0]
        let label2 = self.labelArray[1]
        
        UIView.transition(with: self, duration: self.timeInterval, options: .curveLinear, animations: { 
            
            label1.frame.origin = CGPoint(x: -self.rect1.width, y: 0)
            label2.frame.origin = CGPoint(x: 0, y: 0)
            
        }) { (finished) in
            
            label1.frame = self.rect2
            label2.frame = self.rect1
            
            self.labelArray[0] = label2
            self.labelArray[1] = label1
            
            self.startAnimate()
        }
    }
    
    // 間隔
    private func displayDurationForString(_ string: String) -> TimeInterval {
        let time: TimeInterval = Double(string.characters.count / 2)
        return time
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
}
