//
//  NoLoginShowView.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/14.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class NoLoginShowView: UIView,ProtocolMaskShowView {
  
  var loginClosureClick:((_ tag:Int)->())?
  
  var maskAnimationView:UIView! = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let backIMV = UIImageView()
    backIMV.image = UIImage(named: "login_back")
    addSubview(backIMV)
    backIMV.snp.makeConstraints { (make) in
      make.center.equalTo(self)
      make.width.equalTo(frame.width)
      make.height.equalTo(frame.height)
    }
    
    let nologinIMV = UIImageView()
    let image = UIImage(named: "nologin")
    nologinIMV.image = image
    addSubview(nologinIMV)
    nologinIMV.snp.makeConstraints { (make) in
      make.top.equalTo(backIMV.snp.top).offset(15)
      make.centerX.equalTo(backIMV)
      make.width.equalTo((image?.width)!)
      make.height.equalTo((image?.height)!)
    }
    
    let titleLB = UILabel()
    titleLB.decorateStyleOfLB(title: "您还没有登录...", textColor: .white, textFont: 13.ratioHeight)
    addSubview(titleLB)
    titleLB.snp.makeConstraints { (make) in
      make.top.equalTo(nologinIMV.snp.bottom).offset(20)
      make.centerX.equalTo(nologinIMV)
    }
    
    let loginBT = UIButton(type: .custom)
    loginBT.tag = 10
    loginBT.layer.masksToBounds = true
    loginBT.layer.cornerRadius = 15
    loginBT.addTarget(self, action: #selector(btClick(_:)), for: .touchUpInside)
    loginBT.decorateStyleOfBT(title: "登录", textColor: UIColor.white, textFont: 12.ratioHeight, backGroundColor:   .orangeColor)
    addSubview(loginBT)
    loginBT.snp.makeConstraints { (make) in
      make.width.equalTo(120)
      make.height.equalTo(35)
      make.right.equalTo(backIMV.snp.right).offset(-18.ratioWidth)
      make.bottom.equalTo(backIMV.snp.bottom).offset(-18)
    }
    
    let registerBT = UIButton(type: .custom)
    registerBT.tag = 11
    registerBT.layer.masksToBounds = true
    registerBT.layer.cornerRadius = 15
    registerBT.addTarget(self, action: #selector(btClick(_:)), for: .touchUpInside)
    registerBT.decorateStyleOfBT(title: "注册", textColor: UIColor.white, textFont: 12.ratioHeight, backGroundColor:   .prittyBlue)
    addSubview(registerBT)
    registerBT.snp.makeConstraints { (make) in
      make.width.equalTo(loginBT)
      make.height.equalTo(loginBT)
      make.left.equalTo(backIMV.snp.left).offset(18.ratioHeight)
      make.bottom.equalTo(loginBT)
    }
  }
  
  
  @objc func btClick(_ bt:UIButton) {
    if loginClosureClick != nil {
      loginClosureClick!(bt.tag)
    }
    dismissView(nil)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
