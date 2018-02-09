//
//  CommonRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/12.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class CommonRequest:ProtocolRequestUnifyHandle {
  
  ///获取bannar code=业务类型(哪个界面的)
  class func commonBannar(_ type:BannarType, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let para = ["code":type.rawValue]
    unifyPostRequest(parameter: para, urlStr: XZGURL.achieveBannarLink, handle: completionHandler)
  }
  
  ///获取统一资源
  class func achieveSystemSource(completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    
    let version = UIDevice.current.systemVersion
    let model = UIDevice.current.model
    let imei = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let manufacturer = "Apple"
    
    let params = ["version":version,"model":model,"imei":imei,"manufacturer":manufacturer]
    unifyPostRequest(parameter: params, urlStr: XZGURL.achieveSystemSource, handle: completionHandler)
  }
  
  ///获取最新版本号
  class func achieveLatestNewVersionNum(_ version:String,client:String,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let para = ["version":version,"client":client]
    unifyPostRequest(parameter: para, urlStr: XZGURL.achieveLatestNewVersionNum, handle: completionHandler)
  }
  
  ///发送用户操作日志数据
  class func uploadUserOperationData(para:Dictionary<String, String>, url: String ,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: para, urlStr: url, handle: completionHandler)
  }
}














