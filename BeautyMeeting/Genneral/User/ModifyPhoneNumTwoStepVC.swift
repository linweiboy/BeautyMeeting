//
//  ModifyPhoneNumTwoStepVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/6.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//修改手机号码 第二步
class ModifyPhoneNumTwoStepVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  var oldPhoneVerifyNum:String!
  var updataClickSoure:(()->())?
  
  fileprivate let phoneNumTF = UITextField()
  fileprivate let verifyNumTF = UITextField()
  fileprivate let phoneNumDelegate = TextFieldInputDelegate(type: TextFieldInputType.phoneNumber)
  fileprivate let nextStepBT = RoundCornerBT.unifyConfirmBT(title: "确认更换")
  fileprivate let notReceiveBackView = AchieveVoiceVerifyNumView() //20秒后出现这个视图
  //倒计时进度视图
  fileprivate let progressView = CountDownView(frame: CGRect(x: 0, y: 0, width: 35, height: 35), lineWidth: 2, progressColor:.prittyBlue, textColor:.textBlackColor, timeDuration: 1.0, timeInPut: 60 )
  fileprivate let countDownBT = UIButton(type: .custom)//重获验证码
  fileprivate var currentUser:UserAccount!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "修改手机号码"
//    guard let user = AccountManage.shared.currentAccount() else {return}
//    currentUser = user
    popLastPage()
    defaultConfig()
    addShowViews()
  }
  
  
  //MARK: -UITextField值改变
  @objc func tfValueChange() {
//    guard phoneNumTF.text != currentUser.mobile else {
//      showMessage("该手机号已被使用")
//      return
//    }
//    let phoneNum = phoneNumTF.text ?? ""
//    let verifyNum = verifyNumTF.text ?? ""
//    nextStepBT.isEnabled = !phoneNum.isEmpty && !verifyNum.isEmpty
  }
  
  
  //MARK: 点击事件
  @objc func nextStepBTClick() {
    guard let phoneStr = checkPhoneNum(phoneNumTF: phoneNumTF, target: self) else {
      return
    }
    guard let verifyStr = checkVerifyNum(verifyTF: verifyNumTF, target: self) else {
      return
    }
  }
  
  //提交修改手机号码请求
  func userModileCharger() {
    showLoadingView(nil)
    UserRequest.userModifyUserPhoneNumber(oldPhoneVerifyNum, mobile: phoneNumTF.text!, verifyNo: verifyNumTF.text!) { [weak self] (result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success:
        handelResult()
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
    
    func handelResult() {
      //重新保存本地用户名
      let account = UserAccount(username: currentUser.head_img_url, accessToken:currentUser.accessToken, mobile: phoneNumTF.text!,id:currentUser.id,role:currentUser.role)
      AccountManage.shared.saveAccount(account)
      
      updataClickSoure?()
      
      let com = ModifySucceedVC()
      com.modifyType = .modifyPhoneNumber
      com.oneTitle = self.phoneNumTF.text!
      com.twoTitle = "恭喜您，手机号更换成功！"
      com.buttonTitle = "进入账户中心"
      pushTo(com)
    }
    
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
//    showLoadingView(nil)
//    UserRequest.userGetVerifyCode(phoneStr,operate: "更换手机号码", voice: BoolParameter.VoiceFalse) {[weak self] result in
//      guard let strongSelf = self else {return}
//      strongSelf.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        let model = CommonModel(json: json)
//        if model.isSuccess {
//          strongSelf.showMessage("短信验证码发送成功！")
//        }
//      case .failure(let error):
//        strongSelf.progressView.stopCountDown()
//        strongSelf.showMessage(error.reason)
//      }
//    }
  }
  
  func addShowViews() {
    let headView = ModifyPhoneNumHeadView(selectedIndex: 1)
    self.view.addSubview(headView)
    headView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(45)
    }
    
    phoneNumTF.decorateStyleOfTF(placeholderTitle: "请输入手机号码", placeholderColor:  .garyTitleColor,keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    phoneNumTF.addTarget(self, action: #selector(tfValueChange), for: .editingChanged)
    phoneNumTF.delegate = phoneNumDelegate
    let accountBackView = TitleTextFieldView(imageName: "phoneIcon", targetTextField: phoneNumTF)
    self.view.addSubview(accountBackView)
    accountBackView.snp.makeConstraints { (make) in
      make.top.equalTo(headView.snp.bottom).offset(25)
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
    verifyNumTF.addTarget(self, action: #selector(tfValueChange), for: .editingChanged)
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
      make.top.equalTo(verifyNumBackView.snp.bottom).offset(45)
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
