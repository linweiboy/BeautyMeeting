//
//  UserRequest.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/21.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//登录注册 请求 相关
class UserRequest:ProtocolRequestUnifyHandle {
  
//  ///登录和注册流程 发送验证码 手机号码=mobile
//  class func userSendVerifyNumForLoginAndRegister(_ mobile:String,voice:BoolParameter, completionHandler:@escaping (RequestResult<JSON>)->()) {
//    let para = ["mobile":mobile,"voice":voice.rawValue]
//    unifyPostRequest(parameter: para, urlStr: XZGURL.sendVerify_LoginAndRegister, handle: completionHandler)
//  }
  
  ////会员申请
  class func userMemberApply(_ realName:String,sex:String,idCard:String,address:String,referrer_mobile:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["realName":realName,"sex":sex,"idCard":idCard,"address":address,"referrer_mobile":referrer_mobile]
    unifyPostRequest(parameter: para, urlStr: XZGURL.memberApply, handle: completionHandler)
  }
  
  ///登录 username=用户名 password=密码
  class func userLogin(_ mobile:String,password:String,
                       completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"password":password]
    unifyPostRequest(parameter: para, urlStr: XZGURL.login, handle: completionHandler)
  }
  
  
  ///注册 mobile=注册手机号 password=密码 手机验证码=verifyNo 邀请人手机号码(邀请码)=referrer(可选)
  class func userRegister(_ mobile:String,password:String,verifyNo:String,referrer:String?, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"password":password,"verifyNo":verifyNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.register, handle: completionHandler)
  }
  
  
  ///找回登录密码 手机号码=mobile  验证码=code  newPwd=新密码
  class func userResetLoginPassword(_ mobile:String,code:String,newPwd:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"code":code,"newPwd":newPwd]
    unifyPostRequest(parameter: para, urlStr: XZGURL.resetLoginPassword, handle: completionHandler)
  }
  
  class func userModifyLoginPassword(_ mobile:String,oldPwd:String,newPwd:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["mobile":mobile,"oldPwd":oldPwd,"newPwd":newPwd]
    unifyPostRequest(parameter: para, urlStr: XZGURL.resetLoginPassword, handle: completionHandler)
  }
  
}


//用户信息 请求 相关
extension UserRequest {
  
  ///修改登录密码 oldPassword=旧密码  newPassword=新密码
  class func userModifyLoginPassword(oldPassword:String,newPassword:String, completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["oldPassword":oldPassword,"newPassword":newPassword]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userModifyLoginPassword, handle: completionHandler)
  }
  
  
  
  
  
  
  ///修改用户名 userName=新用户名
  class func userModifyUserName(_ userName:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["userName":userName]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userSetModifyUserName, handle: completionHandler)
  }
  
  ///获取用户手机号码 authNo=原手机手机验证码 mobile=新手机号 verifyNo=新手机手机验证码
  class func userModifyUserPhoneNumber(_ authNo:String,mobile:String,verifyNo:String,completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["authNo":authNo,"mobile":mobile,"verifyNo":verifyNo]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userSetModifyUserPhoneNumber, handle: completionHandler)
  }
  
}

//用户资产信息 相关
extension UserRequest {
  
  ///邀请好友详情
  class func userInviteFriendDetail(completionHandler:@escaping (RequestResult<JSON>)->()) {
    unifyPostRequest(parameter: [:], urlStr: XZGURL.userInviteFriendDetail, handle: completionHandler)
  }
  
  
  ///邀请好友详情
  class func userInviteFriendList(_ offset:Int,max:Int,type:String,
                                  completionHandler:@escaping (RequestResult<JSON>)->()) {
    let para = ["offset":offset.stringValue,"max":max.stringValue,"type":type]
    unifyPostRequest(parameter: para, urlStr: XZGURL.userInviteFriendList, handle: completionHandler)
  }
  
  
}
















