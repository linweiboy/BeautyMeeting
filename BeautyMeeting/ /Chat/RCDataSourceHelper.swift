//
//  RCDataSourceHelper.swift
//  BeautyMeeting
//
//  Created by vint on 2018/3/21.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//


class RCDataSourceHelper: NSObject, RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupUserInfoDataSource, RCIMGroupMemberDataSource, RCIMConnectionStatusDelegate, RCIMReceiveMessageDelegate {
  
  static let shared = RCDataSourceHelper()
  
  //初始化SDK
  func connectRongCloud(token: String!) {
    
    RCIM.shared().initWithAppKey(PlatformKey.RCAppKey)
    
    RCIM.shared().connectionStatusDelegate = self
    RCIM.shared().receiveMessageDelegate = self
    
    //缓存用户信息
    RCIM.shared().enablePersistentUserInfoCache = true
    
    RCIM.shared().connect(withToken: token, success: { (userId) in
      if let dd = userId {
        DispatchQueue.main.async(execute: {
          print("userid = \(dd)")
          RCIM.shared().userInfoDataSource = self
          RCIM.shared().groupInfoDataSource = self
          RCIM.shared().groupMemberDataSource = self
          RCIM.shared().groupUserInfoDataSource = self
          
          
          let userInfo = RCUserInfo(userId: userId, name: "userid1", portrait: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521610824398&di=79a3f8072c320778f7550441bc38f464&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0155055544d5db0000019ae9690b7a.jpg")
          RCIM.shared().currentUserInfo = userInfo
        })
      }
    }, error: { (status) in
      //建立链接失败
    }) {
      //token过期
    }
  }
  
  //监测与融云服务器的链接状态
  func onRCIMConnectionStatusChanged(_ status: RCConnectionStatus) {
    
    print("链接状态改变")
  }
  
  //接收消息的回调方法
  func onRCIMReceive(_ message: RCMessage!, left: Int32) {
    print("message = \(message!), left = \(left), extra = \(message.extra)")
    if message.conversationType == .ConversationType_PRIVATE {
      
    }
  }
  
  func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
    
    RCDataSourceRequest.getUserInfo(withUserId: userId) { (result) in
      switch result {
      case .success(let json):
        
        
        if json["userId"].stringValue == userId {
          
          let userInfo = RCUserInfo(userId: userId, name: json["user_name"].stringValue, portrait: json["user_photo"].stringValue)
          
          //          let userInfo = RCUserInfo(userId: userId, name: "King2", portrait: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521610824398&di=450221f8c02c71ec740c5007a61c3d76&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F07%2F48%2F86458PICG8b.jpg")
          completion(userInfo)
        }
      case .failure( _):
                let userInfo = RCUserInfo(userId: userId, name: "unknow", portrait: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521610824398&di=450221f8c02c71ec740c5007a61c3d76&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F12%2F07%2F48%2F86458PICG8b.jpg")
        completion(userInfo)
      }
    }
  }
  
  func getGroupInfo(withGroupId groupId: String!, completion: ((RCGroup?) -> Void)!) {
    //获取群信息 群头像 名称 群id
    RCDataSourceRequest.getGroupInfo(withGroupId: groupId) { (result) in
      switch result {
      case .success(let json):
        
        if json["groupId"].stringValue == "groupId1" {
          
          let groupInfo = RCGroup(groupId: groupId, groupName: "群1", portraitUri: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521610824398&di=19fb73bae905e6b56a7729007ba92c93&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01eeb056f23b5e32f875a9447e38a4.jpg%401280w_1l_2o_100sh.jpg")
          completion(groupInfo)
        }
      case .failure( _):
        completion(nil)
      }
    }
    
  }
  
  func getUserInfo(withUserId userId: String!, inGroup groupId: String!, completion: ((RCUserInfo?) -> Void)!) {
    
  }
  
  func getAllMembers(ofGroup groupId: String!, result resultBlock: (([String]?) -> Void)!) {
    
  }
  
}
