//
//  ApplyViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/26.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation
import UIKit

class ApplyView: UIView {
  
  convenience init(nameTF:UITextField,idCardTF:UITextField,sixTF:UITextField,applyCityTF:UITextField,addressTF:UITextField) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = .white
    
    let nameView = ApplyTextFiledView(titleStr: "真实姓名", textTF: nameTF)
    nameTF.decorateStyleOfTF(placeholderTitle: "请输入真实姓名", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(nameView)
    nameView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let idCradView = ApplyTextFiledView(titleStr: "身份证号", textTF: idCardTF)
    idCardTF.decorateStyleOfTF(placeholderTitle: "请输入身份证号", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(idCradView)
    idCradView.snp.makeConstraints { (make) in
      make.top.equalTo(nameView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let sixView = ApplyTextFiledView(titleStr: "性      别", textTF: sixTF)
    sixTF.decorateStyleOfTF(placeholderTitle: "请输入性别", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(sixView)
    sixView.snp.makeConstraints { (make) in
      make.top.equalTo(idCradView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let cityView = ApplyTextFiledView(titleStr: "申请城市", textTF: applyCityTF)
    applyCityTF.decorateStyleOfTF(placeholderTitle: "请输入申请城市", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(cityView)
    cityView.snp.makeConstraints { (make) in
      make.top.equalTo(sixView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let addressView = ApplyTextFiledView(titleStr: "常驻地址", textTF: addressTF)
    addressTF.decorateStyleOfTF(placeholderTitle: "请输入常驻地址", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(addressView)
    addressView.snp.makeConstraints { (make) in
      make.top.equalTo(cityView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
  }
  
}


class ApplyTextFiledView:UIView, ProtocolBorderLineView{
  var locationDirection:LineLocation  = .Bottom
  var borderLineColor:UIColor = UIColor.separateLine
  
  convenience init(titleStr:String,textTF:UITextField){
    self.init(frame: CGRect.zero)
    self.backgroundColor = .white
    
    let att = NSAttributedString.attributedOfTwoPart(onePartTitle: "*", onePartForegroundColor: .red, onePartFontSize: 15, twoPartTitle: titleStr, twoPartForegroundColor: .black, twoPartFontSize: 13.ratioHeight)
    let titleLB = UILabel()
    titleLB.attributedText = att
    addSubview(titleLB)
    titleLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(15)
      make.width.equalTo(62.ratioWidth)
    }
    
    addSubview(textTF)
    textTF.textAlignment = .left
    textTF.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(titleLB.snp.right).offset(15)
      make.right.equalTo(-15)
      
    }
  }
  
  override func draw(_ rect: CGRect) {
    drawInRect(rect)
  }
}

class ApplyBoBaoView: UIView {
  
  convenience init(nameTF:UITextField,idCardTF:UITextField,sixTF:UITextField,applyCityTF:UITextField,addressTF:UITextField) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = .white
    
    let nameView = ApplyTextFiledView(titleStr: "真实姓名", textTF: nameTF)
    nameTF.decorateStyleOfTF(placeholderTitle: "请输入真实姓名", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(nameView)
    nameView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let idCradView = ApplyTextFiledView(titleStr: "身份证号", textTF: idCardTF)
    idCardTF.decorateStyleOfTF(placeholderTitle: "请输入身份证号（选填）", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(idCradView)
    idCradView.snp.makeConstraints { (make) in
      make.top.equalTo(nameView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let sixView = ApplyTextFiledView(titleStr: "性      别", textTF: sixTF)
    sixTF.decorateStyleOfTF(placeholderTitle: "请输入性别", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(sixView)
    sixView.snp.makeConstraints { (make) in
      make.top.equalTo(idCradView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let cityView = ApplyTextFiledView(titleStr: "申请城市", textTF: applyCityTF)
    applyCityTF.decorateStyleOfTF(placeholderTitle: "请输入申请城市", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(cityView)
    cityView.snp.makeConstraints { (make) in
      make.top.equalTo(sixView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
    
    let addressView = ApplyTextFiledView(titleStr: "常驻地址", textTF: addressTF)
    addressTF.decorateStyleOfTF(placeholderTitle: "请输入常驻地址", placeholderColor: UIColor.gray, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .black, textFont: 13.ratioHeight)
    addSubview(addressView)
    addressView.snp.makeConstraints { (make) in
      make.top.equalTo(cityView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(40.ratioHeight)
    }
  }
  
}

