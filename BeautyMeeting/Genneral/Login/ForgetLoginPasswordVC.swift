//
//  ForgetLoginPasswordVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class ForgetLoginPasswordVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {

  fileprivate let phoneNumTF = UITextField()
  fileprivate let verifyNumTF = UITextField()
  fileprivate let nextStepBT = RoundCornerBT.unifyConfirmBT(title: "下一步")
  fileprivate let notReceiveBackView = AchieveVoiceVerifyNumView() //20秒后出现这个视图
  fileprivate let phoneNumTFDelegate = TextFieldInputDelegate(type: .phoneNumber)
  //倒计时进度视图
  fileprivate let progressView = CountDownView(frame: CGRect(x: 0, y: 0, width: 35, height: 35), lineWidth: 2, progressColor:.prittyBlue, textColor:.textBlackColor, timeDuration: 1.0, timeInPut: 60 )
  fileprivate let countDownBT = UIButton(type: .custom)//重获验证码
    
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "忘记登录密码"
    popLastPage()
    defaultConfig()
    addShowViews()
  }
  
  //MARK: 点击事件
  @objc func nextStepBTClick() {
    
    guard RegularManage.isPhoneNumber(phoneNumTF.text!)  else {
      showMessage("请输入正确格式的手机号码！")
      return
    }
    
    guard RegularManage.whetherIsRightVerifyNum(verifyNumTF.text!) else {
      showMessage("请输入正确格式的验证码!")
      return
    }
//    //校验验证码是否正确
//    UserRequest.checkVerifOn(phoneNumTF.text!, verifyNo: verifyNumTF.text!) {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      strongSelf.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        let model = CommonModel(json: json)
//        if model.isSuccess {
//          let twoStepVC = ForgetLoginPasswordTwoStepVC()
//          twoStepVC.phoneNumber = strongSelf.phoneNumTF.text
//          twoStepVC.verityNumber = strongSelf.verifyNumTF.text
//          strongSelf.pushTo(twoStepVC)
//        }else{
//          strongSelf.showMessage(model.message)
//        }
//      case .failure(let error):
//        strongSelf.showMessage(error.reason)
//      }
//    }
  }
  
  //发送验证码倒计时
  @objc func entryCountDownClick(_ bt:UIButton) {
    
    guard let phoneStr = checkPhoneNum(phoneNumTF: phoneNumTF, target: self) else {
      return
    }
    
    bt.isUserInteractionEnabled = false
    if progressView.isCountingDown != true {
      progressView.startCountDown()
    }
    
  }

  
  
  
  func addShowViews() {
    
    phoneNumTF.decorateStyleOfTF(placeholderTitle: "请输入手机号码", placeholderColor:  .garyTitleColor,keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    phoneNumTF.delegate = phoneNumTFDelegate
    let accountBackView = TitleTextFieldView(imageName: "phoneIcon", targetTextField: phoneNumTF)
    self.view.addSubview(accountBackView)
    accountBackView.snp.makeConstraints { (make) in
      make.top.equalTo(25)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    //获取验证码
    progressView.countDownStartClosure = {[unowned self] in
      self.countDownBT.isUserInteractionEnabled = false
      self.countDownBT.isHidden = true
    }
    progressView.countDownCompleteClosure = {[weak self] in
      guard let strongSelf = self else {return}
      strongSelf.countDownBT.isHidden = false
      strongSelf.countDownBT.setTitle("重获验证码", for: .normal)
      strongSelf.countDownBT.isUserInteractionEnabled = true
    }
    progressView.sendSecondsClosure = { [unowned self] in
      self.notReceiveBackView.isHidden = false
    }
    countDownBT.decorateStyleOfBT(title:"获取验证码", textColor: UIColor.rgbValue(red: 55, green: 68, blue: 87), textFont: 11, backGroundColor:  .backGround)
    countDownBT.addTarget(self, action: #selector(entryCountDownClick), for: .touchUpInside)
    
    verifyNumTF.decorateStyleOfTF(placeholderTitle: "请输入短信验证码",placeholderColor:  .garyTitleColor, keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    let verifyNumBackView = AddVerifyTimeProgressForField(imageName: "messageIcon", targetTextField: verifyNumTF, getVerifyBT: countDownBT, addProgess: progressView)
    self.view.addSubview(verifyNumBackView)
    verifyNumBackView.snp.makeConstraints { (make) in
      make.top.equalTo(accountBackView.snp.bottom).offset(15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    self.view.addSubview(notReceiveBackView)
    notReceiveBackView.isHidden = true
    notReceiveBackView.backgroundColor = self.view.backgroundColor
    notReceiveBackView.snp.makeConstraints { (make) in
      make.top.equalTo(verifyNumBackView.snp.bottom)
      make.left.equalTo(self.view)
      make.right.equalTo(countDownBT.snp.right)
      make.height.equalTo(20)
    }
    
    //255 127 0  进度
    self.view.addSubview(nextStepBT)
    nextStepBT.addTarget(self, action: #selector(nextStepBTClick), for: .touchUpInside)
    nextStepBT.snp.makeConstraints { (make) in
      make.top.equalTo(verifyNumBackView.snp.bottom).offset(25.ratioHeight)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    progressView.cancelTimer()
  }
  
  
}
