//
//  SocialShareHelper.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/9/10.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation

//class XinLangShareHelper: NSObject,WeiboSDKDelegate {
//  
//  internal static let shared = XinLangShareHelper()
//  
//  func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
//    print("新浪请求我==\(request.userInfo)")
//  }
//  
//  func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
//    print("新浪回调==\(response.requestUserInfo)")
//  }
//  
//  public class func sendMessage(urlStr:String,title:String,description:String) {
//    let message = WBMessageObject.message() as! WBMessageObject
//    message.text = description  //填写的内容
//    
//    //        let imageOB = WBImageObject.object() as!  WBImageObject
//    //        imageOB.imageData = UIImagePNGRepresentation(UIImage(named:"account_share")!)
//    //        message.imageObject = imageOB
//    
//    let mediaOB = WBWebpageObject.object() as! WBWebpageObject
//    mediaOB.title = title //图片标题
//    mediaOB.objectID = "1"
//    mediaOB.description = description //图片描述
//    mediaOB.webpageUrl = urlStr
//    //压缩的图片
//    mediaOB.thumbnailData = UIImagePNGRepresentation(UIImage(named:"account_share")!)
//    message.mediaObject = mediaOB
//    let request = WBSendMessageToWeiboRequest.request(withMessage: message) as! WBSendMessageToWeiboRequest
//    WeiboSDK.send(request)
//  }
//  
//  
//}
//
//
//class QQShareHelper: NSObject,TencentSessionDelegate,QQApiInterfaceDelegate {
//  
//  internal static let shared = QQShareHelper()
//  
//  //MARK:TencentSessionDelegate
//  func tencentDidLogin() {
//    
//  }
//  
//  func tencentDidNotLogin(_ cancelled: Bool) {
//    
//  }
//  
//  func tencentDidNotNetWork() {
//    
//  }
//  
//  
//  func onReq(_ req: QQBaseReq!) {
//    
//  }
//  
//  func onResp(_ resp: QQBaseResp!) {
//    let eCode = resp.errorDescription as String
//    print("qqq分享==\(eCode)")
//    //        switch eCode {
//    //        case 0:showMessage("分享成功！")
//    //        case -2:showMessage("取消分享！")
//    //        case -3:showMessage("发送失败！")
//    //        case -5:showMessage("微信不支持！")
//    //        default:break
//    //        }
//    //
//  }
//  
//  func isOnlineResponse(_ response: [AnyHashable : Any]!) {
//    
//  }
//  
//  public class func sendMessage(urlStr:String,title:String,description:String,isToQzone:Bool) {
//    
//    guard QQApiInterface.isQQInstalled()  else {
//      AppDelegate.shared.mainVC.showMessage("您未安装QQ！")
//      return
//    }
//    
//    let shareImage = UIImage(named: "account_share")
//    let imageData = UIImagePNGRepresentation(shareImage!)
//    let urlOb = QQApiURLObject(url: URL(string:urlStr), title:title, description: description, previewImageData: imageData, targetContentType: QQApiURLTargetTypeNews)
//    let rep = SendMessageToQQReq(content: urlOb)
//    var sendResult = QQApiSendResultCode.init(-1)
//    if isToQzone {
//      sendResult = QQApiInterface.sendReq(toQZone: rep)
//    } else {
//      sendResult = QQApiInterface.send(rep)
//    }
//    switch sendResult {
//    case QQApiSendResultCode.init(0):
//      AppDelegate.shared.mainVC.showMessage("分享成功！")
//    default:
//      AppDelegate.shared.mainVC.showMessage("分享失败！")
//    }
//    
//    
//  }
//  
//  
//}
//
//
//class WenXinShareHelper:NSObject,WXApiDelegate {
//  
//  internal static let shared = WenXinShareHelper()
//  
//  //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
//  func onReq(_ req: BaseReq!) {
//    
//  }
//  
//  //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
//  func onResp(_ resp: BaseResp!) {
//    let eCode = resp.errCode
//    let mainTb = AppDelegate.shared.mainVC
//    switch eCode {
//    case 0:mainTb.showMessage("分享成功！")
//    case -2:mainTb.showMessage("取消分享！")
//    case -3:mainTb.showMessage("发送失败！")
//    case -5:mainTb.showMessage("微信不支持！")
//    default:break
//    }
//    
//  }
//  
//  
//  @discardableResult
//  class func sendLinkURL(urlString:String,tagName:String?,title:String,
//                         description:String,thumbImage:UIImage,scene:WXScene) -> Bool {
//    
//    let ext = WXWebpageObject()
//    ext.webpageUrl = urlString
//    let message = messageWithTitle(title: title, description: description, mediaObject: ext, messageExt: nil, action: nil, thumbImage: thumbImage, mediaTag: tagName)
//    let req = requestWithText(text: nil, message: message, bText: false, scene: scene)
//    return WXApi.send(req)
//    
//  }
//  
//  class func messageWithTitle(title:String,description:String,mediaObject:AnyObject,
//                              messageExt:String?,action:String?,thumbImage:UIImage,
//                              mediaTag:String?) -> WXMediaMessage {
//    let message = WXMediaMessage()
//    message.title = title;
//    message.description = description
//    message.mediaObject = mediaObject
//    message.messageExt = messageExt
//    message.messageAction = action
//    message.setThumbImage(thumbImage)
//    return message
//  }
//  
//  class func requestWithText(text:String?,message:WXMediaMessage,bText:Bool,scene:WXScene) -> SendMessageToWXReq {
//    let req = SendMessageToWXReq()
//    req.bText = bText
//    req.scene = Int32(UInt32(scene.rawValue))
//    if bText {
//      req.text = text;
//    }else {
//      req.message = message;
//    }
//    return req;
//  }
//  
//  
//  
//}

