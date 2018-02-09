//
//  NetworkRequestConfig.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/28.
//  Copyright © 2016年 rongteng. All rights reserved.
//

struct RequestError {
  let code:Int
  let reason:String
}

extension RequestError {
  static func unknownError(_ code:Int) -> RequestError {
    return RequestError(code: code, reason: NetworkRequest_UnknownError)
  }
}

enum RequestResult<T> {
  case success(T)
  case failure(RequestError)
}


protocol ProtocolRequestUnifyHandle {
  ///统一post请求
  static func unifyPostRequest(parameter:Dictionary<String,String>,urlStr:String,handle:@escaping (RequestResult<JSON>) -> ())
  ///上传文件
  static func unifyUpload(parameter:Dictionary<String,String>,urlStr:String,data:Data,handle:@escaping (RequestResult<JSON>) -> ())
  
}

extension ProtocolRequestUnifyHandle {
  
  static func unifyPostRequest(parameter:Dictionary<String,String>,urlStr:String,handle:@escaping (RequestResult<JSON>) -> ()) {
    BaseRequest.shared.postRequest(url: urlStr, parameters: parameter, completionHandler: handle)
  }
  
  static func unifyUpload(parameter:Dictionary<String,String>,urlStr:String,data:Data,handle:@escaping (RequestResult<JSON>) -> ()) {
    BaseRequest.shared.postUpload(url: urlStr, parameters: parameter, data: data, completionHandler: handle)
  }
}

public enum BusinessIdentifier:String { //业务标识
  case JR = "0" //融腾金融
  case WD = "1" //网贷
  case YC = "2" //众筹
  case PJ = "3" //票据
  case JJ = "4" //基金
  case BX = "5" //保险
  case ZT = "6" //股权众筹
}

public enum ClientIdentifier:String { //客户端标识
  case IOS = "1"
  case Android = "2"
  case HTML5 = "3"
  case WeChat = "4"
  case QQ = "5"
  case PC = "6"
}

public enum ClientIdentifier2:String { //客户端标识
  case IOS = "ios"
  case Android = "android"
  case WAP = "wap"
}

enum ArticleListTypeCode:String {
  case notice = "notice" //公告
  case help = "help"   //帮助中心
  case medianews = "medianews" //媒体报道
}

//平台标识
enum PublishPlatform:String {
  case wangdai = "1" //网贷
  case jinfu = "2"  //金服
  case caifu = "3"  //财富
}

enum BannarType:String {
  case Register = "Register_banner" //注册页banner
  case Invite = "invite_banner" //邀请好友
  case Project = "projectAD"  //标内广告
  case Activity = "activity_banner"  //活动专区banner
  case NoLoginForAccountCenter = "MAU-banner"  //账户中心未登录banner
  case StartUp = "startup"  //启动页图片
}


enum ItemizedAccountType:String {
  case all = "all"   //全部
  case recharge = "recharge"  //充值
  case withdraw = "withdraw"  //提现
  case invest = "invest"  //投资
  case receipt = "receipt"  //回款
  case repayment = "repayment" //还款
  case reward = "reward"  //奖励
  case borrow = "borrow"  //借入
  case transfer = "transfer"  //转入
  case advance = "advance"  //垫付
  case buyBond = "buyBond"  //买入债券
  case saleBond = "saleBond"  //卖出债券
  case adjust = "adjust"  //调账
  case fee = "fee"  //费用
  case spread = "spread"  //补偿
  case briskIn = "briskIn"  //转入
  case briskOut = "briskOut"  //转出
  case briskIncome = "briskIncome"  //收益
  case briskInvest = "briskInvest"  //投资
  case briskEffect = "briskEffect"  //融腾宝生效
  case recommendInvest = "recommendInvest"  //投资推荐奖励
  case consume = "consume" //消费
}

//红包使用类型
enum TotleCouponListType:String {
  case none = "none" //未使用
  case used = "used" //已使用
  case overdue = "overdue" //已过期
}
//国槐红包使用类型
enum GuoHuaiCouponType:String {
  case notUsed = "notUsed" //未使用
  case used = "used" //已使用
  case expired = "expired" //已过期
}

//bool参数
enum BoolParameter:String {
  case VoiceFalse = "false"
  case VoiceTrue = "true"
}

//投资状态
enum InvestRecordStatus:String {
  case success = "success" //正在回款 计息中
  case done = "done"  //回款完毕
}

enum SortType:String {
  case desc = "desc" //降序
  case asc = "asc"   //升序
}

//投资期限类型
enum CycleType:String {
  case month = "month"
  case day = "day"
}

enum InvestStatus:String {
  case process = "process" //正在集资（立即抢购）
  case repayment = "repayment"  //正在还款
  case success = "success" //募集完成
  case done = "done" //回款完毕
}

//产品的种类 对应的是classify字段
enum ClassifyType:String {
  case experience = "experience" //体验标
  case car = "car" //车标
  case house = "house"  //房标
  case pledge = "pledge" //抵押标
  case worth = "worth" //净值标
  case chain = "chain" //借款标
  case transfer = "transfer"//债权
  case bond = "bond" //债权转让
  case petty = "petty" //借呗标
  case finaBorrow = "finaBorrow" //智能投顾标
}

//版本更新指示
enum UpdateIndicate:String {
  case none = "none"  //不需更新
  case maybe = "maybe" //非强制更新
  case must = "must"  //强制更新
}

//积分商城我的订单状态
enum MyOrderStatus:String {
  case waitSend = "WAITSEND" //待发货
  case waitReceipt = "WAITRECEIVE" //待收货
  case finsh = "FINISH" //完成
}
//手机充值类型
enum TelePhoneType:String{
  case phone = "phone"
  case flow = "flow"
}

//修改邮箱状态
enum EmailType:String{
  case active = "active"//激活
  case rebind = "rebind"//重新绑定
}

//不良资产 处置方式：1 股权转让 2 物权转让
enum processModeType: String {
  case stock = "1"
  case realRight = "2"
}

//不良资产 按金额排序方式：low 从低到高 tall 从高到低
enum moneySortType: String {
  case low = "low"
  case tall = "tall"
}














