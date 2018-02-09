//
//  HomeRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/21.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class HomeRequest:ProtocolRequestUnifyHandle {
  
  ///获取bannar code=业务类型(哪个界面的)
  class func homeProduct(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeProduct, handle: completionHandler)
  }
  
  ///今日是否签到
  class func homeWhetherIsSign(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeTodaySign, handle: completionHandler)
  }
  
  ///签到
  class func homeSign(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.homeSign, handle: completionHandler)
  }
  
  ///首页产品推荐、最新活动 bt=业务标识（已定义BusinessIdentifier），ct=客户端标识（1指iOS客户端）
  class func homeProductRecommendation(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    let param = ["bt":"0","ct":"1"]
    BaseRequest.shared.postRequest(url: XZGURL.homeList, parameters: param, completionHandler: completionHandler)
  }
  
  
  /// 小诸葛新首页 获取应用url列表
  ///
  /// - Parameter completionHandler: 回调
  class func newHomePortal(completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.newHomePortal, handle: completionHandler)
  }
}

