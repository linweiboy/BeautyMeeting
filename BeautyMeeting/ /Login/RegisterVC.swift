//
//  RegisterVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//


enum RegisterVCEntryType:String {
  case push
  case present
}

fileprivate typealias CustomerProtocol = VcDefaultConfigProtocol & PopVCSetProtocol & LoadingPresenterProtocol

class RegisterVC: UIViewController,CustomerProtocol {

  var entryRegisterVCType:RegisterVCEntryType!
  
  fileprivate let bannarImageV = UIImageView()
  fileprivate let phoneNumTF = UITextField()
  fileprivate let passwordTF = UITextField()
  fileprivate let nextStepBT = RoundCornerBT.unifyConfirmBT(title: "下一步")
  fileprivate let goLoginBT = UIButton(type: .custom)
  fileprivate let phoneNumDelegate = TextFieldInputDelegate(type: .phoneNumber)
  fileprivate let loginPSDelegate = TextFieldInputDelegate(type: .loginPassword)
  fileprivate var bannarUrl:String? {
    didSet {
      self.bannarImageV.kf.setImage(with: URL(string:bannarUrl!) , placeholder: UIImage(named: "register-defaultBanner"))
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "注册"
    defaultConfig()
    if entryRegisterVCType == .push   {
      popLastPage()
    }
    if entryRegisterVCType == .present   {
      dismissCurrentPage()
    }
    addShowViews()
//    achieveBannarData()
  }
//
//  func achieveBannarData() {
//    CommonRequest.commonBannar(.Register) {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      switch result {
//      case .success(let json):
//        let resultArray = BannarModel.parseListForData(json)
//        if resultArray.count != 0 {
//          strongSelf.bannarUrl = resultArray.first?.imgUrl
//        }
//      default:break
//      }
//    }
//  }
  
  //MARK:- 点击事件
  
  //注册下一步
  @objc func nextStepClick() {
    guard let phone = checkPhoneNum(phoneNumTF: phoneNumTF, target: self) else {
      return
    }
    guard let pas = checkPassword(passwordTF: passwordTF, target: self) else {
      return
    }
    
    showLoadingView(nil)
    UserRequest.userRegisterCheckMobile(phone) {[weak self] (result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success(let json):
        let result = json["data"]["isReg"].boolValue
        if result {
          strongSelf.showMessage("该号码已经注册！")
        }else {
          let twoStep = RegisterTwoStepVC()
          twoStep.imageUrl = strongSelf.bannarUrl
          twoStep.userPhone = phone
          twoStep.userPassword = pas
          strongSelf.pushTo(twoStep)
        }
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
  }
  
  //去登录  只有当 present进来时能响应这个方法
  @objc func goLoginBTClick() {
    
    if entryRegisterVCType == .push   {
      popToLastVC()
    }
  }
  
  func addShowViews() {
    self.view.addSubview(bannarImageV)
    bannarImageV.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(100.ratioHeight)
    }
    
    phoneNumTF.decorateStyleOfTF(placeholderTitle: "请输入手机号码",placeholderColor:.garyTitleColor, keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:.textBlackColor, textFont: FontDefine.twelve)
    phoneNumTF.delegate = phoneNumDelegate
    let phoneNumBackView = TitleTextFieldView(imageName: "phoneIcon", targetTextField: phoneNumTF)
    self.view.addSubview(phoneNumBackView)
    phoneNumBackView.snp.makeConstraints { (make) in
      make.top.equalTo(bannarImageV.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    passwordTF.decorateStyleOfTF(placeholderTitle: "请设置6~16位密码", placeholderColor:  .garyTitleColor,keyboardType: .asciiCapable, borderStyle: .none, secureTextEntry: true, textColor:.textBlackColor, textFont: FontDefine.twelve)
    passwordTF.delegate = loginPSDelegate
    let passwordBackView = TitleTextFieldView(imageName: "passwordIcon", targetTextField: passwordTF)
    self.view.addSubview(passwordBackView)
    passwordBackView.snp.makeConstraints { (make) in
      make.top.equalTo(phoneNumBackView.snp.bottom).offset(5)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(nextStepBT)
    nextStepBT.addTarget(self, action: #selector(nextStepClick), for: .touchUpInside)
    nextStepBT.snp.makeConstraints { (make) in
      make.top.equalTo(passwordBackView.snp.bottom).offset(10.ratioHeight)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    self.view.addSubview(goLoginBT)
    goLoginBT.decorateStyleOfBT(title:"已有账号登录", textColor:   .prittyBlue, textFont: (FontDefine.twelve),backGroundColor:.backGround)
    goLoginBT.addTarget(self, action: #selector(goLoginBTClick), for: .touchUpInside)
    goLoginBT.snp.makeConstraints { (make) in
      make.top.equalTo(nextStepBT.snp.bottom).offset(20)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
  }
  
  
  
}
