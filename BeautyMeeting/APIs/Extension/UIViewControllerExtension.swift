////
////  UIViewControllerExtension.swift
////  RongTeng
////
////  Created by rongteng on 16/3/28.
////  Copyright © 2016年 Mike. All rights reserved.
////


extension UIViewController {
  
  ///检查手机号码输入
  func checkPhoneNum<T:LoadingPresenterProtocol>(phoneNumTF:UITextField,target:T) -> String? {
    guard let phoneNum = phoneNumTF.text,!phoneNum.isEmpty  else {
      target.showMessage("请输入手机号码！");
      return nil
    }
    guard RegularManage.isPhoneNumber(phoneNum)  else {
      target.showMessage("请输入正确格式的手机号码！");
      return nil
    }
    return phoneNum
  }
  
  ///检查密码输入
  func checkPassword<T:LoadingPresenterProtocol>(passwordTF:UITextField,target:T) -> String? {
    guard let passwordStr = passwordTF.text,!passwordStr.isEmpty  else {
      target.showMessage("请输入密码！");
      return nil
    }
    guard RegularManage.whetherIsRightPassword(passwordStr)  else {
      target.showMessage("密码应为6~16位！")
      return nil
    }
    return passwordStr
  }
  
  ///检查验证码输入
  func checkVerifyNum<T:LoadingPresenterProtocol>(verifyTF:UITextField,target:T) -> String? {
    guard let verityNum = verifyTF.text,!verityNum.isEmpty  else {
      target.showMessage("请输入短信验证码！");
      return nil
    }
    return verityNum
  }
  
  ///检查身份证号码
  func checkPeopleIdCard<T:LoadingPresenterProtocol>(peopleIdTF:UITextField,target:T) -> String? {
    guard let passwordStr = peopleIdTF.text,!passwordStr.isEmpty  else {
      target.showMessage("请输入身份证号码！");
      return nil
    }
    guard RegularManage.whetherIsPeopleIdCard(passwordStr)  else {
      target.showMessage("请输入正确格式的身份证号码！");
      return nil
    }
    return passwordStr
  }
  
  ///检查银行卡号
  func checkBankCard<T:LoadingPresenterProtocol>(bankCardTF:UITextField,target:T) -> String? {
    guard let passwordStr = bankCardTF.text,!passwordStr.isEmpty  else {
      target.showMessage("请输入银行卡号！");
      return nil
    }
    guard RegularManage.whetherIsBankCardNumber(passwordStr)  else {
      target.showMessage("请输入正确格式的银行卡号！");
      return nil
    }
    return passwordStr
  }
  
  ///检查姓名
  func checkPeopleName<T:LoadingPresenterProtocol>(peopleNameTF:UITextField,target:T) -> String? {
    guard let peopleName = peopleNameTF.text,!peopleName.isEmpty else {
      target.showMessage("请输入真实姓名！");
      return nil
    }
    return peopleName
  }
  
  ///检查金额输入
  func checkMoneyInput<T:LoadingPresenterProtocol>(moneyInputTF:UITextField,target:T) -> Double? {
    guard let moneyInputStr = moneyInputTF.text,!moneyInputStr.isEmpty  else {
      target.showMessage("输入金额不能为空！");
      return nil
    }
    
    guard let amount = moneyInputStr.doubleValue else {
      return nil
    }
    
    guard amount > 0  else {
      target.showMessage("输入金额不能为零！");
      return nil
    }
    
    return amount
  }
  
  
  /// 保留导航栈的第一个和最后一个
  func navStackSaveFirstAndLast() {
    guard let nav = self.navigationController else { return }
    var vcs = nav.viewControllers
    let firstVC = vcs.first
    let lastVC = vcs.last
    vcs.removeAll()
    vcs.append(contentsOf: [firstVC!,lastVC!])
    nav.setViewControllers(vcs, animated: false)
  }
  
}

