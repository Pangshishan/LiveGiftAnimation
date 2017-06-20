//
//  ViewController.swift
//  直播礼物动画
//
//  Created by 山不在高 on 17/6/20.
//  Copyright © 2017年 山不在高. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var giftContainerView : GiftContainerView = GiftContainerView(frame: CGRect(x: 0, y: 100, width: 250, height: 90))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftContainerView.backgroundColor = UIColor.lightGray
        view.addSubview(giftContainerView)
    }
    
    @IBAction func clickGiftFirst(_ sender: Any) {
        let gift1 = GiftModel(senderName: "coderw", senderURL: "icon4", giftName: "汽车", giftURL: "prop_b")
        giftContainerView.showGiftModel(gift1)
    }
    @IBAction func clickGiftSecond(_ sender: Any) {
        let gift2 = GiftModel(senderName: "coder", senderURL: "icon2", giftName: "啤酒", giftURL: "prop_f")
        giftContainerView.showGiftModel(gift2)
    }
    @IBAction func clickGiftThird(_ sender: Any) {
        let gift3 = GiftModel(senderName: "w", senderURL: "icon3", giftName: "蘑菇", giftURL: "prop_g")
        giftContainerView.showGiftModel(gift3)
    }

}

