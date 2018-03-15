//
//  VideoRequest.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/13.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

class VideoRequest:ProtocolRequestUnifyHandle {
  
  ///视频首页列表
  class func videoList(completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.videoHome, handle: completionHandler)
  }

  
  
}
