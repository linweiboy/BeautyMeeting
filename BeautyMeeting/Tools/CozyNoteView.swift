//
//  CozyNoteView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/1.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//温馨提示 view


class CozyNoteView: UIView {
  
  
  //标题+笑脸+文字
  convenience init(oneTitle:String,middleImageName:String,twoTitle:String) {
    self.init(frame:CGRect.zero)
    
    let oneLB = UILabel()
    addSubview(oneLB)
    oneLB.decorateStyleOfLB(title: oneTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10.ratioHeight)
    oneLB.snp.makeConstraints { (make) in
      make.top.left.equalTo(self)
    }
    
    let oneIM = UIImageView()
    addSubview(oneIM)
    oneIM.image = UIImage(named: middleImageName)
    oneIM.snp.makeConstraints { (make) in
      make.left.equalTo(oneLB.snp.right)
      make.centerY.equalTo(oneLB)
      make.width.height.equalTo(10)
    }
    
    let twoLB = UILabel()
    addSubview(twoLB)
    twoLB.numberOfLines = 0
    twoLB.decorateStyleOfLB(title: twoTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10.ratioHeight)
    twoLB.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(oneLB.snp.bottom).offset(5)
      make.right.equalTo(self)
    }
    
    
    
  }
  
  //标题+笑脸+文字+文字
  convenience init(oneTitle:String,middleImageName:String,twoTitle:String,threeTitle:String) {
    self.init(frame:CGRect.zero)
    
    let oneLB = UILabel()
    addSubview(oneLB)
    oneLB.decorateStyleOfLB(title: oneTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10.ratioHeight)
    oneLB.snp.makeConstraints { (make) in
      make.top.left.equalTo(self)
    }
    
    let oneIM = UIImageView()
    addSubview(oneIM)
    oneIM.image = UIImage(named: "cozy_note")
    oneIM.snp.makeConstraints { (make) in
      make.left.equalTo(oneLB.snp.right)
      make.centerY.equalTo(oneLB)
      make.width.height.equalTo(10)
    }
    
    let twoLB = UILabel()
    addSubview(twoLB)
    twoLB.numberOfLines = 0
    let att = NSAttributedString.attributedOfTwoPart(onePartTitle: twoTitle, onePartForegroundColor: UIColor.rgbValue(sameValue: 114), onePartFontSize: 10.ratioHeight, twoPartTitle: threeTitle, twoPartForegroundColor:   .textRed, twoPartFontSize: 10.ratioHeight)
    twoLB.attributedText = att
    twoLB.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(oneLB.snp.bottom).offset(5)
      make.right.equalTo(self)
    }
    
  }
  
  
  //标题+笑脸+文字+可点击文字
  convenience init(oneTitle:String,middleImageName:String,twoTitle:String,canClickThreeTitle:String) {
    self.init(frame:CGRect.zero)
    
    let oneLB = UILabel()
    addSubview(oneLB)
    oneLB.decorateStyleOfLB(title: oneTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10)
    oneLB.snp.makeConstraints { (make) in
      make.top.left.equalTo(self)
    }
    
    let oneIM = UIImageView()
    addSubview(oneIM)
    oneIM.image = UIImage(named: "cozy_note")
    oneIM.snp.makeConstraints { (make) in
      make.left.equalTo(oneLB.snp.right)
      make.centerY.equalTo(oneLB)
      make.width.height.equalTo(10)
    }
    
    let twoLB = UILabel()
    addSubview(twoLB)
    twoLB.decorateStyleOfLB(title: twoTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10)
    twoLB.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(oneLB.snp.bottom).offset(5)
    }
    
    let threeBT = UIButton(type: .custom)
    addSubview(threeBT)
    threeBT.addTarget(self, action: #selector(threeBTClick), for: .touchUpInside)
    let att = NSAttributedString.attributedForUnderLineAndNormal(oneTitle: canClickThreeTitle, oneTitleColor:   .prittyBlue, twoTitle: "", twoTitleColor: UIColor.rgbValue(sameValue: 114))
    threeBT.titleLabel?.font = UIFont.systemFont(ofSize: 10)
    threeBT.setAttributedTitle(att, for: .normal)
    threeBT.snp.makeConstraints { (make) in
      make.left.equalTo(twoLB.snp.right)
      make.centerY.equalTo(twoLB)
    }
  }
  
  @objc func threeBTClick() {
    AccessSystem.callTelephony(CustomerService)
  }
  
  
  //标题+笑脸+序号文字+序号文字
  convenience init(oneTitle:String,middleImageName:String,twoNumTitle:String,threeNumTitle:String) {
    self.init(frame:CGRect.zero)
    
    let oneLB = UILabel()
    addSubview(oneLB)
    oneLB.decorateStyleOfLB(title: oneTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 11)
    oneLB.snp.makeConstraints { (make) in
      make.top.left.equalTo(self)
    }
    
    let oneIM = UIImageView()
    addSubview(oneIM)
    oneIM.image = UIImage(named: "cozy_note")
    oneIM.snp.makeConstraints { (make) in
      make.left.equalTo(oneLB.snp.right)
      make.centerY.equalTo(oneLB)
      make.width.height.equalTo(10)
    }
    
    let twoNumIM = UIImageView.create("detail_num1")
    addSubview(twoNumIM)
    twoNumIM.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(oneLB.snp.bottom).offset(5)
      make.width.height.equalTo(10)
    }
    
    let twoLB = UILabel()
    addSubview(twoLB)
    twoLB.numberOfLines = 0
    twoLB.decorateStyleOfLB(title: twoNumTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10)
    twoLB.snp.makeConstraints { (make) in
      make.left.equalTo(twoNumIM.snp.right).offset(3)
      make.top.equalTo(oneLB.snp.bottom).offset(5)
      make.right.equalTo(self)
    }
    
    let threeNumIM = UIImageView.create("detail_num2")
    addSubview(threeNumIM)
    threeNumIM.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(twoLB.snp.bottom).offset(5)
      make.width.height.equalTo(10)
    }
    
    let threeLB = UILabel()
    addSubview(threeLB)
    threeLB.numberOfLines = 0
    threeLB.decorateStyleOfLB(title: threeNumTitle, textColor: UIColor.rgbValue(sameValue: 114), textFont: 10)
    threeLB.snp.makeConstraints { (make) in
      make.left.equalTo(threeNumIM.snp.right).offset(3)
      make.top.equalTo(twoLB.snp.bottom).offset(5)
      make.right.equalTo(self)
    }
    
  }
  
  
  
  
  
  
  
  
  
}
