//
//  AccountManage.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation


private let SaveUserAccountNumberKey = "AccountNumber" //保存账号 赋值取值用的key
private let WhetherShowGuidePage = "showGuidePage" //保存是否显示过 引导页了
private let WhetherShowGuideView = "showGuideView"

class AccountManage:NSObject {
  
  static let shared = AccountManage()
  @objc dynamic var account:UserAccount? //当前登录用户
  
  fileprivate let accountFileName = "accounts"
  
  fileprivate  var accountsStoragePath:String? {
    let createPath = PathHelper.createSubDirectoryPathIn(.documentDirectory, name: "db")
    if createPath != nil {
      return createPath! + ("/"+accountFileName)
    }
    return nil
  }
  
  fileprivate  func loadAccount() {
    if let acc = NSKeyedUnarchiver.unarchiveObject(withFile: accountsStoragePath!) as? UserAccount {
      self.account = acc
    }
  }
  
  func saveAccount(_ acc:UserAccount) {
    NSKeyedArchiver.archiveRootObject(acc, toFile: accountsStoragePath!)
    self.account = acc
  }
  
  func removeAccount() {
    if (account != nil) {
      NSKeyedArchiver.archiveRootObject(NSNull(), toFile: accountsStoragePath!)
      self.account = nil
    }
  }
  
  func currentAccount() -> UserAccount? {
    if account == nil {
      loadAccount()
    }
    return self.account
  }
  
  var isLogin:Bool {
    if account == nil {
      loadAccount()
      return account != nil ? true:false
    }else {
      return true
    }
  }
  
  ///统一退出当前用户
  class func logoutCurrentAccount() {
    GesturePasswordManage.saveWhetherAlreadyNoteSetGesturePS(false)
    AccountManage.shared.removeAccount()
  }
  
}

//记录用户的登录账号
extension AccountManage {
  
  ///获取用户保存的账号
  class func achieveUserAccountNumber() -> String? {
    return UserDefaults.standard.object(forKey: SaveUserAccountNumberKey) as? String
  }
  
  ///保存用户的账号
  class func saveUserAccountNumber(_ accountNumber:String)  {
    UserDefaults.standard.setValue(accountNumber, forKey: SaveUserAccountNumberKey)
  }
  
  ///移除存的账号
  class func removeUserAccountNumber() {
    UserDefaults.standard.removeObject(forKey: SaveUserAccountNumberKey)
  }
  
}


//记录用户 是否显示过引导页了
extension AccountManage {
  
  ///获取 是否显示过指导页了
  class func achieveWhetherShowGuidePage() -> Bool {
    //如果没存储过
    guard let saveVersionStr = UserDefaults.standard.value(forKey: WhetherShowGuidePage) as? String else {
      return false
    }
    return isHightCurrentVersionNumber(saveVersionStr)
  }
  
  ///保存 是否显示指导页
  class func saveWhetherShowGuidePage()  {
    let versionStr = AccessSystem.versionNum
    UserDefaults.standard.setValue(versionStr, forKey: WhetherShowGuidePage)
  }
  
  
  ///获取 是否显示过新功能引导图
  class func achieveWhetherShowGuideView() -> Bool {
    //如果没存储过
    guard let saveVersionStr = UserDefaults.standard.value(forKey: WhetherShowGuideView) as? String else {
      return false
    }
    return isHightCurrentVersionNumber(saveVersionStr)
  }
  
  ///保存 是否显示新功能引导图
  class func saveWhetherShowGuideView()  {
    let versionStr = AccessSystem.versionNum
    UserDefaults.standard.setValue(versionStr, forKey: WhetherShowGuideView)
  }
  
  //与当前版本号比较
  class func isHightCurrentVersionNumber(_ saveVersionNum: String) -> Bool {
    let currentVersionStr = AccessSystem.versionNum
    let result = currentVersionStr.compare(saveVersionNum, options: .numeric, range: nil, locale: nil)
    if result.rawValue > 0 { //如果当前版本大 让显示
      return false
    }else {
      return true
    }
  }
  
}
























