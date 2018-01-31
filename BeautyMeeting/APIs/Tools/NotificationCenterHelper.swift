//
//  NotificationCenterHelper.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/11/28.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation


class NotificationCenterHelper {
  
  /// 立刻刷新用户资产信息
  class func refreshUserAssetInfo() {
    let notiFi = NotificationCenter.default
    notiFi.post(name: Notification.Name(rawValue: NotificationName.refreshUserInfo), object: nil)
  }
  
  
  /// 延迟4秒刷新用户资产信息
  class func delayRefreshUserAssetInfo() {
    GCDHelper.entryCountdown(4) {
      let notiFi = NotificationCenter.default
      notiFi.post(name: Notification.Name(rawValue: NotificationName.refreshUserInfo), object: nil)
    }
  }
  
  
}
