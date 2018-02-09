//
//  UserRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/21.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//登录注册 请求 相关
class UserRequest:ProtocolRequestUnifyHandle {
  
  ///登录和注册流程 发送验证码 手机号码=mobile
  class func userSendVerifyNumForLoginAndRegister(_ mobile:String,voice:BoolParameter, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"voice":voice.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.sendVerify_LoginAndRegister, handle: completionHandler)
  }
  
  ///登录 username=用户名 password=密码 ct=客户端标识(可选)
  class func userLogin(_ username:String,password:String,ct:ClientIdentifier?, completionHandler:@escaping (RequestResult<JSON>)->()) {
    
    //以下四个参数是为了 获得用户的设备信息
    let version = UIDevice.current.systemVersion
    let model = UIDevice.current.model
    let imei = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let manufacturer = "Apple"
    
    var para = ["username":username,"password":password,
                "version":version,"model":model,"imei":imei,"manufacturer":manufacturer]
    if ct != nil {para["ct"] = ct!.rawValue}
    unifyPostRequest(parameter: para, urlStr: XZGURL.login, handle: completionHandler)
  }
  
  //注册前检查用户的手机号码是否可以注册
  class func userRegisterCheckMobile(_ mobile:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile]
    unifyPostRequest(parameter: para, urlStr: XZGURL.register_CheckMobile, handle: completionHandler)
  }
  
  ///注册 mobile=注册手机号 password=密码 手机验证码=verifyNo 邀请人手机号码(邀请码)=referrer(可选)
  ///ct=客户端标识(可选)  bt=业务标识(可选)
  class func userRegister(_ mobile:String,password:String,verifyNo:String,referrer:String? ,ct:ClientIdentifier?,bt:BusinessIdentifier?, completionHandler:@escaping (RequestResult<JSON>)->()) {
    var para = ["mobile":mobile,"password":password,"verifyNo":verifyNo]
    if referrer != nil {para["referrer"] = referrer}
    if ct != nil {para["ct"] = ct!.rawValue}
    if bt != nil {para["bt"] = bt!.rawValue}
    unifyPostRequest(parameter: para, urlStr: XZGURL.register, handle: completionHandler)
  }
  
  ///找回登录密码 发送验证码 手机号码=mobile  是否是语音还是短信=voice(false或true)
  class func userSendVerifyNumForResetLoginPassword(_ mobile:String,voice:BoolParameter, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"voice":voice.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userGetVerify, handle: completionHandler)
  }
  
  ///找回登录密码 手机号码=mobile  验证码=code  newPwd=新密码
  class func userResetLoginPassword(_ mobile:String,code:String,newPwd:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"code":code,"newPwd":newPwd]
    unifyPostRequest(parameter: para, urlStr: XZGURL.resetLoginPassword, handle: completionHandler)
  }
  
  
  
}


//用户信息 请求 相关
extension UserRequest {
  
  ///修改登录密码 oldPassword=旧密码  newPassword=新密码
  class func userModifyLoginPassword(oldPassword:String,newPassword:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["oldPassword":oldPassword,"newPassword":newPassword]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userModifyLoginPassword, handle: completionHandler)
  }
  
  ///修改交易密码 oldOutPassword=旧交易密码  newOutPassword=新交易密码
  class func userModifyTradePassword(oldOutPassword:String,newOutPassword:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["oldOutPassword":oldOutPassword,
                "newOutPassword":newOutPassword]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userModifyTradePassword, handle: completionHandler)
  }
  
  
  ///重置交易密码 mobile=用户手机号码  code=验证码  newPwd=新交易密码
  class func userResetTradePassword(_ mobile:String,code:String,newPwd:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"code":code,"newPwd":newPwd]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userResetTradePassword, handle: completionHandler)
  }
  
  
  ///用户消息列表  isRead=是否已读
  class func userMessageList(_ offset:Int?,max:Int?,isRead:String?,completionHandler:@escaping (RequestResult<JSON>)->()) {
    var para: [String:String] = [:]
    if offset != nil { para["offset"] = offset!.stringValue}
    if max != nil {para["max"] = max!.stringValue}
    if isRead != nil {para["isRead"] = isRead}
    unifyPostRequest(parameter: para, urlStr: XZGURL.userMessageList, handle: completionHandler)
  }
  
  ///获取用户信息
  class func userRealNameInfo(completionHandler:@escaping (RequestResult<JSON>)->()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.user_RealNameInfo, handle: completionHandler)
  }
  
  ///修改用户名 userName=新用户名
  class func userModifyUserName(_ userName:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["userName":userName]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userSetModifyUserName, handle: completionHandler)
  }
  ///绑定修改邮箱
  class func userModifyUserEmail(_ email:String,type:EmailType,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["email":email,"type":type.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userSetModifyUserEmail, handle: completionHandler)
  }
  
  ///获取用户手机号码 authNo=原手机手机验证码 mobile=新手机号 verifyNo=新手机手机验证码
  class func userModifyUserPhoneNumber(_ authNo:String,mobile:String,verifyNo:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["authNo":authNo,"mobile":mobile,"verifyNo":verifyNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userSetModifyUserPhoneNumber, handle: completionHandler)
  }
  
}

//用户资产信息 相关
extension UserRequest {
  
  /// 用户中心 获取用户资金详情
  ///
  /// - Parameters:
  ///   - completionHandler: 回调
  class func userAssetInfo(completionHandler:@escaping (RequestResult<JSON>)->()) {
    BaseRequest.shared.postRequest(url: XZGURL.memberInfoall, parameters: [:], completionHandler: completionHandler)
  }
  
  ///资金明细
  class func userAssetItemizedAccount(_ offset:Int,max:Int,type:ItemizedAccountType,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["offset":offset.stringValue,
                "max":max.stringValue,"type":type.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userAssetItemizedAccount, handle: completionHandler)
  }
  
  ///用户红包列表 type=查询类型
  class func userTotleCouponList(_ offset:Int,max:Int,status:TotleCouponListType,
                                 completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["status":status.rawValue,
                "offset":offset.stringValue,"max":max.stringValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.user_CouponList, handle: completionHandler)
  }
  
  ///提现 amount=金额 outPassword=交易密码 verifyNo=校验码 bankId=提现银行ID
  class func userDrawMoney(_ amount:String,outPassword:String,verifyNo:String,
                           bankId:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["amount":amount,"outPassword":outPassword,
                "verifyNo":verifyNo,"bankId":bankId]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userDrawMoney, handle: completionHandler)
  }
  
  ///网贷提现至财富账户 amount=金额 type=来源(0：网贷提现；1：财富充值)
  class func netBorrowDrawMoneyToFinance(_ amount:String,type:String,
                                         completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["amount":amount,"type":type]
    unifyPostRequest(parameter: para, urlStr: XZGURL.netBorrowDrawMoneyToFinance, handle: completionHandler)
  }
  
  ///网贷提现至财富账户 amount=金额 type=来源(0：网贷提现；1：财富充值)
  class func netBorrowDrawMoneyToFinanceCheckOrder(_ orderNo:String,
                                                   completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["orderNo":orderNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.netBorrowDrawMoneyToFinanceCheckOrder, handle: completionHandler)
  }
  
  
  
  
  ///提现 status=(process 正在投资 success 正在回款 done 回款完毕)
  class func userInvestRecord(_ offset:Int,max:Int,status:InvestRecordStatus,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let para = ["status":status.rawValue,
                "offset":offset.stringValue,"max":max.stringValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userInvestRecord, handle: completionHandler)
  }
  
  
  ///邀请好友详情
  class func userInviteFriendDetail(completionHandler:@escaping (RequestResult<JSON>)->()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.userInviteFriendDetail, handle: completionHandler)
  }
  
  
  ///邀请好友详情
  class func userInviteFriendList(_ offset:Int,max:Int,type:String,
                                  completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["offset":offset.stringValue,"max":max.stringValue,"type":type]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userInviteFriendList, handle: completionHandler)
  }
  
  
  ///充值 amount=充值金额 way=llios：苹果端连连认证支付   bankNo=银行卡号(可选，与银行卡ID必填一项) bankId=银行卡ID(可选，与银行卡号必填一项) idCard=身份证 realName=真实姓名 province=开户省 city=开户城市 bankSubName=开户支行名  tradeNo=订单号
  //1.提现第一次充值要传参数：amount，way,bankNo,idCard,realName,province,city,bankSubName
  //2.第一次充值：amount,way,bankNo,idCard,realName
  //3.后续充值:amount,bankId,way
  class func userRecharge(_ amount:String,way:String,bankNo:String?,bankId:String?,idCard:String?,realName:String?,province:String?,city:String?,bankSubName:String?,tradeNo:String?,completionHandler:@escaping (RequestResult<JSON>)->()) {
    var para = ["amount":amount,"way":way]
    if bankId != nil {para["bankId"] = bankId}
    if bankNo != nil {para["bankNo"] = bankNo}
    if idCard != nil {para["idCard"] = idCard}
    if realName != nil {para["realName"] = realName}
    if province != nil {para["province"] = province}
    if city != nil {para["city"] = city}
    if bankSubName != nil {para["bankSubName"] = bankSubName}
    if tradeNo != nil {para["tradeNo"] = tradeNo}
    unifyPostRequest(parameter: para, urlStr: XZGURL.userRecharge, handle: completionHandler)
  }
  
  ///请求签名 sign    paramString = 需要签名的字段
  class func userRequestSignRecharge(_ paramString:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["paramString":paramString]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userRechargeSign, handle: completionHandler)
  }
  
  ///修改银行卡信息 /*bankAccount=银行卡号 bankName=银行名称 bankSubName=支行名称 province = 开户省份 city=开户城市
  class func userRechargeBankCard(_ bankAccount:String,bankName:String,bankSubName:String,province:String,city:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["bankAccount":bankAccount,"bankName":bankName,
                "bankSubName":bankSubName,"province":province,"city":city]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userEditBank, handle: completionHandler)
  }
  
  ///获取银行列表 无参数
  class func userGetBankList(_ completionHandler:@escaping (RequestResult<JSON>)->()) {
    
    
    let meId = AccountManage.shared.currentAccount()!.id
    unifyPostRequest(parameter: ["id":meId], urlStr: XZGURL.userGetBankList, handle: completionHandler)
  }
  
  ///获取验证码  mobile	= 手机号 operate	= 中文信息，用于显示在短信上 例如：您正在${operate}，本次的动态验证码为XXXX   voice=是否语音验证码
  class func userGetVerifyCode(_ mobile:String,operate:String,voice:BoolParameter,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"operate":operate,"voice":voice.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userGetVerify, handle: completionHandler)
  }
  
  ///提现手续费   amount	=	提现金额
  class func achieveUserDrawCashFee(_ amount:String,completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["amount":amount]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userDrawCashFee, handle: completionHandler)
  }
  
  ///获取用户银行列表信息
  class func achieveUserBankList(_ completionHandler:@escaping (RequestResult<JSON>)->()){
    unifyPostRequest(parameter: [:], urlStr: XZGURL.investBankList, handle: completionHandler)
  }
  
  ///获取地区信息列表
  class func achieveAreaList(_ completionHandler:@escaping (RequestResult<JSON>)->()){
    unifyPostRequest(parameter: [:], urlStr: XZGURL.userAreaList, handle: completionHandler)
  }
  ///验证验证码  mobile=手机号 verifyNo=	手机验证码
  class func checkVerifOn(_ mobile:String,verifyNo:String,completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["mobile":mobile,"verifyNo":verifyNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.checkVerifty, handle: completionHandler)
  }
  
  ///校验交易密码 outPassword=交易密码
  class func checkOutPassword(_ outPassword:String,completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["outPassword":outPassword]
    unifyPostRequest(parameter: para, urlStr: XZGURL.chenckPassWord, handle: completionHandler)
  }
  
  
  /// 兑换详情
  ///
  /// - Parameters:
  ///   - id: 红包ID
  ///   - completionHandler: 回调
  class func IntegralExchangeDetail(id:String, completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["id":id]
    unifyPostRequest(parameter: para, urlStr: XZGURL.integralExchangeDetail, handle: completionHandler)
  }
  
  
  /// 立即兑换
  ///
  /// - Parameters:
  ///   - id: 红包ID
  ///   - amount: 兑换数量
  ///   - completionHandler: 回调
  class func IntegralExchange(id:String,amount:String, completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["id":id,"amount":amount]
    unifyPostRequest(parameter: para, urlStr: XZGURL.integralExchange, handle: completionHandler)
  }
  
  
  /// 我的智能顾投列表
  ///
  /// - Parameters:
  ///   - tabInvestStatus: 状态 hold=持有中 done=已结清
  ///   - completionHandler: 回调
  class func MyIntelligentInvestList(tabInvestStatus:String,
                                     offset:Int,max:Int, completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["tabInvestStatus":tabInvestStatus,
                "offset":offset.stringValue,"max":max.stringValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.myIntelligentInvestList, handle: completionHandler)
  }
  
  /// 我的智能顾投详情
  ///
  /// - Parameters:
  ///   - investId: 项目投资编号ID
  ///   - completionHandler: 回调
  class func MyIntelligentInvestDetail(investId:String, completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["investId":investId]
    unifyPostRequest(parameter: para, urlStr: XZGURL.myIntelligentInvestDetail, handle: completionHandler)
  }
  
  
  
  /// 我的智投产品债权列表
  ///
  /// - Parameters:
  ///   - roaInvestId: 我的智投id
  ///   - offset: 偏移
  ///   - max: 每次最大条数
  ///   - completionHandler: 回调
  class func MyIntelliRgentRoaInvestList(roaInvestId:String,offset:Int,max:Int, completionHandler:@escaping (RequestResult<JSON>)->()){
    let para = ["roaInvestId":roaInvestId,
                "offset":offset.stringValue,
                "max":max.stringValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.roaInvestList, handle: completionHandler)
  }
  
  
  
  
  /// 托管->申请开户 会自动发短信
  ///
  /// - Parameters:
  ///   - realName: 姓名
  ///   - idCard: 身份证号
  ///   - preMobile: 预留手机号
  ///   - bankAccount: 银行账号
  ///   - openBranch: 银行编号
  ///   - completionHandler: 回调
  class func applyTrusteeship(realName:String,idCard:String,preMobile:String,bankAccount:String,openBranch:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["realName":realName,"idCard":idCard,"preMobile":preMobile,
                "bankAccount":bankAccount,"openBranch":openBranch]
    BaseRequest.shared.postRequest(url: XZGURL.applyTrusteeship, parameters: para, completionHandler: completionHandler)
  }
  
  /// 托管->认证
  ///
  /// - Parameters:
  ///   - realName: 姓名
  ///   - idCard: 身份证号
  ///   - preMobile: 预留手机号
  ///   - bankAccount: 银行卡号
  ///   - identifyingCode: 验证码
  ///   - originOrderNo: 原始订单号
  ///   - openBranch: 银行编码
  ///   - platcust: 开户编号
  ///   - completionHandler: 回调
  class func applyTrusteeshipAuthentication(realName:String,idCard:String,
                                            preMobile:String,bankAccount:String,
                                            identifyingCode:String,
                                            originOrderNo:String,openBranch:String,
                                            platcust:String?,
                                            completionHandler:@escaping (RequestResult<JSON>)->()) {
    var para = ["realName":realName,"idCard":idCard,"preMobile":preMobile,
                "bankAccount":bankAccount,"identifyingCode":identifyingCode,
                "originOrderNo":originOrderNo,"openBranch":openBranch]
    if let pl = platcust { para["platcust"] = pl }
    BaseRequest.shared.postRequest(url: XZGURL.applyTrusteeshipAuthentication, parameters: para, completionHandler: completionHandler)
  }
  
  /// 托管发送验证码
  ///
  /// - Parameters:
  ///   - completionHandler: 完成回调
  class func netBorrowSendSmsCode(completionHandler:@escaping (RequestResult<JSON>)->()) {
//    printLog(message: "发送短信参数=\(para)")
    unifyPostRequest(parameter: [:], urlStr: XZGURL.netBorrowDepositSmsCode, handle: completionHandler)
  }
  
  /// 托管充值
  ///
  /// - Parameters:
  ///   - amount: 充值金额
  ///   - premobile: 银行预留手机号
  ///   - way: 第三方通道（“depositand”-托管支付安卓认证；“depositios”-托管支付苹果认证支付）
  ///   - bankNo: 银行卡号
  ///   - bankId: 银行卡ID
  ///   - smsCode: 短信验证码
  ///   - chargeType: 1-投资账户 2-借款账户
  ///   - completionHandler: 数据回调
  class func netBorrowRecharge(amount:String,premobile:String,way:String,
                               bankNo:String?,bankId:String,smsCode:String,
                               chargeType:String,tradeNo:String?,
                               completionHandler:@escaping (RequestResult<JSON>)->()) {
    var para = ["amount":amount,"smsCode":smsCode,"premobile":premobile,
                "way":way,"chargeType":chargeType,"bankId":bankId,]
    if let tr = tradeNo { para["tradeNo"] = tr }
    if let bn = bankNo { para["bankNo"] = bn}
    unifyPostRequest(parameter: para, urlStr: XZGURL.netBorrowRecharge, handle: completionHandler)
  }
  
  
  
  /// 托管充值查询订单是否成功
  ///
  /// - Parameters:
  ///   - orderNo: 订单号
  ///   - completionHandler: 回调
  class func netBorrowRechargeCheckPay(orderNo:String,
                               completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["orderNo":orderNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.netBorrowRechargeCheckPay, handle: completionHandler)
  }
  
  
  ///新的提现接口 提现 amount=金额 verifyNo=校验码 bankId=提现银行ID accountType=账户类型(1=投资账户 2=借款账户)
  class func userDrawMoney(_ amount:String,verifyNo:String,bankId:String,accountType:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["amount":amount,"verifyNo":verifyNo,
                "bankId":bankId,"accountType":accountType]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userDrawMoney, handle: completionHandler)
  }
  
  
}
















