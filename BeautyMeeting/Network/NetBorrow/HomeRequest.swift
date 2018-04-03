//
//  HomeRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/21.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class HomeRequest:ProtocolRequestUnifyHandle {
  
  ///获取bannar code=业务类型(哪个界面的)
  class func homeBanner(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeBanner, handle: completionHandler)
  }
  
  ///最新活动页面活动列表 参数：（status: pre 未开始 pro 进行中 end 已结束）、currentPage 当前页   pageSize每页条数
  class func homeMoreList(status:ActivityType,currentPage:Int,pageSize:Int,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = ["status":status.rawValue,"pageSize":pageSize.stringValue,"currentPage":currentPage.stringValue]
    unifyPostRequest(parameter: param, urlStr: XZGURL.homeMoreList, handle: completionHandler)
  }
  ///首页产品推荐、最新活动
  class func homeProductRecommendation(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    BaseRequest.shared.postRequest(url: XZGURL.homeList, parameters:[:], completionHandler: completionHandler)
  }

  
  /*获取列表 typeCode=业务类型
  消息公告 notice,
  每日美读 dailyreading
  特别推荐 recommend
  节目预报 forecast
  美会商院 businesscollege
  美会介绍 introduce
  美会播报 broadcast
  美会联盟 union)
  */
  class func homeListTypeCode(typeCode:String, completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: ["typeCode":typeCode], urlStr: XZGURL.noticeCode, handle: completionHandler)
  }
  
  
  
  
}

