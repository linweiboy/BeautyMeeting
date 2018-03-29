//
//  OpenHtmlVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/7/6.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import WebKit

class OpenHtmlVC: UIViewController,PopVCSetProtocol,VcDefaultConfigProtocol {
  
  var navItemTitle:String?
  var htmlContent:String?
  
  fileprivate var contentWebView:WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = navItemTitle ?? ""
    defaultConfig()
    popLastPage()
    addShowViews()
  }
  
  func addShowViews() {
    contentWebView = WKWebView()
    self.view.addSubview(contentWebView)
    contentWebView.backgroundColor = .white
    contentWebView.isOpaque = false
    contentWebView.navigationDelegate = self
    contentWebView.snp.makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    if let content = htmlContent {
      contentWebView.loadHTMLString(content, baseURL: nil)
    }
  }
  
}

// MARK: - WKNavigationDelegate -
extension OpenHtmlVC: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    //统一放大html里文字的大小
    if webView == contentWebView {
      let fontBig = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"
      contentWebView.evaluateJavaScript(fontBig, completionHandler: nil)
      let colorValue = "document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#4c4c4c'"
      contentWebView.evaluateJavaScript(colorValue, completionHandler: nil)
    }
  }
}
