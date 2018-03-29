//
//  NoDataView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/9/5.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//加载不出来数据的时候显示的view

class NoDataView: UIView {
  
  var clickClo:(()->())?
  
  //提示文字
  convenience init(tipTitle:String,btTitle:String? = nil) {
    self.init(frame: .zero)
    let topIM = UIImage(named: "Finance_NoHaveData")!
    let topIV = UIImageView(image: topIM)
    addSubview(topIV)
    topIV.snp.makeConstraints { (make) in
      make.centerX.equalTo(self)
      make.bottom.equalTo(self.snp.centerY).offset(-10)
      make.width.equalTo(topIM.ratioWidth)
      make.height.equalTo(topIM.ratioHeight)
    }
    
    let tipLB = UILabel()
    addSubview(tipLB)
    tipLB.decorateStyleOfLB(title: tipTitle, textColor:  .text, textFont: 12.ratioHeight, textAlignment: .center)
    tipLB.snp.makeConstraints { (make) in
      make.top.equalTo(topIV.snp.bottom).offset(20)
      make.centerX.equalTo(topIV)
    }
    
    if let btT = btTitle {
      let bt = RoundCornerLineBT(borderColor:.main, lineWidth: 1, radian: 3, fillColor: .white)
      bt.decorateStyleOfBT(title: btT, textColor:.main, textFont: 14.ratioHeight,backGroundColor:.clear)
      addSubview(bt)
      bt.addTarget(self, action: #selector(btClick), for: .touchUpInside)
      bt.snp.makeConstraints { (make) in
        make.top.equalTo(tipLB.snp.bottom).offset(23)
        make.centerX.equalTo(topIV)
        make.height.equalTo(CGDefine.height.maxButton)
        make.width.equalTo(145)
      }
    }
  }
  
  @objc func btClick() {
    clickClo?()
  }
  
  
}
