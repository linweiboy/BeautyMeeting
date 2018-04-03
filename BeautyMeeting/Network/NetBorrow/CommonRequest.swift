//
//  CommonRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/12.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class CommonRequest:ProtocolRequestUnifyHandle {
  
  ///发送用户操作日志数据
  class func uploadUserOperationData(para:Dictionary<String, String>, url: String ,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: para, urlStr: url, handle: completionHandler)
  }
}














