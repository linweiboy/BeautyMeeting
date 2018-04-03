//
//  ModifyPasswordVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/2.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

//修改的类型
enum ModifyPurposeType:String {
  case modifyLoginPS = "修改登录密码"
  case modifyTradePS = "修改交易密码"
}

////修改登录密码或者交易密码
class ModifyPasswordVC: UIViewController,PopVCSetProtocol,VcDefaultConfigProtocol,LoadingPresenterProtocol {
  
  var modifyPurposeType:ModifyPurposeType = .modifyLoginPS
  var slectClickSuore:(()->())?
  
  fileprivate let originPSTF = UITextField() //原密码输入框
  fileprivate let newPSTF = UITextField() //新密码输入框
  fileprivate let confirmPSTF = UITextField() //确认新密码输入框
  fileprivate let confirmBT = RoundCornerBT.unifyConfirmBT(title: "确认修改")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = modifyPurposeType.rawValue
    defaultConfig()
    popLastPage()
    addShowViews()
  }
  
  
  //确认修改
  @objc func confirmBTClick() {
    
    guard RegularManage.whetherIsRightPassword(originPSTF.text!) else {
      showMessage("请输入正确格式的原密码！")
      return
    }
    guard RegularManage.whetherIsRightPassword(newPSTF.text!) else {
      showMessage("请输入正确格式的新密码！")
      return
    }
    guard RegularManage.whetherIsRightPassword(confirmPSTF.text!) else {
      showMessage("请输入正确格式的新密码！")
      return
    }
    
    guard originPSTF.text! != newPSTF.text! else {
      showMessage("新密码不能和原密码一致！")
      return
    }
    guard confirmPSTF.text! == newPSTF.text! else {
      showMessage("两次输入的新密码不一致！")
      return
    }
    //修改登录密码
    if self.modifyPurposeType == .modifyLoginPS {
      showLoadingView(nil)
      UserRequest.userModifyLoginPassword(oldPassword: originPSTF.text!, newPassword: confirmPSTF.text!, completionHandler: {[weak self] (result) in
        guard let strongSelf = self else {return}
        strongSelf.hiddenLoadingView()
        switch result {
        case .success:
          strongSelf.showMessage("登录密码修改成功！")
          GCDHelper.mainQueueAfterDelay(time: AfterDelayTime, task: {
            strongSelf.popToSetPage()
          })
        case .failure(let error):
          strongSelf.showMessage(error.reason)
        }
      })
      
    }
    
    //修改交易密码
    if self.modifyPurposeType == .modifyTradePS  {
      showLoadingView(nil)
      UserRequest.userModifyLoginPassword(oldPassword: originPSTF.text!, newPassword: confirmPSTF.text!, completionHandler: {[weak self] (result) in
        guard let strongSelf = self else {return}
        strongSelf.hiddenLoadingView()
        switch result {
        case .success:
          strongSelf.showMessage("交易密码修改成功！")
          GCDHelper.mainQueueAfterDelay(time: AfterDelayTime, task: {
            strongSelf.popToSetPage()
          })
          if strongSelf.slectClickSuore != nil {
            strongSelf.slectClickSuore!()
          }
        case .failure(let error):
          strongSelf.showMessage(error.reason)
        }
      })
    }
    
  }
  
  //textField值改变
  @objc func tfValueChange() {
    let en = !originPSTF.isEmpty && !newPSTF.isEmpty && !confirmPSTF.isEmpty
    confirmBT.isEnabled = en
  }
  
  func popToSetPage() {
    NotificationCenterHelper.refreshUserAssetInfo()
    popToLastVC() //返回上一个页面
  }
  
}


extension ModifyPasswordVC {
  
  func addShowViews() {
    originPSTF.addTarget(self, action: #selector(tfValueChange), for: .editingChanged)
    newPSTF.addTarget(self, action: #selector(tfValueChange), for: .editingChanged)
    confirmPSTF.addTarget(self, action: #selector(tfValueChange), for: .editingChanged)
    let headView = ModifyLoginPSView(originPSTF: originPSTF, newPSTF: newPSTF, confirmPSTF: confirmPSTF,type:modifyPurposeType)
    self.view.addSubview(headView)
    headView.snp.makeConstraints { (make) in
      make.top.equalTo(27)
      make.left.equalTo(8)
      make.right.equalTo(-8)
      make.height.equalTo(140.ratioHeight)
    }
    
    self.view.addSubview(confirmBT)
    confirmBT.addTarget(self, action: #selector(confirmBTClick), for: .touchUpInside)
    confirmBT.snp.makeConstraints { (make) in
      make.top.equalTo(headView.snp.bottom).offset(20)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    
    if modifyPurposeType == .modifyTradePS {
      let noteView = CozyNoteView(oneTitle: "温馨提示", middleImageName: "", twoNumTitle: "默认为您的登录密码；", threeNumTitle: "为了您的交易安全，请将交易密码和登录密码设置成不同的密码，并定期更换密码。")
      self.view.addSubview(noteView)
      noteView.snp.makeConstraints { (make) in
        make.top.equalTo(confirmBT.snp.bottom).offset(10)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(100)
      }
    }
    
    
  }
  
}

