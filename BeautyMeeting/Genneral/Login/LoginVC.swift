//
//  LoginVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//


enum LoginActionType:String {
  case Normal
  case GesturePasswordForgetPSOrSwitchAccount
}

class LoginVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  var loginActionType:LoginActionType = .Normal
  var loginSucceedClosure:(()->())? //登陆成功后的回调
  
  fileprivate let bannarIM = UIImageView()
  fileprivate let accountNameTF = UITextField()
  fileprivate let passwordTF = UITextField()
  fileprivate weak var passwordDelegate = TextFieldInputDelegate(type: .loginPassword)
  fileprivate let loginBT = RoundCornerBT.unifyConfirmBT(title: "登录")
  fileprivate let registerBT = UIButton(type: .custom)
  fileprivate let saveAccountBT = UIButton(type: .custom) //是否保存账号
    
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "登录"
    dismissCurrentPage()
    defaultConfig()
    addShowViews()
  }
  
  func addShowViews() {
    
    self.view.addSubview(bannarIM)
    let bannarImage = UIImage(named:"register-defaultBanner")!
    bannarIM.image = bannarImage
    bannarIM.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(bannarImage.ratioHeight)
    }
    
    accountNameTF.decorateStyleOfTF(placeholderTitle: "请输入手机号码/用户名",placeholderColor:  .garyTitleColor, keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor:.textBlackColor, textFont: FontDefine.twelve)
    let saveAccountNum = AccountManage.achieveUserAccountNumber()
    if saveAccountNum != nil {
      accountNameTF.text = saveAccountNum!
    }
    accountNameTF.backgroundColor =  .backGround
    let accountBackView = TitleTextFieldView(imageName: "phoneIcon", targetTextField: accountNameTF)
    self.view.addSubview(accountBackView)
    accountBackView.snp.makeConstraints { (make) in
      make.top.equalTo(bannarIM.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    passwordTF.decorateStyleOfTF(placeholderTitle: "请输入登录密码", placeholderColor:  .garyTitleColor, keyboardType: .asciiCapable, borderStyle: .none, secureTextEntry: true, textColor:.textBlackColor, textFont: FontDefine.twelve)
    passwordTF.backgroundColor = .backGround
    let passwordBackView = TitleTextFieldView(imageName: "passwordIcon", targetTextField: passwordTF)
    passwordTF.delegate = passwordDelegate
    self.view.addSubview(passwordBackView)
    passwordBackView.snp.makeConstraints { (make) in
      make.top.equalTo(accountBackView.snp.bottom).offset(5)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(saveAccountBT)
    let saveAccountBTTitle = "记住账号"
    saveAccountBT.decorateStyleOfBT(title:saveAccountBTTitle, textColor:.textField, textFont: 12.ratioHeight,backGroundColor:.backGround)
    saveAccountBT.isSelected = true
    saveAccountBT.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
    saveAccountBT.setImage(UIImage(named: "saveAccount_selected"), for: .selected)
    saveAccountBT.setImage(UIImage(named: "saveAccount"), for: UIControlState())
    saveAccountBT.addTarget(self, action: #selector(saveAccountBTClick), for: .touchUpInside)
    saveAccountBT.snp.makeConstraints { (make) in
      make.top.equalTo(passwordBackView.snp.bottom)
      make.left.equalTo(passwordBackView)
      make.height.equalTo(35)
      make.width.equalTo(saveAccountBTTitle.getWidth(maxWidth: ScreenWidth/2, font: 12.ratioHeight)+20)
    }
    
    let forgetPasswordBT = UIButton(type: .custom)
    self.view.addSubview(forgetPasswordBT)
    let forgetPasswordBTTitle = "忘记密码？"
    forgetPasswordBT.decorateStyleOfBT(title:forgetPasswordBTTitle, textColor:   .textRed, textFont: 12.ratioHeight,backGroundColor:.backGround)
    forgetPasswordBT.addTarget(self, action: #selector(forgetPasswordClick), for: .touchUpInside)
    let forgetPasswordBTHeight = forgetPasswordBTTitle.getWidth(maxWidth: ScreenWidth/2, font: 12.ratioHeight)
    forgetPasswordBT.snp.makeConstraints { (make) in
      make.top.equalTo(passwordBackView.snp.bottom)
      make.right.equalTo(passwordBackView)
      make.height.equalTo(35)
      make.width.equalTo(forgetPasswordBTHeight)
    }
    
    self.view.addSubview(loginBT)
    loginBT.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
    loginBT.snp.makeConstraints { (make) in
      make.top.equalTo(passwordBackView.snp.bottom).offset(40)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    
//    if let source = AchieveSource.shared.unifySource {
      self.view.addSubview(registerBT)
      let color = UIColor.rgbValue(red: 255, green: 127, blue: 0)
      let oneAttDic = [NSAttributedStringKey.underlineStyle:NSUnderlineStyle.styleSingle.rawValue,
                       NSAttributedStringKey.underlineColor:color,
                       NSAttributedStringKey.foregroundColor:color] as [NSAttributedStringKey : Any]
      let oneAtt = NSAttributedString(string: "注册有奖", attributes: oneAttDic)
      registerBT.setAttributedTitle(oneAtt, for: .normal)
      registerBT.addTarget(self, action: #selector(registerClick), for: .touchUpInside)
      registerBT.snp.makeConstraints { (make) in
        make.top.equalTo(loginBT.snp.bottom).offset(25)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(CGDefine.height.maxButton)
      }
//    }
   
  }
  
}

//MARK: -点击事件
extension LoginVC {
  
  //登录
  @objc func loginClick() {
    guard !accountNameTF.isEmpty else {
      showMessage("用户名不能为空！")
      accountNameTF.becomeFirstResponder()
      return
    }
    guard RegularManage.whetherIsRightPassword(passwordTF.text!) else {
      showMessage("登录密码应为6~16位！")
      passwordTF.becomeFirstResponder()
      return
    }
    showLoadingView(nil)
    UserRequest.userLogin(accountNameTF.text!, password: passwordTF.text!, ct: .IOS) { [weak self](result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success(let data):
        strongSelf.handleSuccess(resultJson:data)
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
    
  }
  
  func handleSuccess(resultJson:JSON) {
    let account = UserAccount(json: resultJson["data"])
    //如果是手势密码页面的忘记密码和切换账号进来的
    if self.loginActionType == .GesturePasswordForgetPSOrSwitchAccount {
      let account = AccountManage.shared.currentAccount()!
      //如果是同一个账号 就把这个账号的手势密码清除掉
      if account.mobile == account.mobile {
        GesturePasswordManage.removePasswordWithKey(account.mobile)
      }
    }
    
    AccountManage.shared.saveAccount(account)
    
    if self.saveAccountBT.isSelected {
      AccountManage.saveUserAccountNumber(self.accountNameTF.text!)
    }else {
      AccountManage.removeUserAccountNumber()
    }
    if self.loginSucceedClosure != nil {
      self.loginSucceedClosure!()
    }
    
    //初始化融云SDK
    RCDataSourceHelper.shared.connectRongCloud(token: account.accessToken)
    
    dismissSelf()
  }
  
  //忘记登录密码
  @objc func forgetPasswordClick() {
    let forgetLoginPSVC = ForgetLoginPasswordVC()
    pushTo(forgetLoginPSVC)
  }
  
  //去注册
  @objc func registerClick() {
    let regisVC = RegisterVC()
    regisVC.entryRegisterVCType = .push
    pushTo(regisVC)
  }
  
  //是否保存账号
  @objc func saveAccountBTClick(_ bt:UIButton) {
    bt.isSelected = !bt.isSelected
  }
  
}
