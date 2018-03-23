//
//  AppDelegate.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let mainVC = MainTabBarVC()
  static let shared = UIApplication.shared.delegate as! AppDelegate

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
//    if !AccountManage.achieveWhetherShowGuidePage() {
//      let guideVC = GuidePageVC()
//      guideVC.finishClosure = { [unowned self] in
//        self.window?.rootViewController = self.mainVC
//      }
//      window?.rootViewController = guideVC
//    }else {
      window?.rootViewController = mainVC
//    }
    window?.makeKeyAndVisible()
    
    //如果是登录状态, 初始化融云SDK, 否则等待用户登录成功时初始化
    if AccountManage.shared.isLogin {
      RCDataSourceHelper.shared.connectRongCloud(token: AccountManage.shared.currentAccount()?.accessToken)
    } else {
      //api测试
      RCDataSourceHelper.shared.connectRongCloud(token: "EpA0m54rSplkcQRT8vLUmcDzjjsTcdo8TNxSxIPoMRbFVpY9E94HcN4QkDo/OJFIdPb33B/FlJV7dawjPk1b3FsC6rp/nBHM")
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    
  }

  func applicationWillTerminate(_ application: UIApplication) {
    
  }


}

