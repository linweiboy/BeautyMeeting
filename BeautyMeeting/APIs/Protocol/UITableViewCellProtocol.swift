//
//  UITableViewCellProtocol.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/9/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation


///先布局再赋值模式 icon和标题
//protocol ProtocolCustomCellBehindStyle {
//  var iconIV:UIImageView! {get set}
//  var titleLB:UILabel! {get set}
//}
//
//extension ProtocolCustomCellBehindStyle where Self:UITableViewCell {
//  
//  func addShowViews() {
//    addSubview(iconIV)
//    iconIV.snp.makeConstraints { (make) in
//      let leftOffset = CGDefine.width.cellLeftImageCenterXOffset
//      make.centerX.equalTo(self.snp.left).offset(leftOffset)
//      make.centerY.equalTo(self)
//      make.width.height.equalTo(15)
//    }
//    addSubview(titleLB)
//    titleLB.snp.makeConstraints { (make) in
//      make.left.equalTo(iconIV.snp.centerX).offset(20)
//      make.centerY.equalTo(self)
//    }
//    
//    let lineView = UIView()
//    addSubview(lineView)
//    lineView.backgroundColor =   .separateLine
//    lineView.snp.makeConstraints { (make) in
//      make.left.equalTo(titleLB)
//      make.height.equalTo(0.5)
//      make.right.bottom.equalTo(self)
//    }
//  }
//  
//  
//  func showData(imageName:String,title:String,textColor:UIColor,
//                textFont:CGFloat,isSelect:Bool = false) {
//    let imageC = UIImage(named: imageName)
//    if let image = imageC {
//      iconIV.image = image
//      iconIV.snp.updateConstraints({ (make) in
//        make.width.equalTo(image.ratioWidth)
//        make.height.equalTo(image.ratioHeight)
//      })
//    }
//    titleLB.decorateStyleOfLB(title:title, textColor: textColor, textFont: textFont)
//    if isSelect {
//      self.selectionStyle = .default
//      self.accessoryType = .disclosureIndicator
//    }else {
//      self.selectionStyle = .none
//      self.accessoryType = .none
//    }
//  }
//}
//
// 左边缘|-(15+10)-图片-标题
protocol ProtocolCustomCellDirectStyle {
  var iconIV:UIImageView! {get set}
  var titleLB:UILabel! {get set}
}

extension ProtocolCustomCellDirectStyle where Self:UITableViewCell {
  
  func addShowViews(imageName:String,title:String,
                    textColor:UIColor,textFont:CGFloat,isSelect:Bool = false) {
    
    addSubview(iconIV)
    iconIV.snp.makeConstraints { (make) in
      let leftOffset = CGDefine.width.cellLeftImageCenterXOffset
      make.centerX.equalTo(self.snp.left).offset(leftOffset)
      make.centerY.equalTo(self)
      make.width.height.equalTo(15)
    }
    
    let imageC = UIImage(named: imageName)
    if let image = imageC {
      iconIV.image = image
      iconIV.snp.updateConstraints({ (make) in
        make.width.equalTo(image.ratioWidth)
        make.height.equalTo(image.ratioHeight)
      })
    }
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title:title, textColor: textColor, textFont: textFont)
    titleLB.snp.makeConstraints { (make) in
      make.left.equalTo(iconIV.snp.centerX).offset(20)
      make.centerY.equalTo(self)
    }
    
    if isSelect {
      self.selectionStyle = .default
      self.accessoryType = .disclosureIndicator
    }else {
      self.selectionStyle = .none
      self.accessoryType = .none
    }
  }
}


// 标题和内容 cell
protocol TitleAndRightContentCellProtocol {
  var titleLB:UILabel! {get set}
  var contentLB:UILabel! {get set}
}

extension TitleAndRightContentCellProtocol where Self: UITableViewCell  {
  
  func addShowViews() {
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "", textColor:  .text, textFont: 12.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.left.equalTo(15)
      make.centerY.equalTo(self)
    }
    
    addSubview(contentLB)
    contentLB.decorateStyleOfLB(title: "", textColor:  .text, textFont: 12.ratioHeight, textAlignment: .right)
    contentLB.snp.makeConstraints { (make) in
      make.right.equalTo(CGDefine.width.cellRightLabelRightOffset)
      make.centerY.equalTo(self)
    }
  }
  
}


//
//protocol ProductCellStyle {
//  
//  var productTitleLB: UILabel! {get set} //产品标题
//  var promptLB: UILabel! {get set} //标的种类
//  var rewardYearIncomeLB: UILabel! {get set} //奖励年化收益
//  var expectYearIncomeLB: UILabel! {get set}
//  var timeLimitLB: UILabel! {get set}
//  var waterView: RoundProgressView! {get set}
//  var stateNoteLB: UILabel! {get set}
//  var expectYearIncomeTitleLB: UILabel! {get set}
//  var timeLimitTitleLB: UILabel! {get set}
//  
//}
//
//extension ProductCellStyle where Self: UITableViewCell {
//  
//  func addShowViews() {
//    self.backgroundColor = .white
//    
//    let selectedBackView = UIView()
//    self.selectedBackgroundView = selectedBackView
//    
//    addSubview(productTitleLB)
//    productTitleLB.decorateStyleOfLB(title: "", textColor:  .title, textFont: 13.ratioHeight)
//    productTitleLB.snp.makeConstraints { (make) in
//      make.top.equalTo(10)
//      make.left.equalTo(15)
//      make.right.lessThanOrEqualTo(-80)
//    }
//    
//    addSubview(promptLB)
//    promptLB.layer.cornerRadius = 5
//    promptLB.layer.borderWidth = 0.5
//    promptLB.layer.masksToBounds = true
//    promptLB.layer.borderColor = UIColor(hexStr: "F26261").cgColor
//    promptLB.decorateStyleOfLB(title: "", textColor: UIColor(hexStr: "F26261"), textFont: 11,textAlignment: .center,backGroundColor: UIColor(hexStr: "FEF7F7"))
//    promptLB.snp.makeConstraints { (make) in
//      make.left.equalTo(productTitleLB.snp.right).offset(5)
//      make.centerY.equalTo(productTitleLB)
//      make.height.equalTo(20)
//      make.width.equalTo(1)
//    }
//    
//    addSubview(rewardYearIncomeLB)
//    rewardYearIncomeLB.layer.cornerRadius = 5
//    rewardYearIncomeLB.layer.borderWidth = 0.5
//    rewardYearIncomeLB.layer.masksToBounds = true
//    rewardYearIncomeLB.layer.borderColor = UIColor(hexStr: "F26261").cgColor
//    rewardYearIncomeLB.decorateStyleOfLB(title: "", textColor: UIColor(hexStr: "F26261"), textFont: 10.ratioHeight,textAlignment: .center,backGroundColor: UIColor(hexStr: "FEF7F7"))
//    rewardYearIncomeLB.snp.makeConstraints { (make) in
//      make.left.equalTo(promptLB.snp.right).offset(5)
//      make.centerY.equalTo(promptLB)
//      make.height.equalTo(20)
//      make.width.equalTo(40)
//    }
//    
//    // 预期年化 eg: "14.00%"
//    addSubview(expectYearIncomeLB)
//    expectYearIncomeLB.decorateStyleOfLB(title: "", textColor:  .number, textFont: 15.ratioHeight,textAlignment:.center)
//    expectYearIncomeLB.sizeToFit()
//    expectYearIncomeLB.snp.makeConstraints { (make) in
//      make.top.equalTo(productTitleLB.snp.bottom).offset(10.ratioHeight)
//      make.left.equalTo(productTitleLB)
//      make.right.lessThanOrEqualTo(self.snp.centerX)
//    }
//    
//    addSubview(expectYearIncomeTitleLB)
//    expectYearIncomeTitleLB.decorateStyleOfLB(title: "预期年化", textColor: UIColor.rgbValue(sameValue: 166), textFont: 11.ratioHeight,textAlignment:.center)
//    expectYearIncomeTitleLB.sizeToFit()
//    expectYearIncomeTitleLB.snp.makeConstraints { (make) in
//      make.top.equalTo(expectYearIncomeLB.snp.bottom).offset(5.ratioHeight)
//      make.left.equalTo(productTitleLB)
//    }
//    
//    addSubview(timeLimitLB)
//    timeLimitLB.decorateStyleOfLB(title: "", textColor: UIColor.red, textFont: 12.ratioHeight, textAlignment: .center)
//    timeLimitLB.snp.makeConstraints { (make) in
//      make.centerX.equalTo(self.snp.centerX).offset(15)
//      make.centerY.equalTo(expectYearIncomeLB).offset(-3.ratioHeight)
//    }
//    
//    addSubview(timeLimitTitleLB)
//    timeLimitTitleLB.decorateStyleOfLB(title: "期限", textColor: UIColor.rgbValue(sameValue: 166), textFont: 11.ratioHeight, textAlignment: .center)
//    timeLimitTitleLB.sizeToFit()
//    timeLimitTitleLB.snp.makeConstraints { (make) in
//      make.centerY.equalTo(expectYearIncomeTitleLB)
//      make.left.equalTo(timeLimitLB)
//    }
//    
//    addSubview(waterView)
//    waterView.snp.makeConstraints { (make) in
//      make.centerY.equalTo(timeLimitTitleLB.snp.top).offset(-5.ratioHeight)
//      make.right.equalTo(-15)
//      make.width.height.equalTo(40.ratioHeight)
//      make.bottom.equalTo(-13.ratioHeight)
//    }
//    
//    addSubview(stateNoteLB)
//    stateNoteLB.backgroundColor = UIColor.clear
//    stateNoteLB.decorateStyleOfLB(title: "", textColor: UIColor.rgbValue(sameValue: 166), textFont: 10.ratioHeight, textAlignment: .center)
//    stateNoteLB.numberOfLines = 0
//    stateNoteLB.snp.makeConstraints { (make) in
//      make.center.equalTo(waterView)
//    }
//  }
//  
//}
//
//
//



