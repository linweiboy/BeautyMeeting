////
////  AchieveUnifySource.swift
////  XiaoZhuGeJinFu
////
////  Created by rongteng on 16/8/22.
////  Copyright © 2016年 rongteng. All rights reserved.
////
//
//
//class AchieveSource {
//
//  internal static let shared = AchieveSource()
//
//  static var festivalName = "default"
//
//  var unifySource:UnifySourceModel? {
//    didSet {
//      guard let unis = unifySource else { return }
//      AchieveSource.festivalName = unis.holidaySkinId
//      AppDelegate.shared.mainVC.setTabBarTintColor(AchieveSource.festivalName)
//    }
//  }
//
//  func achieveSystemSource() {
//    CommonRequest.achieveSystemSource { (result) in
//      switch result {
//      case .success(let json):
//        let sourceModel =  UnifySourceModel(json: json["data"])
//        self.unifySource = sourceModel
//      default:break
//      }
//    }
//  }
//
//}
//
//struct UnifySourceModel:ProtocolUnifyModel {
//
//  let voucher:Float  //新手送的红包金额
//  let ossURL:String  //阿里云地址
//  let registerSuccessVoucher:String  //注册成功送的红包金额及文字
//  let loginVoucher:String  //登录页面送的红包金额及文字
//  let holidaySkinId:String //节日
//
//  init(json: JSON) {
//    voucher = json["voucher"].floatValue
//    ossURL = json["ossURL"].stringValue
//    registerSuccessVoucher = json["registerSuccessVoucher"].stringValue
//    loginVoucher = json["loginVoucher"].stringValue
//    holidaySkinId = json["holidaySkinId"].stringValue
//  }
//
//}
//
