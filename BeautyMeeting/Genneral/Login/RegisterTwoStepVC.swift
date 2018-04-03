//
//  RegisterTwoStepVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class RegisterTwoStepVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {

  var imageUrl:String?
  var userPhone:String!
  var userPassword:String!
  
  fileprivate let bannarImageV = UIImageView()
  fileprivate let verifyNumTF = UITextField()
  fileprivate let inviteTF = UITextField()
  fileprivate let finishBT = RoundCornerBT.unifyConfirmBT(title: "完成")
  fileprivate let labelHeight:CGFloat = 15
  fileprivate var isShowInviteTF = false //当前是否显示了inviteTF
  fileprivate let finishBackView = UIView()
  fileprivate let showInviteInputBT = UIButton(type: .custom) //我有邀请码
  fileprivate let countDownBT = UIButton(type: .custom)//重获验证码
  fileprivate let notReceiveBackView = AchieveVoiceVerifyNumView() //20秒后出现这个视图
  
  //倒计时进度视图
  fileprivate let progressView = CountDownView(frame: CGRect(x: 0, y: 0, width: 35, height: 35), lineWidth: 2, progressColor:.prittyBlue, textColor:.textBlackColor, timeDuration: 1.0, timeInPut: 60 )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "注册"
    popLastPage()
    defaultConfig()
    addShowViews()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    progressView.cancelTimer()
  }
  
}

//MARK: -点击事件
extension  RegisterTwoStepVC {
  
  //完成
  @objc func finishBTClick() {
    
    guard RegularManage.whetherIsRightVerifyNum(verifyNumTF.text!) else {
      showMessage("请输入正确格式的验证码！")
      return
    }
    userRegisterNetWorking()
    //校验验证码是否正确
//    UserRequest.checkVerifOn(userPhone, verifyNo: verifyNumTF.text!) {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      strongSelf.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        let model = CommonModel(json: json)
//        if model.isSuccess {
//          strongSelf.userRegisterNetWorking()
//        }else {
//          strongSelf.showMessage(model.message)
//        }
//      case .failure(let error):
//        strongSelf.showMessage(error.reason)
//      }
//    }
  }
  
  //注册申请
  func userRegisterNetWorking(){
    showLoadingView(nil)
    var referrer:String? //如果输入了邀请码 就加上
    if isShowInviteTF && !inviteTF.isEmpty  {
      referrer = inviteTF.text
    }
    UserRequest.userRegister(userPhone, password: userPassword, verifyNo: verifyNumTF.text!, referrer: referrer) {[weak self] (result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success(let json):
        printLog(message: json)
        //保存用户信息
        let account = UserAccount(json: json["data"])
        AccountManage.shared.saveAccount(account)
        //界面消失
        strongSelf.dismissSelf()
        strongSelf.hidesBottomBarWhenPushed = false
        AppDelegate.shared.mainVC.selectedIndex = 0
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
    
  }
  
  //查看协议
  @objc func protocolBTClick(_ tag:Int) {
    switch tag {
    case 0:break
//      let vc = OpenUrlVC()
//      vc.loadUrl = XZGURL.h5.currentH5 + XZGURL.H5_registerAgreement
//      vc.navItemTitle = "小诸葛金服注册及服务协议"
//      pushTo(vc)
    case 1:break
//      let vc = OpenUrlVC()
//      vc.loadUrl = XZGURL.h5.currentH5 + XZGURL.H5_FengXian
//      pushTo(vc)
    default:break
    }
  }
  
  //收到不到短信验证码？
  @objc func twoNotReceiveVerifyNumBTClick() {
    let view = NotReceiveVerifyNumView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 270.ratioWidth, height: 250.ratioHeight)))
    view.btClickClosure = { AccessSystem.callTelephony(CustomerService) }
    view.showView()
  }
  
  //获取短信验证码
  @objc func entryCountDownClick(_ bt:UIButton) {
    if progressView.isCountingDown != true {
      progressView.startCountDown()
    }
//    UserRequest.userSendVerifyNumForLoginAndRegister(userPhone, voice: BoolParameter.VoiceFalse) {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      strongSelf.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        let isNewUser = json["data"]["isNewUser"].boolValue
//        if isNewUser {
//          strongSelf.showMessage("短信验证码发送成功！")
//        }else {
//          strongSelf.progressView.stopCountDown()
//          strongSelf.showMessage("该用户已注册！")
//        }
//      case .failure(let error):
//        strongSelf.showMessage(error.reason)
//        strongSelf.progressView.stopCountDown()
//      }
//    }
  }
  
  func whetherInviteTF() {
    showInviteInputBT.isUserInteractionEnabled = false
    isShowInviteTF = showInviteInputBT.isSelected
    if isShowInviteTF {
      finishBackView.snp.updateConstraints({ (make) in
        let offS = labelHeight+CGDefine.height.maxButton+5
        make.top.equalTo(showInviteInputBT.snp.bottom).offset(offS)
      })
    }else {
      finishBackView.snp.updateConstraints({ (make) in
        make.top.equalTo(showInviteInputBT.snp.bottom).offset(10)
      })
    }
    
    UIView.animate(withDuration: 0.5, animations: {
      self.view.layoutIfNeeded()
    }, completion: { (finish) in
      self.showInviteInputBT.isUserInteractionEnabled = true
    })
  }

}

extension RegisterTwoStepVC {
  
  func addShowViews() {
    self.view.addSubview(bannarImageV)
    if let url = self.imageUrl {
      bannarImageV.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "register-defaultBanner"))
    }
    bannarImageV.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(100.ratioHeight)
    }
    
    //获取验证码
    progressView.countDownStartClosure = {[unowned self] in
      self.countDownBT.isUserInteractionEnabled = false
      self.countDownBT.isHidden = true
    }
    progressView.countDownCompleteClosure = {[weak self] in
      guard let strongSelf = self else {return}
      strongSelf.countDownBT.isHidden = false
      strongSelf.countDownBT.setTitle("重新获取", for: .normal)
      strongSelf.countDownBT.isUserInteractionEnabled = true
    }
    progressView.sendSecondsClosure = { [unowned self] in
      self.notReceiveBackView.isHidden = false
    }
    
    countDownBT.decorateStyleOfBT(title:"获取验证码", textColor: UIColor.rgbValue(red: 55, green: 68, blue: 87), textFont: 11, backGroundColor:.backGround)
    countDownBT.addTarget(self, action: #selector(entryCountDownClick), for: .touchUpInside)
    
    verifyNumTF.decorateStyleOfTF(placeholderTitle: "请输入短信验证码", placeholderColor: .garyTitleColor,keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:.textBlackColor, textFont: FontDefine.twelve)
    let verifyNumBackView = AddVerifyTimeProgressForField(imageName: "messageIcon", targetTextField: verifyNumTF, getVerifyBT: countDownBT, addProgess: progressView)
    self.view.addSubview(verifyNumBackView)
    verifyNumBackView.snp.makeConstraints { (make) in
      make.top.equalTo(bannarImageV.snp.bottom).offset(15)
      make.left.equalTo(15)
      make.right.equalTo(-15) //15+70
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(notReceiveBackView)
    notReceiveBackView.isHidden = true
    notReceiveBackView.snp.makeConstraints { (make) in
      make.top.equalTo(verifyNumBackView.snp.bottom)
      make.left.equalTo(self.view)
      make.right.equalTo(countDownBT.snp.right)
      make.height.equalTo(20.ratioHeight)
    }
    
    let investNumView = HaveInvestPeopleBT(inviteInputBT: showInviteInputBT)
    self.view.addSubview(investNumView)
    investNumView.showInviteInputBTClickClosure = { [unowned self] in self.whetherInviteTF()
    }
    investNumView.snp.makeConstraints { (make) in
      make.top.equalTo(verifyNumBackView.snp.bottom).offset(20)
      make.left.equalTo(verifyNumBackView.snp.left)
      make.width.equalTo(90.ratioWidth)
      make.height.equalTo(25.ratioHeight)
    }
    
    inviteTF.decorateStyleOfTF(placeholderTitle: "邀请码/邀请人手机号码", placeholderColor: .garyTitleColor,keyboardType: .numberPad, borderStyle: .none, secureTextEntry: false, textColor:   .textBlackColor, textFont: FontDefine.twelve)
    let inviteTFBackView = TitleTextFieldView(imageName: nil, targetTextField: inviteTF)
    self.view.addSubview(inviteTFBackView)
    inviteTFBackView.snp.makeConstraints { (make) in
      make.top.equalTo(showInviteInputBT.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.textField)
    }
    
    self.view.addSubview(finishBackView)
    finishBackView.backgroundColor = self.view.backgroundColor
    finishBackView.snp.makeConstraints { (make) in
      make.left.right.equalTo(self.view)
      make.top.equalTo(showInviteInputBT.snp.bottom).offset(10)
      make.height.equalTo(labelHeight+CGDefine.height.maxButton+5)
    }
    
    let ruleLB = RichTextProtocolView()
    let fileArr = ["小诸葛金服注册及服务协议", "风险告知书"]
    ruleLB.fileNameArray = fileArr
    ruleLB.setAttributedTextTwoStyle(tipText: "点击“完成”，即表示您同意")
    ruleLB.markedTextTapClick = { [unowned self] tag in
      self.protocolBTClick(tag)
    }
    self.view.addSubview(ruleLB)
    ruleLB.snp.makeConstraints { (make) in
      make.top.equalTo(finishBackView)
      make.right.equalTo(-15)
      make.left.equalTo(15)
      make.height.equalTo(30.ratioHeight)
    }
    
    self.view.addSubview(finishBT)
    finishBT.addTarget(self, action: #selector(finishBTClick), for: .touchUpInside)
    finishBT.snp.makeConstraints { (make) in
      make.top.equalTo(ruleLB.snp.bottom).offset(15.ratioHeight)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    let twoNotReceiveVerifyNumBT = UIButton(type: .custom)
    self.view.addSubview(twoNotReceiveVerifyNumBT)
    twoNotReceiveVerifyNumBT.decorateStyleOfBT(title:"收不到短信验证码？", textColor:.prittyBlue, textFont: 12.ratioHeight,backGroundColor:.backGround)
    twoNotReceiveVerifyNumBT.addTarget(self, action: #selector(twoNotReceiveVerifyNumBTClick), for: .touchUpInside)
    twoNotReceiveVerifyNumBT.snp.makeConstraints { (make) in
      make.bottom.equalTo(self.view.snp.bottom).offset(-20)
      make.width.equalTo(120.ratioWidth)
      make.height.equalTo(30.ratioHeight)
      make.centerX.equalTo(self.view)
    }
    
  }

}

