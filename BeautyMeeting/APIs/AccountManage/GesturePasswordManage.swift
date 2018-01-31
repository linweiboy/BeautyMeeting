//
//  GesturePasswordManage.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/1.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation

private let statusKey = "Status"
private let passwordKey = "Password"
private let gesturePassword = "GesturePasswordKey"
private let WhetherSetGesturePS = "isNoteGesturePS" //记录登录用户 是否被提示过 设置手势密码

class GesturePasswordManage {
  
  //保存用户的手势密码和开关状态 以用户的手机号为key status = 0 是关闭 1是打开
  class func savePassword(_ pw:String,status:String,key:String) {
    let dic = [passwordKey:pw,statusKey:status]
    let currentDic = UserDefaults.standard.object(forKey: gesturePassword)
    var changeDic = [String:Dictionary<String,String>]()
    if currentDic != nil {
      let curDic = currentDic as! Dictionary<String,Dictionary<String,String>>
      changeDic = curDic
    }
    changeDic[key] = dic
    UserDefaults.standard.set(changeDic, forKey: gesturePassword)
    UserDefaults.standard.synchronize()
  }
  
  class func removePasswordWithKey(_ key:String) {
    let currentDic = UserDefaults.standard.object(forKey: gesturePassword)
    if currentDic != nil {
      var resultDic = currentDic as! Dictionary<String,Dictionary<String,String>>
      resultDic.removeValue(forKey: key)
      UserDefaults.standard.set(resultDic, forKey: gesturePassword)
      UserDefaults.standard.synchronize()
    }
  }
  
  //获取用户的手势密码 以用户的手机号码为key
  class func achieveGesturePSWith(_ key:String) -> String? {
    let currentDic = UserDefaults.standard.object(forKey: gesturePassword)
    
    if currentDic != nil {
      let totleDic = currentDic as! Dictionary<String,Dictionary<String,String>>
      let userDic = totleDic[key]
      if userDic != nil {
        return userDic![passwordKey]
      }
    }
    return nil
  }
  
  //获取用户的手势密码是否打开  以用户的手机号为key
  class func achieveGestureOpenStatusWith(_ key:String) -> String {
    let currentDic = UserDefaults.standard.object(forKey: gesturePassword)
    if currentDic != nil {
      let cuDic = currentDic as! Dictionary<String,Dictionary<String,String>>
      let userDic = cuDic[key]
      if userDic != nil {
        return userDic![statusKey]!
      }
    }
    return "0"
  }
  
  //获取用户 是否创建了手势密码  以用户的手机号为key
  class func achieveWhetherHaveGesturePSWith(_ key:String) -> Bool {
    let currentDic = UserDefaults.standard.object(forKey: gesturePassword)
    if currentDic != nil {
      let cuDic = currentDic as! Dictionary<String,Dictionary<String,String>>
      let userDic = cuDic[key]
      if userDic != nil {
        return true
      }
    }
    return false
  }
  
}

extension GesturePasswordManage {
  //获取 是否已经提示过设置手势密码
  class func achieveWhetherAlreadyNoteSetGesturePS() -> Bool {
    return UserDefaults.standard.bool(forKey: WhetherSetGesturePS)
  }
  
  //保存 是否已经提示过设置手势密码 true=提示过了 false=未提示
  class func saveWhetherAlreadyNoteSetGesturePS(_ isNote:Bool)  {
    UserDefaults.standard.set(isNote, forKey: WhetherSetGesturePS)
  }
  
}



