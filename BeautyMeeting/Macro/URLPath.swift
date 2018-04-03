//
//  URLPath.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/6/16.
//  Copyright © 2017年 rongteng. All rights reserved.
//


//MARK: -小诸葛独立Path
extension XZGURL {
  
  //首页banner
  static let homeBanner = "wd_api/banner/getBannerOn"
  //首页最新活动更多列表
  static let homeMoreList = "wd_api/banner/getActivityListOn"
  //首页获取新闻列表
  static let newsCode = "wd_api/article/getSubCodesOn"
  //首页推荐标列表
  static let homeList = "wd_api/article/getIndexArticleOn"
  //首页获取消息
  static let noticeCode = "wd_api/article/getArticleListOn"
  
  
  
  //注册
  static let register = "user/register"
  //登录
  static let login = "home/login"
  //会员申请
  static let memberApply = "member/save"
  //修改登录密码
  static let userModifyLoginPassword = "user/updatePassword"

  
  
  //发送验证码(找回登录密码)
  static let sendVerify_ResetLoginPassword = "wd_api/userCenter/sendRetrievePwdCodeOn"
  //找回登录密码
  static let resetLoginPassword = "wd_api/userCenter/doRetrievePwdResetOn"
  
  //邀请好友-详情
  static let userInviteFriendDetail = "wd_api/inviteIndex/getInvite"
  //已邀请好友列表
  static let userInviteFriendList = "wd_api/inviteIndex/getInviteDetail"
  //修改用户名
  static let userSetModifyUserName = "user/updateUserName"
  //修改手机号码
  static let userSetModifyUserPhoneNumber = "user/updateMobile"
  
  
  //-----------------------------------------------------------H5地址
  //安全保障
  static let H5_SafeGuarantee = "sageguard/index.html"
  //投资协议
  static let H5_InvestAgreement = "center/contract/preview-fqb"
  //注册协议
  static let H5_registerAgreement =  "agreement/service.html"
  //邀请好友活动页面
  static let H5_InviteFriendActivity = "topic/invite/index.html"
  //提现说明
  static let H5_WithdrawalCash = "center/withdraw/explain.html"
  //最新活动
  static let H5_NewActivity = "about/newActivity.html"
  //品牌介绍
  static let H5_BrandIntroduce = "sageguard/introduce.html"
  //操作指南
  static let H5_OperateGuidance = "sageguard/sttrong.html"
  //银行存管
  
  static let H5_BankStoreManage = "topic/activity_mobile/cunguan_h5.html"
//  static let H5_BankStoreManage = "about/content/1386.html"
  
  /**
   * 诸葛结算介绍
   */
   static let H5_ZhuGeIntrodce = "h5/jieshao.html";
  /**
   * 常见问题
   */
   static let H5_NomalProble = "h5/changjianwenti.html";
  /**
   * 诸葛智投服务协议
   */
   static let H5_ZhuGeZhiTou = "h5/zhinengtougu.html";
  /**
   * 风险告示书
   */
   static let H5_FengXian = "h5/risk.html";
  
}




