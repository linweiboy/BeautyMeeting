////
////  OpenUrlVC.swift
////  XiaoZhuGeJinFu
////
////  Created by rongteng on 2017/7/6.
////  Copyright © 2017年 rongteng. All rights reserved.
////
//
//import JavaScriptCore
//import WebKit
//
//class OpenUrlVC: UIViewController,PopVCSetProtocol,VcDefaultConfigProtocol,
//LoadingPresenterProtocol,LoginExpiredProtocol  {
//  
//  var navItemTitle:String?
//  var loadUrl:String!
//  
//  fileprivate let wkWebView = WKWebView()
//  fileprivate let wkUserContent = WKUserContentController()
//  
//  fileprivate var rightButtonItem:UIBarButtonItem!
//  fileprivate var rightView:UIView!
//  fileprivate var closeVCBT:UIButton!
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    defaultConfig()
//    addShowViews()
//    loadCurrentUrl()
//  }
//  
//  @objc func backLastVC() {
//    wkWebView.canGoBack ? _ = wkWebView.goBack() : backLastPage()
//  }
//  
//  @objc func backLastPage() {
//    let url = MallURL.server.currentUrl + MallURL.drawPrize
//    if loadUrl == url {
//      NotificationCenterHelper.refreshUserAssetInfo()
//    }
//    popToLastVC()
//  }
//  
//  func loadCurrentUrl() {
//    let accesstoken = AccountManage.shared.currentAccount()?.accessToken ?? "token"
//    guard let url = URL(string: loadUrl) else {
//      showMessage("数据加载错误！")
//      return
//    }
//    let request = NSMutableURLRequest(url: url)
//    request.setValue("rongteng-ios", forHTTPHeaderField: "rongteng")
//    request.setValue(accesstoken, forHTTPHeaderField: "x-auth-token")
//    wkWebView.load(request as URLRequest)
//  }
//  
//  //MARK: 添加子视图
//  func addShowViews() {
//    rightView = decorateRightNavImage("home_urlShare", clickSelector: #selector(shareUrl))
//    rightView.isHidden = true
//    
//    func setLeftNavView() {
//      let leftView = UIView()
//      leftView.backgroundColor = .clear
//      leftView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 70, height: 44))
//      
//      //返回按钮
//      let backBT = UIButton(type: .custom)
//      leftView.addSubview(backBT)
//      backBT.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 44))
//      let backImage = UIImage(named: "Nav_Back")!.withRenderingMode(.automatic)
//      backBT.setImage(backImage, for: .normal)
//      backBT.addTarget(self, action: #selector(backLastVC), for: .touchUpInside)
//      
//      //关闭按钮
//      closeVCBT = UIButton(type: .custom)
//      leftView.addSubview(closeVCBT)
//      let closeVCBTPoint = CGPoint(x: 40, y: 0)
//      let closeVCBTSize = CGSize(width: 30, height: 44)
//      closeVCBT.frame = CGRect(origin: closeVCBTPoint, size: closeVCBTSize)
//      let closeVCBTImage = UIImage(named: "closeWebageImage")!
//      closeVCBT.setImage(closeVCBTImage, for: .normal)
//      closeVCBT.addTarget(self, action: #selector(backLastPage), for: .touchUpInside)
//      closeVCBT.isHidden = true
//      decorateLiftNavView(leftView)
//    }
//    setLeftNavView()
//    
//    self.view.addSubview(wkWebView)
//    wkWebView.navigationDelegate = self
//    wkWebView.uiDelegate = self
//    wkWebView.scrollView.showsVerticalScrollIndicator = false
//    wkWebView.snp.makeConstraints { (make) in
//      make.top.left.bottom.right.equalTo(self.view)
//    }
//  }
//  
//  //设置只有主页显示导航栏
//  func hiddenNavigationBarOfOtherWebView(webUrl: URL?) {
//    guard let loadUrl = loadUrl, let url = webUrl?.absoluteString else {
//      return
//    }
//    if url != loadUrl {
//      self.navigationController?.setNavigationBarHidden(true, animated: true)
//      wkWebView.snp.updateConstraints({ (make) in
//        make.top.equalTo(20)
//      })
//    } else {
//      self.navigationController?.setNavigationBarHidden(false, animated: true)
//      wkWebView.snp.updateConstraints({ (make) in
//        make.top.equalTo(self.view)
//      })
//    }
//  }
//  
//  //清除缓存
//  func clearCache() {
//    let dateFrom = Date(timeIntervalSince1970: 0)
//    if #available(iOS 9.0, *) {
//      let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes() as NSSet
//      WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: dateFrom, completionHandler: {})
//    } else {
//      let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
//      let cookiesFolderPath = libraryPath + "/Cookies"
//      try? FileManager.default.removeItem(atPath: cookiesFolderPath)
//    }
//  }
//  
//}
//
//
//extension OpenUrlVC: WKNavigationDelegate  {
//  
//  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//    guard let url = navigationAction.request.url else {
//      decisionHandler(.cancel)
//      return
//    }
//    
//    let absoluteStr = url.absoluteString
//    if absoluteStr.hasPrefix("tel:") {
//      let telNum = absoluteStr.range(of: "tel:")!
//      let result = String(absoluteStr[telNum.upperBound...])
//      AccessSystem.callTelephony(result)
//      decisionHandler(.cancel)
//    }
//    decisionHandler(.allow)
//  }
//  
//  
//  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//    hiddenLoadingView()
//    //确定分享按钮是否出来
//    webView.evaluateJavaScript(ShareContent_jsScript) { [unowned self] (result, error) in
//      if let str = result as? String {
//        self.rightView.isHidden = str.isEmpty ? true:false
//      }
//    }
//    //确定关闭按钮是否出来
//    closeVCBT.isHidden = webView.canGoBack ? false:true
//    
//    //确定导航栏标题
//    webView.evaluateJavaScript("document.title") { (result, error) in
//      if let titleStr = result as? String {
//        self.navigationItem.title = titleStr
//      }
//    }
//    
//  }
//  
//  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//    hiddenLoadingView()
//    showMessage("网络错误!")
//  }
//  
//  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//    showLoadingView(nil)
//  }
//
//}
//
//extension OpenUrlVC: WKUIDelegate {
//  
//  func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
//    let alertV = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
//    alertV.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler:
//      { (ac) -> Void in
//        completionHandler(true)
//    }))
//    alertV.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:
//      { (ac) -> Void in
//        completionHandler(false)
//    }))
//    present(alertV, animated: true, completion: nil)
//  }
//  
//  func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//    showMessage(message)
//    completionHandler()
//  }
//}
//
//
//extension OpenUrlVC {
//  
//  //导航栏右上角 点击分享 出来的页面
//  @objc func shareUrl() {
//    let frame = CGRect(origin:.zero, size: CGSize(width:ScreenWidth,height:140))
//    let footShareView = UrlShareViewFromBottom(frame: frame)
//    footShareView.passClickClosure = { [unowned self] tag in
//      SocialShareHelp.shareUrlWithTag(tag: tag, wkWebView: self.wkWebView, showMessage: self)
//    }
//    footShareView.showView()
//  }
//}
//
//
////H5内部 点击分享 弹出的页面
//extension OpenUrlVC {
//  
//  func refreshInviteData() {
//    guard AccountManage.shared.isLogin else {
//      AppDelegate.shared.mainVC.presentLoginVC()
//      return
//    }
//    UserRequest.userInviteFriendDetail() { (result) in
//      switch result {
//      case .success(let json):
//        let inviteModel = InviteFriendsModel(json: json["data"])
//        self.shareContent(model: inviteModel)
//      case .failure(let error):
//        self.showMessage(error.reason)
//        if error.code == loginExpireCode {
//          self.loginSucceed(self.refreshInviteData)
//        }
//      }
//    }
//  }
//  
//  func shareContent(model:InviteFriendsModel) {
//    let frame = CGRect(origin:.zero, size: CGSize(width:ScreenWidth,height:100))
//    let footShareView = InviteShareViewFromBottom(frame: frame)
//    footShareView.passClickClosure = { [unowned self] tag in
//      self.platFormClick(tag:tag,model:model)
//    }
//    footShareView.showView()
//  }
//  
//  
//  //分享到 查看二维码
//  func platFormClick(tag:Int,model:InviteFriendsModel) {
//    switch tag {
//    case 1,2: shareTo(tag:tag,model:model)
//    case 3:
//      let twoDimensionalVC = TwoDimensionalVC()
//      twoDimensionalVC.userShareUrl = model.recommendUrl
//      pushTo(twoDimensionalVC)
//    default:break
//    }
//    
//  }
//  
//  func shareTo(tag:Int,model:InviteFriendsModel) {
//    
//    if !WXApi.isWXAppInstalled() {
//      showMessage("您未安装微信客户端!")
//      return
//    }
//    
//    let image = UIImage(named: "account_share")
//    //微信好友
//    if tag == 1 {
//      WenXinShareHelper.sendLinkURL(urlString: model.recommendUrl, tagName: nil, title: model.shareTitle, description: model.shareContent, thumbImage: image!, scene: WXSceneSession)
//    }
//    
//    if tag == 2 {
//      WenXinShareHelper.sendLinkURL(urlString: model.recommendUrl, tagName: nil, title: model.shareTitle, description: model.shareContent, thumbImage: image!, scene: WXSceneTimeline)
//    }
//    
//  }
//  
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
