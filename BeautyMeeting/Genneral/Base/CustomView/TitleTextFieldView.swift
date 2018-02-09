//
//  TitleTextFieldView.swift
//  RongTeng
//
//  Created by rongteng on 16/5/13.
//  Copyright © 2016年 Mike. All rights reserved.
//


class TitleTextFieldView: UIView,ProtocolBorderLineView {
  
  var currentTF:UITextField!
  var locationDirection: LineLocation = .All
  var borderLineColor:UIColor =  .textField
  var borderLineWidth:CGFloat = 0.5
  
  //没什么开头的
  convenience init(targetTextField:UITextField) {
    self.init(frame:.zero)
    self.backgroundColor = .white
    addSubview(targetTextField)
    targetTextField.snp.makeConstraints { (make) in
      let offet = UIEdgeInsets(top: borderLineWidth, left: 5, bottom: borderLineWidth, right: borderLineWidth)
      make.edges.equalTo(offet)
    }
  }
  
  ///文字开头的输入框
  convenience init(title:String,targetTextField:UITextField) {
    self.init(frame:.zero)
    currentTF = targetTextField
    
    let titleLB = UILabel()
    addSubview(titleLB)
    titleLB.sizeToFit()
    titleLB.snp.makeConstraints { (make) in
      make.left.equalTo(self)
      make.top.equalTo(self)
      make.bottom.equalTo(self).offset(-1)
    }
    addSubview(targetTextField)
    targetTextField.snp.makeConstraints { (make) in
      make.left.equalTo(80)
      make.top.equalTo(self)
      make.bottom.equalTo(self).offset(1)
      make.right.equalTo(self)
    }
    
  }
  
  ///图片开头的输入框
  convenience init(imageName:String?,targetTextField:UITextField,
                   backgroundColor:UIColor =  .backGround) {
    self.init(frame:.zero)
    
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
    
    let secureTextEntry = targetTextField.isSecureTextEntry
    
    addSubview(targetTextField)
    targetTextField.snp.makeConstraints { (make) in
      make.left.equalTo(textFieldXOffset)
      make.top.equalTo(self).offset(1)
      make.bottom.equalTo(self).offset(-1)
      if secureTextEntry {
        make.right.equalTo(self).offset(-31) // 30+1
      }else {
        make.right.equalTo(self).offset(-1)
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
        make.width.equalTo(35)
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
  }
  
}
