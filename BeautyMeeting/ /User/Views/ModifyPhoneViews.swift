//
//  ModifyPhoneViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/2.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation
import UIKit

class AchieveVoiceVerifyNumView: UIView {
  
  var achieveVerifyNumClosure:(()->())?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor =  .backGround
    
    let oneNotReceiveVerifyNumBT = UIButton(type: .custom)
    addSubview(oneNotReceiveVerifyNumBT)
    oneNotReceiveVerifyNumBT.decorateStyleOfBT(title:"", textColor:   .textRed, textFont: 12,backGroundColor:  .backGround)
    let att = NSAttributedString.attributedOfUnderLine(title: "获取语音验证码", titleColor:   .textRed)
    oneNotReceiveVerifyNumBT.setAttributedTitle(att, for: .normal)
    oneNotReceiveVerifyNumBT.addTarget(self, action: #selector(oneNotReceiveVerifyNumBTClick), for: .touchUpInside)
    let width = "获取语音验证码".achieveStringRect(ScreenWidth, font: 12).width
    oneNotReceiveVerifyNumBT.snp.makeConstraints { (make) in
      make.right.top.bottom.equalTo(self)
      make.width.equalTo(width)
    }
    
    let notReceiveVerifyNumLB = UILabel()
    addSubview(notReceiveVerifyNumLB)
    notReceiveVerifyNumLB.decorateStyleOfLB(title:"收不到验证码?点击", textColor: UIColor.rgbValue(red: 55, green: 68, blue: 87), textFont: 11.ratioHeight, textAlignment: .right)
    notReceiveVerifyNumLB.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.right.equalTo(oneNotReceiveVerifyNumBT.snp.left)
    }
    
  }
  
  @objc func oneNotReceiveVerifyNumBTClick() {
    if achieveVerifyNumClosure != nil {
      achieveVerifyNumClosure!()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class ModifyPhoneNumHeadView: UIView {
  
  let oneOneBT = UIButton(type: .custom)
  let oneTwoBT = UIButton(type: .custom)
  let oneThreeBT = UIButton(type: .custom)
  
  let twoOneBT = UIButton(type: .custom)
  let twoTwoBT = UIButton(type: .custom)
  let twoThreeBT = UIButton(type: .custom)
  
  let threeOneBT = UIButton(type: .custom)
  let threeTwoBT = UIButton(type: .custom)
  
  //65
  let dd = UIColor.white
  convenience init(selectedIndex:Int) {
    self.init(frame:CGRect.zero)
    self.backgroundColor =   .orangeColor
    let deselectColor = UIColor.rgbValue(red: 255, green: 151, blue: 48)
    
    ///
    twoOneBT.setImage(UIImage(named: "modifyPhoneNum_orangePhone"), for: .normal)
    twoOneBT.setImage(UIImage(named: "modifyPhoneNum_whitePhone"), for: .selected)
    addSubview(twoOneBT)
    twoOneBT.snp.makeConstraints { (make) in
      make.width.equalTo(16)
      make.height.equalTo(25)
      make.centerY.equalTo(self).offset(-10)
      make.centerX.equalTo(self).offset(-25.ratioWidth)
    }
    
    twoTwoBT.setImage(UIImage(named: "modifyPhoneNum_deselectedArrow"), for:.normal)
    twoTwoBT.setImage(UIImage(named: "modifyPhoneNum_selectedArrow"), for: .selected)
    addSubview(twoTwoBT)
    twoTwoBT.snp.makeConstraints { (make) in
      make.width.equalTo(55)
      make.height.equalTo(5)
      make.left.equalTo(twoOneBT.snp.right).offset(15.ratioWidth)
      make.centerY.equalTo(twoOneBT)
    }
    
    twoThreeBT.setTitle("输入新手机号码", for: .normal)
    twoThreeBT.titleLabel?.font = UIFont.systemFont(ofSize: 11)
    twoThreeBT.setTitleColor(UIColor.white, for: .selected)
    twoThreeBT.setTitleColor(deselectColor, for: .normal)
    addSubview(twoThreeBT)
    twoThreeBT.snp.makeConstraints { (make) in
      make.bottom.equalTo(self).offset(-5)
      make.left.equalTo(twoOneBT)
      make.right.equalTo(twoTwoBT)
      make.height.equalTo(20)
    }
    
    if selectedIndex == 1 {
      twoOneBT.isSelected = true
      twoTwoBT.isSelected = true
      twoThreeBT.isSelected = true
    }
    
    oneTwoBT.setImage(UIImage(named: "modifyPhoneNum_selectedArrow"), for: .normal)
    addSubview(oneTwoBT)
    oneTwoBT.snp.makeConstraints { (make) in
      make.width.equalTo(55)
      make.height.equalTo(5)
      make.right.equalTo(twoOneBT.snp.right).offset(-30.ratioWidth)
      make.centerY.equalTo(twoOneBT)
    }
    
    oneOneBT.setImage(UIImage(named: "modifyPhoneNum_message"), for: .normal)
    addSubview(oneOneBT)
    oneOneBT.snp.makeConstraints { (make) in
      make.width.equalTo(16)
      make.height.equalTo(25)
      make.right.equalTo(oneTwoBT.snp.left).offset(-10.ratioWidth)
      make.centerY.equalTo(twoOneBT)
    }
    
    oneThreeBT.setTitle("验证原手机号码", for: .normal)
    oneThreeBT.titleLabel?.font = UIFont.systemFont(ofSize: 11)
    oneThreeBT.setTitleColor(.white, for: .normal)
    addSubview(oneThreeBT)
    oneThreeBT.snp.makeConstraints { (make) in
      make.bottom.equalTo(self).offset(-5)
      make.left.equalTo(oneOneBT)
      make.right.equalTo(oneTwoBT)
      make.height.equalTo(20)
    }
    
    ///
    threeOneBT.setImage(UIImage(named: "modifyPhoneNum_finish"), for: .normal)
    addSubview(threeOneBT)
    threeOneBT.snp.makeConstraints { (make) in
      make.height.width.equalTo(23)
      make.left.equalTo(twoTwoBT.snp.right).offset(20.ratioWidth)
      make.centerY.equalTo(twoTwoBT)
    }
    threeTwoBT.decorateStyleOfBT(title:"更改成功", textColor: deselectColor, textFont: 11,backGroundColor:.clear)
    addSubview(threeTwoBT)
    threeTwoBT.snp.makeConstraints { (make) in
      make.bottom.equalTo(self).offset(-5)
      make.left.equalTo(threeOneBT).offset(-15.ratioWidth)
      make.right.equalTo(threeOneBT).offset(15.ratioWidth)
      make.height.equalTo(20)
    }
    
  }
  
  
}

class AddVerifyTimeProgressForField: UIView, ProtocolBorderLineView {
  
  fileprivate var currentTF:UITextField!
  
  //ProtocolBorderLineView
  var borderLineColor:UIColor =  .textField
  var locationDirection:LineLocation = .All
  
  convenience init(imageName:String?,targetTextField:UITextField,getVerifyBT:UIButton,addProgess:UIView,backgroundColor:UIColor =  .backGround) {
    self.init(frame:CGRect.zero)
    self.backgroundColor = backgroundColor
    currentTF = targetTextField
    var textFieldXOffset:CGFloat = 10
    
    if imageName != nil {
      let image = UIImage(named: imageName!)
      if let imageH = image {
        textFieldXOffset = 28
        let imageV = UIImageView()
        addSubview(imageV)
        imageV.image = imageH
        imageV.snp.makeConstraints { (make) in
          make.centerX.equalTo(self.snp.left).offset(14)
          make.centerY.equalTo(self)
          make.width.equalTo(imageH.width)
          make.height.equalTo(imageH.height)
        }
      }
    }
    addSubview(addProgess)
    addProgess.snp.makeConstraints { (make) in
      make.right.equalTo(self).offset(-23)
      make.centerY.equalTo(self.snp.centerY)
      make.width.height.equalTo(35)
    }
    
    addSubview(getVerifyBT)
    getVerifyBT.snp.makeConstraints { (make) in
      make.right.equalTo(self).offset(-2)
      make.width.equalTo(80)
      make.top.equalTo(self).offset(2)
      make.bottom.equalTo(-2)
    }
    
    //线
    let line = UIView()
    line.backgroundColor =  .textField
    addSubview(line)
    line.snp.makeConstraints { (make) in
      make.right.equalTo(getVerifyBT.snp.left)
      make.top.bottom.equalTo(self)
      make.width.equalTo(0.5)
    }
    
    
    let secureTextEntry = targetTextField.isSecureTextEntry
    addSubview(targetTextField)
    targetTextField.snp.makeConstraints { (make) in
      make.left.equalTo(textFieldXOffset)
      make.top.equalTo(self).offset(1)
      make.bottom.equalTo(self).offset(-1)
      if secureTextEntry {
        make.right.equalTo(line.snp.left).offset(-31) // 30+1
      }else {
        make.right.equalTo(line.snp.left).offset(-1)
      }
    }
    
    if secureTextEntry {
      //密码是否可见 --默认为密码不可见
      let rightbtn = UIButton(type: .custom)
      addSubview(rightbtn)
      rightbtn.setImage(UIImage(named: "close-eye"), for: UIControlState())
      rightbtn.addTarget(self, action: #selector(showPassWord), for: .touchUpInside)
      rightbtn.snp.makeConstraints({ (make) in
        make.top.bottom.equalTo(self)
        make.width.equalTo(30)
        make.right.equalTo(-1)
      })
    }
    
    
  }
  
  
  @objc func showPassWord(_ btn:UIButton) {
    if btn.isSelected {
      btn.setImage(UIImage(named: "open-eye"), for: UIControlState())
      currentTF.isSecureTextEntry = false
      btn.isSelected = false
    }else {
      btn.setImage(UIImage(named: "close-eye"), for: UIControlState())
      currentTF.isSecureTextEntry = true
      btn.isSelected = true
    }
  }
  
  override func draw(_ rect: CGRect) {
    drawInRect(rect)
    self.backgroundColor = UIColor.white
  }
  
  fileprivate override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
