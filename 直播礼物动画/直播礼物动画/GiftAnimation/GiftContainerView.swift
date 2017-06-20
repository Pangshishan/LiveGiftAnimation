//
//  GiftContainerView.swift
//  04-礼物动画展示
//
//  Created by 小码哥 on 2016/12/17.
//  Copyright © 2016年 xmg. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class GiftContainerView: UIView {
    
    // MARK: 定义属性
    fileprivate lazy var channelViews : [GiftChannelView] = [GiftChannelView]()
    fileprivate lazy var cacheGiftModels : [GiftModel] = [GiftModel]()
    
    // MARK: 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension GiftContainerView {
    fileprivate func setupUI() {
        // 1.根据当前的渠道数，创建GiftChannelView
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            
            let channelView = GiftChannelView.loadFromNib()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            
            channelView.complectionCallback = { channelView in
                // 1.取出换成中模型
                guard self.cacheGiftModels.count != 0 else {
                    return
                }
                
                // 2.取出缓存的第一个模型
                let firstGiftModel = self.cacheGiftModels.first!
                self.cacheGiftModels.removeFirst()
                
                // 3.让闲置的channelView执行动画
                channelView.giftModel = firstGiftModel
                
                // 4.将数组中剩余有和firstGiftModel相同的模型放入到ChanelView缓存中
                for i in (0..<self.cacheGiftModels.count).reversed() {
                    let giftModel = self.cacheGiftModels[i]
                    if giftModel.isEqual(firstGiftModel) {
                        channelView.addOnceToCache()
                        self.cacheGiftModels.remove(at: i)
                    }
                }
            }
        }
    }
}


extension GiftContainerView {
    func showGiftModel(_ giftModel : GiftModel) {
        // 1.判断正在忙的ChanelView和赠送的新礼物的(username/giftname)
        if let channelView = checkUsingChanelView(giftModel) {
            channelView.addOnceToCache()
            return
        }
        
        // 2.判断有没有闲置的ChanelView
        if let channelView = checkIdleChannelView() {
            channelView.giftModel = giftModel
            return
        }
        
        // 3.将数据放入缓存中
        cacheGiftModels.append(giftModel)
    }
    
    private func checkUsingChanelView(_ giftModel : GiftModel) -> GiftChannelView? {
        for channelView in channelViews {
            if giftModel.isEqual(channelView.giftModel) && channelView.state != .endAnimating {
                return channelView
            }
        }
        
        return nil
    }
    
    private func checkIdleChannelView() -> GiftChannelView? {
        for channelView in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        
        return nil
    }
}
