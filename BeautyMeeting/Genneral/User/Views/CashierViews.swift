//
//  CashierViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/2.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class CashierView: UIView {
  
  fileprivate let nameLB = UILabel()
  fileprivate let numberLB = UILabel()
  fileprivate let payLB = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    addSubview(nameLB)
    nameLB.decorateStyleOfLB(title: "商户名称：美读会文化传媒有限公司", textColor: .black, textFont: 12.ratioHeight)
    nameLB.snp.makeConstraints { (make) in
      make.top.equalTo(20)
      make.left.equalTo(15)
    }
    
    addSubview(numberLB)
    numberLB.decorateStyleOfLB(title: "订单编号：201803114219", textColor: .black, textFont: 12.ratioHeight)
    numberLB.snp.makeConstraints { (make) in
      make.top.equalTo(nameLB.snp.bottom).offset(10)
      make.left.equalTo(15)
    }
    
    addSubview(payLB)
    let att = NSAttributedString.attributedOfTwoPart(onePartTitle: "支付金额：", onePartForegroundColor: .black, onePartFontSize: 12.ratioHeight, twoPartTitle: "365元/年", twoPartForegroundColor: .red, twoPartFontSize: 12.ratioHeight)
    payLB.attributedText = att
    payLB.snp.makeConstraints { (make) in
      make.top.equalTo(numberLB.snp.bottom).offset(10)
      make.left.equalTo(15)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


class payTypeView: UIView {
  
  var payClick:(()->())?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    
    let headerView = UIView()
    headerView.backgroundColor = .white
    addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(45.ratioHeight)
    }
    
    let payTitleLB = UILabel()
    payTitleLB.decorateStyleOfLB(title: "支付方式", textColor: UIColor.garyTitleColor, textFont: 13.ratioHeight)
    headerView.addSubview(payTitleLB)
    payTitleLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(headerView)
      make.left.equalTo(15)
    }
    
    let oneLine = UIView()
    oneLine.backgroundColor = UIColor.separateLine
    addSubview(oneLine)
    oneLine.snp.makeConstraints { (make) in
      make.top.equalTo(headerView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(0.5)
    }
    
    let payView = WeiXinView()
    let tap = UITapGestureRecognizer(target: self, action: #selector(payTypeClick))
    payView.addGestureRecognizer(tap)
    addSubview(payView)
    payView.snp.makeConstraints { (make) in
      make.top.equalTo(oneLine.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
  }
  
  @objc func payTypeClick() {
    if payClick != nil {
      payClick!()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class WeiXinView: UIView,ProtocolBorderLineView {
  var locationDirection:LineLocation = .Bottom
  var borderLineColor:UIColor = UIColor.separateLine
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    
    let imageView = UIImageView()
    let image = UIImage(named: "weixin")
    imageView.image = image
    addSubview(imageView)
    imageView.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(15)
      make.width.equalTo((image?.width)!)
      make.height.equalTo((image?.height)!)
    }
    
    let titleLB = UILabel()
    titleLB.decorateStyleOfLB(title: "微信支付", textColor: .black, textFont: 12.ratioHeight)
    addSubview(titleLB)
    titleLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(imageView.snp.right).offset(5)
    }
    
    
    let arrowImageView = UIImageView()
    let arrowimage = UIImage(named: "arrow_right")
    arrowImageView.image = arrowimage
    addSubview(arrowImageView)
    arrowImageView.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.right.equalTo(-15)
      make.width.equalTo((arrowimage?.width)!)
      make.height.equalTo((arrowimage?.height)!)
    }

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func draw(_ rect: CGRect) {
    drawInRect(rect)
  }
}

