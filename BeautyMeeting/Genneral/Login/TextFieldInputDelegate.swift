//
//  TextFieldInputDelegate.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/8.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation

enum TextFieldInputType:Int {
  case loginPassword = 16   //最大16位
  case phoneNumber = 11     //最大11位
  case identityCard = 18    //最大18位
  case bankCardNumber = 19  //最大19位
  case drawCashNumber = 9   //最大提现额位数
  case rechargeNumber       //充值
}

class TextFieldInputDelegate:NSObject,UITextFieldDelegate {
  
  var inputType:TextFieldInputType!
  
  convenience init(type:TextFieldInputType) {
    self.init()
    self.inputType = type
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let targetStr = textField.text! + string
    
    if inputType == .rechargeNumber || inputType == .drawCashNumber {
      if RegularManage.whetherIsDoubleValue(targetStr) {
        return true
      }else {
        return false
      }
    }
    if targetStr.count > inputType.rawValue {
      return false
    }
    return true
  }
  
}
