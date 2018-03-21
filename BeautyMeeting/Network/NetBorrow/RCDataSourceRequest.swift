//
//  RCDataSourceRequest.swift
//  BeautyMeeting
//
//  Created by vint on 2018/3/21.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//


class RCDataSourceRequest: ProtocolRequestUnifyHandle {
  
  class func getUserInfo(withUserId userId: String!, completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: ["userId": userId], urlStr: XZGURL.achieveBannarLink, handle: completionHandler)
  }
  
  class func getGroupInfo(withGroupId groupId: String!, completionHandler: @escaping (RequestResult<JSON>) -> ()) {
    unifyPostRequest(parameter: ["groupId": groupId], urlStr: XZGURL.achieveBannarLink, handle: completionHandler)
  }
  
  
  
  
}
