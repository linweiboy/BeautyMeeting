//
//  ModifyPhoneNumVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/5.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class ModifyPhoneNumVC: UIViewController,PopVCSetProtocol,VcDefaultConfigProtocol,LoadingPresenterProtocol {
  
  var updataClickSendSoure:(()->())?
  
  fileprivate let currentUserPhoneNumLB = UILabel()
  fileprivate let verifyInputTF = UITextField()
  fileprivate var currentUser:UserAccount!
  //20秒后出现这个视图
  fileprivate let notReceiveBackView = AchieveVoiceVerifyNumView()
  //倒计时进度视图
  fileprivate let progressView = CountDownView(frame: CGRect(x: 0, y: 0, width: 35, height: 35), lineWidth: 2, progressColor:.prittyBlue, textColor: .textBlackColor, timeDuration: 1.0, timeInPut: 60 )
  fileprivate let countDownBT = UIButton(type: .custom)//重获验证码
  fileprivate let finishBT = RoundCornerBT.unifyConfirmBT(title: "下一步")
    
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "更换手机号码"
//    guard let user = AccountManage.shared.currentAccount() else {return}
//    currentUser = user
    popLastPage()
    defaultConfig()
    addShowViews()
  }
  
  
  //获取验证码
  @objc func entryCountDownClick() {
    if progressView.isCountingDown != true {
      progressView.startCountDown()
    }
//    currentUser.mobile
    UserRequest.userGetVerifyCode("1300002827",operate: "更换手机号码", voice: BoolParameter.VoiceFalse) {[weak self] (result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success:
        strongSelf.showMessage("短信验证码发送成功！")
      case .failure(let error):
        strongSelf.progressView.stopCountDown()
        strongSelf.showMessage(error.reason)
      }
    }
  }
  
  //下一步
  @objc func finishBTClick() {
    guard checkVerifyNum(verifyTF:verifyInputTF,target: self) != nil else {
      return
    }

    let vc = ModifyPhoneNumTwoStepVC()
    vc.oldPhoneVerifyNum = verifyInputTF.text!
    vc.updataClickSoure = { [unowned self] in
      if self.updataClickSendSoure != nil {
        self.updataClickSendSoure!()
      }
    }
    self.pushTo(vc)
//    UserRequest.checkVerifOn(currentUser.mobile, verifyNo: verifyStr) {[weak self] result in
//      guard let strongSelf = self else {return}
//      strongSelf.hiddenLoadingView()
//      switch result {
//      case .success:
//        let vc = ModifyPhoneNumTwoStepVC()
//        vc.oldPhoneVerifyNum = strongSelf.verifyInputTF.text!
//        vc.updataClickSoure = { [unowned strongSelf] in
//          if strongSelf.updataClickSendSoure != nil {
//            strongSelf.updataClickSendSoure!()
//          }
//        }
//        strongSelf.pushTo(vc)
//      case .failure(let error):
//        strongSelf.showMessage(error.reason)
//      }
//    }
    
  }
  
  //发送语音验证码
  func oneNotReceiveVerifyNumBTClick() {
    UserRequest.userGetVerifyCode(currentUser.mobile,operate: "更换手机号码", voice: BoolParameter.VoiceTrue){ [weak self] result in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success:
        strongSelf.showMessage("请接听021-31590966来电获得验证码")
      case .failure(let error):
        strongSelf.showMessage(error.reason)
        strongSelf.progressView.stopCountDown()
      }
    }
  }
}


extension ModifyPhoneNumVC {
  
  func addShowViews() {
    let headView = ModifyPhoneNumHeadView(selectedIndex: 0)
    self.view.addSubview(headView)
    headView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(45)
    }
    
    //currentUser.mobileValue
    self.view.addSubview(currentUserPhoneNumLB)
    currentUserPhoneNumLB.decorateStyleOfLB(title: "13000002827", textColor:   .prittyBlue, textFont: 12)
    currentUserPhoneNumLB.snp.makeConstraints { (make) in
      make.top.equalTo(headView.snp.bottom).offset(24)
      make.left.equalTo(15)
      make.right.equalTo(-8)
      make.height.equalTo(15)
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
    
    let co = UIColor(hexStr: "#374457")
    countDownBT.decorateStyleOfBT(title:"获取验证码", textColor:co, textFont: 11, backGroundColor: .backGround)
    countDownBT.addTarget(self, action: #selector(entryCountDownClick), for: .touchUpInside)
    verifyInputTF.decorateStyleOfTF(placeholderTitle: "请输入手机验证码", placeholderColor:  .garyTitleColor,keyboardType: .default, borderStyle: .none, secureTextEntry: false, textColor: .textBlackColor, textFont: FontDefine.twelve)
    let userNameBackView = AddVerifyTimeProgressForField(imageName: "messageIcon", targetTextField: verifyInputTF, getVerifyBT: countDownBT, addProgess: progressView)
    self.view.addSubview(userNameBackView)
    userNameBackView.snp.makeConstraints { (make) in
      make.top.equalTo(currentUserPhoneNumLB.snp.bottom)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(notReceiveBackView)
    notReceiveBackView.achieveVerifyNumClosure = { [unowned self] in
      self.oneNotReceiveVerifyNumBTClick()
    }
    notReceiveBackView.isHidden = true
    notReceiveBackView.backgroundColor = self.view.backgroundColor
    notReceiveBackView.snp.makeConstraints { (make) in
      make.top.equalTo(userNameBackView.snp.bottom)
      make.left.equalTo(self.view)
      make.right.equalTo(countDownBT.snp.right)
      make.height.equalTo(20)
    }
    
    self.view.addSubview(finishBT)
    finishBT.addTarget(self, action: #selector(finishBTClick), for: .touchUpInside)
    finishBT.snp.makeConstraints { (make) in
      make.top.equalTo(userNameBackView.snp.bottom).offset(30)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    let noteView = CozyNoteView(oneTitle: "温馨提示", middleImageName: "", twoTitle: "如原手机号已停机或已换号，请联系客服热线", canClickThreeTitle: CustomerService)
    self.view.addSubview(noteView)
    noteView.snp.makeConstraints { (make) in
      make.top.equalTo(finishBT.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(100)
    }
    
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    progressView.cancelTimer()
  }
}

























