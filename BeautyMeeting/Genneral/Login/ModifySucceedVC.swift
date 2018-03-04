//
//  ModifySucceedVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/6.
//  Copyright © 2016年 rongteng. All rights reserved.
//

enum ModifySucceedType:String {
  case modifyLoginPassword
  case modifyPhoneNumber
}

class ModifySucceedVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol {
  
  var modifyType:ModifySucceedType!
  var oneTitle:String!
  var twoTitle:String!
  var buttonTitle:String!
  
  fileprivate let confireBT = UIButton(type: .custom)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    defaultConfig()
    switch modifyType! {
    case .modifyLoginPassword:
      popRootPage()
      navigationItem.title = "登录密码修改成功"
    case .modifyPhoneNumber:
      popToPageWithCustomSelector(#selector(nextStepBTClick))
      navigationItem.title = "手机号码修改成功"
    }
    addShowViews()
  }
  
  @objc func nextStepBTClick() {
    switch modifyType! {
    case .modifyLoginPassword:
      popToRootVC()
    case .modifyPhoneNumber:
      popToVCAtIndex(1)
    }
  }
  
}

extension ModifySucceedVC {
  
  func addShowViews() {
    let image = UIImage(named: "succeed")
    let imageV = UIImageView(image: image)
    self.view.addSubview(imageV)
    imageV.snp.makeConstraints { (make) in
      make.width.equalTo(43)
      make.height.equalTo(30)
      make.centerX.equalTo(self.view)
      make.top.equalTo(40)
    }
    
    let oneNoteLB = UILabel()
    self.view.addSubview(oneNoteLB)
    oneNoteLB.decorateStyleOfLB(title: oneTitle, textColor: UIColor.rgbValue(red: 255, green: 127, blue: 0), textFont: 15, textAlignment: .center)
    oneNoteLB.snp.makeConstraints { (make) in
      make.top.equalTo(imageV.snp.bottom).offset(10)
      make.centerX.equalTo(self.view)
    }
    
    let twoNoteLB = UILabel()
    self.view.addSubview(twoNoteLB)
    twoNoteLB.decorateStyleOfLB(title: twoTitle, textColor: UIColor.rgbValue(red: 255, green: 127, blue: 0), textFont: 12, textAlignment: .center)
    twoNoteLB.snp.makeConstraints { (make) in
      make.top.equalTo(oneNoteLB.snp.bottom).offset(10)
      make.centerX.equalTo(self.view)
    }
    
    self.view.addSubview(confireBT)
    confireBT.decorateStyleOfBT(title:buttonTitle, textColor: UIColor.white, textFont: FontDefine.fifteen, backGroundColor:   .prittyBlue)
    confireBT.addTarget(self, action: #selector(nextStepBTClick), for: .touchUpInside)
    confireBT.snp.makeConstraints { (make) in
      make.top.equalTo(twoNoteLB.snp.bottom).offset(30)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
  }
  
}
