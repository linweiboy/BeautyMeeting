////
////  SocialShareHelp.swift
////  XiaoZhuGeJinFu
////
////  Created by rongteng on 2017/10/9.
////  Copyright © 2017年 rongteng. All rights reserved.
////
//
//import WebKit
//
//class SocialShareHelp {
//  
//  class func shareUrlWithTag(tag:Int,wkWebView:WKWebView,
//                             showMessage:LoadingPresenterProtocol) {
//    wkWebView.evaluateJavaScript("document.location.href") { (result, error) in
//      if let urlStr = result as? String {
//        getTitleUseUrl(urlStr)
//      }
//    }
//    
//    func getTitleUseUrl(_ url:String) {
//      wkWebView.evaluateJavaScript("document.title") { (result, error) in
//        if let titleStr = result as? String {
//          getContentUseUrlAndTitle(url, title: titleStr)
//        }
//      }
//    }
//    
//    func getContentUseUrlAndTitle(_ url:String,title:String) {
//      wkWebView.evaluateJavaScript(ShareContent_jsScript) { (result, error) in
//        if let contentStr = result as? String {
//          shareTo(tag: tag, title: title, content: contentStr, url: url)
//        }
//      }
//    }
//    
//    func shareTo(tag:Int,title: String, content: String, url: String) {
//      switch tag {
//      case 1,2:shareUrlToWeiXin(tag: tag, title: title, content: content, url: url,showMessage:showMessage)
//      case 3:shareUrlToQQ(title: title, content: content, url: url)
//      case 4:shareUrlToXinLang(title: title, content: content, url: url)
//      default:break
//      }
//    }
//  }
//  
//  //分享到微信
//  fileprivate class func shareUrlToWeiXin(tag:Int,title:String,
//                                          content:String,url:String,
//                                          showMessage:LoadingPresenterProtocol) {
//    if !WXApi.isWXAppInstalled() {
//      showMessage.showMessage("您未安装微信客户端!")
//      return
//    }
//    let image = UIImage(named: "account_share")
//    //微信好友
//    if tag == 1 {
//      WenXinShareHelper.sendLinkURL(urlString:url, tagName: nil, title: title, description: content, thumbImage: image!, scene: WXSceneSession)
//    }
//    if tag == 2 {
//      WenXinShareHelper.sendLinkURL(urlString:url, tagName: nil, title:title, description: content, thumbImage: image!, scene: WXSceneTimeline)
//    }
//  }
//  
//  //分享到qq
//  fileprivate class func shareUrlToQQ(title:String,content:String,url:String) {
//    QQShareHelper.sendMessage(urlStr: url, title: title, description: content,isToQzone: false)
//  }
//  
//  //分享到新浪
//  fileprivate class func shareUrlToXinLang(title:String,content:String,url:String) {
//    XinLangShareHelper.sendMessage(urlStr: url, title: title, description: content)
//  }
//  
//  
//  
//  
//}
//
