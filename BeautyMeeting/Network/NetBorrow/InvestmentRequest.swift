//
//  InvestmentRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/21.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class InvestmentRequest:ProtocolRequestUnifyHandle {
  
  ///获取理财列表 isLimitBeginner=是否包含新手标(这个是bool值) reward=是否有奖励 completionRate=完成度排序(desc 降序 asc 升序)  yearRate=年化收益排序( desc 降序 asc 升序)
  //classify=“credit” 添加了这个字段 接口返回的数据里包括了借呗标的,否则没有(为了区分新旧版本)，在ios 4.0.5以后生效
  class func investmentProductList(_ offset:Int,max:Int,classify:String,isLimitBeginner:String?,reward:String?,completionRate:SortType?,yearRate:SortType?,cycle:SortType?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = [String:String]()
    param["offset"] = offset.stringValue
    param["max"] = max.stringValue
    param["classify"] = classify
    if isLimitBeginner != nil {param["isLimitBeginner"] = isLimitBeginner}
    if reward != nil {param["reward"] = reward}
    if completionRate != nil {param["completionRate"] = completionRate!.rawValue}
    if yearRate != nil {param["yearRate"] = yearRate!.rawValue}
    if cycle != nil {param["cycle"] = cycle!.rawValue}
    unifyPostRequest(parameter: param, urlStr: XZGURL.investList, handle: completionHandler)
  }
  
  
  ///获取产品详情 id=项目id(编号)  type=理财产品种类(目前固定传invest)
  class func investmentProductDetail(_ id:String,type:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id,"type":type]
    unifyPostRequest(parameter: param, urlStr: XZGURL.investProductDetail, handle: completionHandler)
  }
  
  ///获取借呗产品详情 id=项目id(编号)
  class func investmentBorrowProductDetail(_ id:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id]
    unifyPostRequest(parameter: param, urlStr: XZGURL.borrowProductDetail, handle: completionHandler)
  }
  
  ///获取借呗产品项目详情 id=项目id(编号)
  class func investmentBorrowProjectProductDetail(_ id:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id]
    unifyPostRequest(parameter: param, urlStr: XZGURL.borrowProjectDetail, handle: completionHandler)
  }
  
  ///获取借款详情 id=项目id(编号)  type=理财产品种类(目前固定传invest)
  class func investmentBorrowMoneyDetail(_ id:String,type:String,completionHandler:@escaping  (RequestResult<JSON>) -> ()) {
    let param = ["id":id,"type":type]
    unifyPostRequest(parameter: param, urlStr: XZGURL.investBorrowMoneyDetail, handle: completionHandler)
    
  }
  
  ///获取产品的投资记录 id=项目id(编号)  type=理财产品种类(目前固定传invest)
  class func investmentInvestRecord(_ offset:Int,max:Int,id:String,type:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["offset":offset.stringValue,"max":max.stringValue,"id":id,"type":type]
    unifyPostRequest(parameter: param, urlStr: XZGURL.investRecord, handle: completionHandler)
  }
  
  ///获取产品的投资记录前三名 id=项目id(编号)  type=理财产品种类(目前固定传invest)
  class func investmentInvestRecordFirstThree(_ id:String,type:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id,"type":type]
    unifyPostRequest(parameter: param, urlStr: XZGURL.investRecordFirstThree, handle: completionHandler)
  }
  
  ///获取红包列表 cycle=标的期限 cycleType=标的期限类型 classify:标的类型
  ///borrowId=标的id
  class func investmentAchieveCouponList(cycle:String,cycleType:CycleType,
                                         classify:String?,borrowId:String,
                                         completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = [String:String]()
    param["cycle"] = cycle
    param["cycleType"] = cycleType.rawValue
    param["borrowId"] = borrowId
    if classify != nil {param["classify"] = classify!}
    unifyPostRequest(parameter: param, urlStr: XZGURL.investCouponList, handle: completionHandler)
  }
  
  ///账户余额充足时进行投资
  ///用户投资时 充值并投资或者认证充值并投资 前进行创建订单
  ///type=投资类型(invest) objectKey=项目id number=份数 voucherId=红包id amount=投资金额(不减去红包金额的金额)
  class func userInvestForRechargeOrAuthenticationRechargeCreateNewOrder(ct:ClientIdentifier,type:String,objectKey:String,number:String,voucherId:String?,amount:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["ct":ct.rawValue,"type":type,"objectKey":objectKey,
                 "number":number,"amount":amount]
    if voucherId != nil {param["voucherId"] = voucherId}
//    printLog(message: "创建订单请求参数==\(param)")
    unifyPostRequest(parameter: param, urlStr: XZGURL.investCreateNewOrder, handle: completionHandler)
  }
  
  ///计算投资收益 money=投资金额 bid=项目id
  class func userInvestForCalculateIncome(_ money:String,bid:String,voucherId:String?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["money":money,"bid":bid]
    if voucherId != nil {param["voucherId"] = voucherId!}
    unifyPostRequest(parameter: param, urlStr: XZGURL.investinvestIncome, handle: completionHandler)
  }
  
  ///用户投资时 充值并投资或者认证充值并投资 结束后查询订单是否成功
  class func userInvestForRechargeOrAuthenticationRechargeFindOrder(_ tradeNo:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["tradeNo":tradeNo]
    unifyPostRequest(parameter: param, urlStr: XZGURL.investFindOrder, handle: completionHandler)
  }
  
  ///用户确认投资 标的ID:id，投资金额：amount，红包ID：voucherId
  class func userInvestConfirmOn(id:String,amount:String,voucherId:String?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["id":id,"amount":amount]
    if voucherId != nil {
      let voucher_id = voucherId!
      param["voucherId"] = voucher_id
    }
    unifyPostRequest(parameter: param, urlStr: XZGURL.investConfirmOn, handle: completionHandler)
  }
  
  
  /// 智能投顾产品详情
  ///
  /// - Parameters:
  ///   - finaId: 产品id
  ///   - completionHandler: 回调
  class func intelligentInvestProductDetail(finaId:String, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["finaId":finaId]
    unifyPostRequest(parameter: param, urlStr: XZGURL.intelligentInvestProductDetail, handle: completionHandler)
  }
  
  
  /// 智能投顾产品投资激励
  ///
  /// - Parameters:
  ///   - finaId: 项目id
  ///   - offset: 便宜
  ///   - max: 每页多少数据
  ///   - completionHandler: 回调
  class func intelligentInvestProductInvestHistory(finaId:String,
                                                   offset:String,
                                                   max:String,
                                                   completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["finaId":finaId,"offset":offset,"max":max]
    unifyPostRequest(parameter: param, urlStr: XZGURL.intelligentInvestProductInvestHistory, handle: completionHandler)
  }
  
  

  
  
  
  
  
  
  ///诸葛智投计算投资收益 amount=投资金额 finaId=项目id
  class func zhugeInvestForCalculateIncome(_ amount:String,finaId:String,voucherId:String?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["amount":amount,"finaId":finaId]
    if voucherId != nil {param["voucherId"] = voucherId!}
    unifyPostRequest(parameter: param, urlStr: XZGURL.zhugeIncome, handle: completionHandler)
  }
  
}


class BadPropertyRequest: ProtocolRequestUnifyHandle {

  /**
   //获取补不良资产列表
    moneySort: 按金额排序方式：low 从低到高 tall 从高到低
    processMode: 处置方式：1 股权转让 2 物权转让
   */
  class func badPropertyProductList(_ page:Int,size:Int,moneySort:moneySortType?,processMode:processModeType?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = [String:String]()
    //目前不良资产数据一次性返回
//    param["page"] = page.stringValue
//    param["size"] = size.stringValue
    if moneySort != nil {param["moneySort"] = moneySort!.rawValue }
    if processMode != nil {param["processMode"] = processMode!.rawValue }
    unifyPostRequest(parameter: param, urlStr: XZGURL.badPropertyProductList, handle: completionHandler)
  }
  
  //不良资产详情
  class func badPropertyProductDetail(_ id:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id]
    unifyPostRequest(parameter: param, urlStr: XZGURL.badPropertyProductDetail, handle: completionHandler)
  }
  
  //不良资产用户申请信息
  class func badPropertyUploadMassage(_ propertyNumber:String, _ customerName:String, _ phone:String, _ detail:String, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["propertyNumber":propertyNumber,"customerName": customerName, "phone": phone, "detail": detail]
    unifyPostRequest(parameter: param, urlStr: XZGURL.badPropertyUploadMsg, handle: completionHandler)
  }
  
  
  
 

  
  
  
}



















