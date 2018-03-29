//
//  OperateWaitingView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/11/8.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

class OperateWaitingView: UIView {

  var clickClo:((_ tag:Int)->())!
  
  convenience init(title:String,btTitleArr:[String]) {
    self.init(frame: .zero)
    
    self.backgroundColor =   .separateLine
    
    let topView = OperateSuccessTopView()
    addSubview(topView)
    topView.backgroundColor = .white
    topView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(200)
    }
    
    let tipLogoIM = UIImage(named: "user_rechangeWait")!
    let tipLogoIV = UIImageView(image: tipLogoIM)
    topView.addSubview(tipLogoIV)
    tipLogoIV.snp.makeConstraints { (make) in
      make.centerX.equalTo(topView.snp.centerX)
      make.centerY.equalTo(50)
      make.width.equalTo(tipLogoIM.ratioWidth)
      make.height.equalTo(tipLogoIM.ratioHeight)
    }
    
    let titleLB = UILabel()
    topView.addSubview(titleLB)
    titleLB.decorateStyleOfLB(title:title, textColor:   .prittyBlue, textFont: 16.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.top.equalTo(tipLogoIV.snp.bottom).offset(15)
      make.centerX.equalTo(tipLogoIV.snp.centerX)
    }
    
    guard btTitleArr.count <= 2 else { return }
    
    var leftBT:UIButton!
    if btTitleArr.count == 1 {
      leftBT = RoundCornerBT(type: .custom)
      leftBT.decorateStyleOfBT(title: btTitleArr[0], textColor: .white, textFont: FontDefine.fifteen, backGroundColor: .main)
      addSubview(leftBT)
      leftBT.snp.makeConstraints { (make) in
        make.top.equalTo(topView.snp.bottom).offset(30.ratioHeight)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(CGDefine.height.maxButton)
      }
    }else {
      leftBT = RoundCornerLineBT(borderColor: .main, lineWidth: 1, radian: 3, fillColor: .white)
      addSubview(leftBT)
      leftBT.decorateStyleOfBT(title: btTitleArr[0], textColor:.main, textFont: FontDefine.fifteen, backGroundColor: .clear)
      leftBT.snp.makeConstraints { (make) in
        make.top.equalTo(topView.snp.bottom).offset(30.ratioHeight)
        make.left.equalTo(15)
        make.height.equalTo(CGDefine.height.maxButton)
      }
    }
    
    leftBT.tag = 10
    leftBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    
    guard btTitleArr.count == 2  else { return }
    
    let rightBT = RoundCornerBT()
    addSubview(rightBT)
    rightBT.tag = 11
    rightBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    rightBT.decorateStyleOfBT(title: btTitleArr[1], textColor: .white, textFont: FontDefine.fifteen, backGroundColor:.main)
    rightBT.snp.makeConstraints { (make) in
      make.width.top.equalTo(leftBT)
      make.left.equalTo(leftBT.snp.right).offset(15)
      make.height.equalTo(CGDefine.height.maxButton)
      make.right.equalTo(-15)
    }
    
  }
  
  @objc func btClick(bt:UIButton) {
    clickClo(bt.tag)
  }
  

}
