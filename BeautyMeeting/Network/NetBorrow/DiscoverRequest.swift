//
//  DiscoverRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongtengjituan on 2017/6/5.
//  Copyright © 2017年 rongteng. All rights reserved.
//

class DiscoverRequest:ProtocolRequestUnifyHandle {
  
  ///获取文章列表 typeCode=文章分类  orderByHot=根据阅读数量排序
  class func moreArticleList(_ offset:Int?,max:Int?,typeCode:ArticleListTypeCode?,publishPlatform:PublishPlatform,orderByHot:String?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["publishPlatform":publishPlatform.rawValue]
    if offset != nil { param["offset"] = offset!.stringValue}
    if max != nil {param["max"] = max!.stringValue}
    if typeCode != nil  {param["typeCode"] = typeCode!.rawValue}
    if orderByHot != nil {param["orderByHot"] = orderByHot!}
    unifyPostRequest(parameter: param, urlStr: XZGURL.commonArticleList, handle: completionHandler)
  }
  
  ///获取文章详情 itemId=文章编号
  class func moreArticleDetail(_ itemId:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["itemId":itemId]
    unifyPostRequest(parameter: param, urlStr: XZGURL.moreArticleDetail, handle: completionHandler)
  }
  
  
  
  ///上传图片    file=要上传的图片文件 version	=对应APP版本号 png格式图片
  class func moreUpLoadPicture(_ fileData:Data,version:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["version":version]
    unifyUpload(parameter: param, urlStr: XZGURL.moreSetUpPicture, data: fileData, handle: completionHandler)
  }
  
  ///意见反馈content=内容 不能超过1000字   imgUrl	= 图片 contactWay=联系方式，
  class func moreSuggestUpload(_ content:String,client:String,imgUrl:[String]?,contactWay:String?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = ["content":content,"client":client]
    if let contactWay = contactWay,!contactWay.isEmpty {
      param["contactWay"] = contactWay
    }
    if let imgUrl = imgUrl { param["imgUrl"] = String(describing: imgUrl)}
    unifyPostRequest(parameter: param, urlStr: XZGURL.moreFeedbackSuggest, handle: completionHandler)
  }
  
  //提交我要借款用户信息
  class func commintUserInformation(param:Dictionary<String, String>, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: param, urlStr: XZGURL.postUserInformation, handle: completionHandler)
  }
  
  
  
  ///我的借款--已发布
  class func myLoanForAlreadyReleased(_ offset:Int?,max:Int?, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = [String:String]()
    if offset != nil { param["offset"] = offset!.stringValue}
    if max != nil {param["max"] = max!.stringValue}
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanAlreadyReleased, handle: completionHandler)
  }
  
  ///我的借款--已还清
  class func myLoanForPainOff(_ offset:Int?,max:Int?,completionHandler:@escaping (RequestResult<JSON>) -> ()){
    var param = [String:String]()
    if offset != nil { param["offset"] = offset!.stringValue}
    if max != nil {param["max"] = max!.stringValue}
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanPaidOff, handle: completionHandler)
  }
  
  ///我的借款--待还款
  class func myLoanForWaitPainLoan(_ offset:Int?,max:Int?,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    var param = [String:String]()
    if offset != nil { param["offset"] = offset!.stringValue}
    if max != nil {param["max"] = max!.stringValue}
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanWaitPain, handle: completionHandler)
  }
  
  ///我的借款--待还款项目
  class func myLoanRepayment(id: String, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["id":id]
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanRepayment, handle: completionHandler)
  }
  
  ///我的借款--申请还款  bid=用户名,period	=还款期数,outPassword	=交易密码,type=还款类型
  class func myLoanApplyForRepayment(bid:String, period:String, outPassword:String,type:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["bid":bid,"period":period,"outPassword":outPassword,"type":type]
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanApplyForRepayment, handle: completionHandler)
  }
  
  ///我的借款--还款计划 id=标的的ID
  class func myLoanRepaymentPlan(id:String,completionHandler:@escaping (RequestResult<JSON>) -> ()){
    let param = ["id":id]
    unifyPostRequest(parameter: param, urlStr: XZGURL.userMyLoanPayPlan, handle: completionHandler)
  }
  
  ///发现页面
  class func discoverHome(completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.discoverHome, handle: completionHandler)
  }
  
  ///发现页面活动列表 参数：（status: pre 未开始 pro 进行中 end 已结束）、currentPage 当前页   pageSize每页条数
  class func discoverList(status:ActivityType,currentPage:Int,pageSize:Int,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["status":status.rawValue,"pageSize":pageSize.stringValue,"currentPage":currentPage.stringValue]
    unifyPostRequest(parameter: param, urlStr: XZGURL.discoverList, handle: completionHandler)
  }
  
}




