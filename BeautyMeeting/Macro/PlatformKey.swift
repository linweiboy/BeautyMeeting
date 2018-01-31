//
//  PlatformKey.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/7/18.
//  Copyright © 2017年 rongteng. All rights reserved.
//

struct PlatformKey {
  //微信分享
  static let WEICHAT_KEY = "wx18a7fc197ed01537"
  static let WEICHAT_SECRET = "26a31e9f068b3d8824f9d30368766ef0"
  
  //友盟平台
  static let UMeng_Appkey = "570b5d4767e58e72c80011e2"
  
  //QQ分享
  static let QQShare_ID = "1105353611"
  static let QQShare_KEY = "aIqgEI6DXXTRzydo"
  
  //新浪微博
  static let XinLangAppKey = "2851953757"
  static let XinLangAppSecret = "fdab44c24e214df521ad57d2628e344b"
  static let XinLangAppRedirectURL = "https://api.weibo.com/oauth2/default.html"
  
  //极光推送
  static let JPUSH_KEY = "fbb5c080bf6b9f46c650fade"  //正式环境
  //let JPUSH_KEY = "35afb4af9a0924be69c40afb"  //测试环境
  
  //听云key
  static let TingYunAppKey = "73de44c5e4e944fcb418d5c9fc6e4e64"
  
  //小诸葛(网贷)分配给app厂商的
  static let AppKey =  "APP5f8e6bfa"
  static let AppSecret = "f4b9ebc5-dcae-4214-9e45-216327d2b8ca"
  
  //国槐(财富)分配给app厂商的
  static var Channel_Oid:String  {
    let currentU =  GuoHuaiURL.server.currentUrl
    switch currentU {
    case GuoHuaiURL.server.formal: return "8a7df1b15cfcfa6f015cfd6d8d52054b" //正式
    case GuoHuaiURL.server.pre: return "8a9c20625e0e58d6015e5521b7902ecc" //预发布
    case GuoHuaiURL.server.test: return "8a9c20625e78c6fa015e949d896001ba" //测试
    default:return "8a9e68ed5c1ff561015c207dc8a407bf" //其它
    }
  }
  static var Cid:String {
    let currentU =  GuoHuaiURL.server.currentUrl
    switch currentU {
    case GuoHuaiURL.server.formal: return "xzgjf" //正式
    case GuoHuaiURL.server.pre: return "12308" //预发布
    default:return "12306" //测试
    }
  }
  static var Ckey:String  {
    let currentU =  GuoHuaiURL.server.currentUrl
    switch currentU {
    case GuoHuaiURL.server.formal: return "xzgjf" //正式
    case GuoHuaiURL.server.pre: return "12308" //预发布
    default:return "12306" //测试
    }
  }
  
  //智齿客服app key
  static let ZhiChiKeFuAppKey = "2362fd5551d340bbb08cff1b995e80d8"
  
}
