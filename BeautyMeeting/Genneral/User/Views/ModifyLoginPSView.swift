//
//  ModifyLoginPSView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/6.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class ModifyLoginPSView: UIView {
  
  
  convenience init(originPSTF:UITextField,newPSTF:UITextField,confirmPSTF:UITextField,type:ModifyPurposeType) {
    self.init(frame:CGRect.zero)
    
    let titleTextFieldViewLeftOffset:CGFloat = 80.ratioWidth
    
    originPSTF.decorateStyleOfTF(placeholderTitle: "请输入6~16位密码",placeholderColor:  .garyTitleColor, keyboardType: .default, borderStyle: .none, secureTextEntry: true, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    let oneBackView = TitleTextFieldView(imageName: nil, targetTextField: originPSTF)
    addSubview(oneBackView)
    oneBackView.snp.makeConstraints { (make) in
      make.right.top.equalTo(self)
      make.height.equalTo(CGDefine.height.textField)
      make.left.equalTo(titleTextFieldViewLeftOffset)
    }
    
    let oneLB = UILabel()
    addSubview(oneLB)
    if type == .modifyLoginPS {
      oneLB.decorateStyleOfLB(title: "原登录密码：", textColor: UIColor.black, textFont: 12.ratioHeight)
    }
    if type == .modifyTradePS {
      oneLB.decorateStyleOfLB(title: "原交易密码：", textColor: UIColor.black, textFont: 12.ratioHeight)
    }
    oneLB.snp.makeConstraints { (make) in
      make.left.equalTo(5)
      make.right.equalTo(oneBackView.snp.left)
      make.centerY.equalTo(oneBackView)
    }
    
    //////////
    
    newPSTF.decorateStyleOfTF(placeholderTitle: "请输入6~16位密码",placeholderColor:  .garyTitleColor, keyboardType: .default, borderStyle: .none, secureTextEntry: true, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    let twoBackView = TitleTextFieldView(imageName: nil, targetTextField: newPSTF)
    addSubview(twoBackView)
    twoBackView.snp.makeConstraints { (make) in
      make.right.equalTo(self)
      make.top.equalTo(oneBackView.snp.bottom).offset(6)
      make.height.equalTo(CGDefine.height.textField)
      make.left.equalTo(titleTextFieldViewLeftOffset)
    }
    
    let twoLB = UILabel()
    addSubview(twoLB)
    if type == .modifyLoginPS {
      twoLB.decorateStyleOfLB(title: "新登录密码：", textColor: UIColor.black, textFont: 12.ratioHeight)
    }
    if type == .modifyTradePS {
      twoLB.decorateStyleOfLB(title: "新交易密码：", textColor: UIColor.black, textFont: 12.ratioHeight)
    }
    twoLB.snp.makeConstraints { (make) in
      make.left.equalTo(5)
      make.right.equalTo(twoBackView.snp.left)
      make.centerY.equalTo(twoBackView)
    }
    
    
    //////////
    
    confirmPSTF.decorateStyleOfTF(placeholderTitle: "请输入6~16位密码",placeholderColor:  .garyTitleColor, keyboardType: .default, borderStyle: .none, secureTextEntry: true, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    let threeBackView = TitleTextFieldView(imageName: nil, targetTextField: confirmPSTF)
    addSubview(threeBackView)
    threeBackView.snp.makeConstraints { (make) in
      make.right.equalTo(self)
      make.top.equalTo(twoBackView.snp.bottom).offset(6)
      make.height.equalTo(CGDefine.height.textField)
      make.left.equalTo(titleTextFieldViewLeftOffset)
    }
    
    let threeLB = UILabel()
    addSubview(threeLB)
    threeLB.decorateStyleOfLB(title: "确认新密码：", textColor: UIColor.black, textFont: 12.ratioHeight)
    threeLB.snp.makeConstraints { (make) in
      make.left.equalTo(5)
      make.right.equalTo(threeBackView.snp.left)
      make.centerY.equalTo(threeBackView)
    }
    
    
    
    
  }
  
}



































