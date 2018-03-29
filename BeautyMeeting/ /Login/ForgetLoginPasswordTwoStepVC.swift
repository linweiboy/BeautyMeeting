//
//  ForgetLoginPasswordTwoStepVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class ForgetLoginPasswordTwoStepVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {

  var phoneNumber:String!
  var verityNumber:String!
  
  fileprivate let onePasswordTF = UITextField()
  fileprivate let twoPasswordTF = UITextField()
  fileprivate let confireBT = RoundCornerBT.unifyConfirmBT(title: "确认")
  fileprivate let passwordDelegate = TextFieldInputDelegate(type: .loginPassword)
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "重置登录密码"
    popLastPage()
    defaultConfig()
    addShowViews()
  }
  
  //MARK: 点击事件
  @objc func nextStepBTClick() {
    guard let pas = checkPassword(passwordTF: onePasswordTF, target: self) else {
      return
    }
    guard onePasswordTF.text == twoPasswordTF.text else {
      showMessage("两次输入的密码不一致！")
      return
    }
    
    showLoadingView(nil)
    UserRequest.userResetLoginPassword(phoneNumber, code: verityNumber, newPwd: pas) {[weak self] (result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success(let json):
        let model = CommonModel(json: json)
        if model.isSuccess {
          let com = ModifySucceedVC()
          com.modifyType = .modifyLoginPassword
          com.oneTitle = "恭喜您，新密码设置成功！"
          com.twoTitle = "请您牢记您的新密码"
          com.buttonTitle = "重新登录"
          strongSelf.pushTo(com)
        }else {
          strongSelf.showMessage(model.message)
        }
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
  }
  
  
  func addShowViews() {
    
    onePasswordTF.decorateStyleOfTF(placeholderTitle: "请输入6~16位密码",placeholderColor:  .garyTitleColor, keyboardType: .asciiCapable, borderStyle: .none, secureTextEntry: true, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    onePasswordTF.delegate = passwordDelegate
    let accountBackView = TitleTextFieldView(imageName: "passwordIcon", targetTextField: onePasswordTF)
    self.view.addSubview(accountBackView)
    accountBackView.snp.makeConstraints { (make) in
      make.top.equalTo(25)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    twoPasswordTF.decorateStyleOfTF(placeholderTitle: "确认密码",placeholderColor:  .garyTitleColor, keyboardType: .asciiCapable, borderStyle: .none, secureTextEntry: true, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    twoPasswordTF.delegate = passwordDelegate
    let verifyNumBackView = TitleTextFieldView(imageName: "passwordIcon", targetTextField: twoPasswordTF)
    self.view.addSubview(verifyNumBackView)
    verifyNumBackView.snp.makeConstraints { (make) in
      make.top.equalTo(accountBackView.snp.bottom).offset(15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(confireBT)
    confireBT.addTarget(self, action: #selector(nextStepBTClick), for: .touchUpInside)
    confireBT.snp.makeConstraints { (make) in
      make.top.equalTo(verifyNumBackView.snp.bottom).offset(25)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
  }
  
}
