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

  
  ///获取消息公告 typeCode=业务类型(哪个界面的 notice)
  class func homeNotice(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: ["typeCode":"notice"], urlStr: XZGURL.noticeCode, handle: completionHandler)
  }
  
  
  
  
  ///今日是否签到
  class func homeWhetherIsSign(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeTodaySign, handle: completionHandler)
  }
  
  ///签到
  class func homeSign(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeSign, handle: completionHandler)
  }
  
  
  
  /// 小诸葛新首页 获取应用url列表
  ///
  /// - Parameter completionHandler: 回调
  class func newHomePortal(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.newHomePortal, handle: completionHandler)
  }
}

