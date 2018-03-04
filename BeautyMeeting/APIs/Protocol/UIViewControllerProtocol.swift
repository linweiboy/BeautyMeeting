//
//  UIViewControllerProtocol.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import MBProgressHUD

//MARK: - UIViewController默认配置
protocol VcDefaultConfigProtocol {
  func defaultConfig()
}

extension VcDefaultConfigProtocol where Self:UIViewController {
  
  func defaultConfig() {
    self.view.backgroundColor =  .backGround
    self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
}


//MARK: 登录过期 弹出登录视图
protocol LoginExpiredProtocol {
  func loginSucceed(_ action:(()->())?)
}

extension LoginExpiredProtocol where Self:UIViewController {
  func loginSucceed(_ action:(()->())?)  {
    let login = LoginVC()
    if action != nil {
      login.loginSucceedClosure = { action!() }
    }
    let nav = UINavigationController(rootViewController: login)
    present(nav, animated: true, completion: nil)
  }

}
//
//
////MARK:- 加载更多数据和 下拉刷新数据
//protocol LoadMoreDataProtocol:class {
//  associatedtype T:ProtocolParseModelList
//  var mainTableView:UITableView! {get set}
//  var dataList:[T.type]! {get set} //放置数据的数组
//  var currentOffset:Int! {get set} //默认要赋值为0
//
//  //刷新数据要调用这个方法 action是refreshPrepare执行完之后 再执行的动作
//  func refreshPrepare()
//  func handleData(_ json:JSON)
//  func handleDataList(_ json:JSON)
//  func showNoDataView()
//}
//
//extension LoadMoreDataProtocol where Self:UIViewController {
//
//  //json["data"]
//  func handleData(_ json:JSON) {
//    let resultModelArray = T.parseListForData(json)
//    commonHandle(originJson: json, arr: resultModelArray)
//  }
//
//  //json["data"]["list"]
//  func handleDataList(_ json:JSON) {
//    let resultModelArray = T.parseListForDataList(json)
//    commonHandle(originJson: json, arr: resultModelArray)
//  }
//
//  func commonHandle(originJson:JSON,arr:[T.type]) {
//    let common = CommonModel(json: originJson)
//    let totalCount = common.totalCount
//    if mainTableView.mj_header.isRefreshing {
//      dataList.removeAll()
//    }
//    if !arr.isEmpty {
//      dataList.append(contentsOf: arr)
//    }
//    let footIsHi = currentOffset!+DataOfPageNum < totalCount
//    mainTableView.mj_footer.isHidden = !footIsHi
//    mainTableView.reloadData()
//    showNoDataView()
//  }
//
//  //默认没有可点击button  如需定制 只需要在遵守协议的类里重写这个方法即可
//  func showNoDataView() {
//    if dataList.count == 0 {
//      mainTableView.addNoDataView(title: "暂无数据！", btTitle: nil, btClick: nil)
//    }else {
//      mainTableView.removeNoDataView()
//    }
//  }
//
//  func refreshPrepare() {
//    if mainTableView.mj_header.isRefreshing {
//      currentOffset = 0
//    }
//    if mainTableView.mj_footer.isRefreshing {
//      currentOffset = currentOffset+DataOfPageNum
//    }
//  }
//
//}
//
////MARK:- 加载更多数据和 下拉刷新数据
//protocol GuoHuaiLoadMoreDataProtocol:class {
//
//  associatedtype T:ProtocolParseGuoHuaiModelList
//  var mainTableView:UITableView! {get set}
//  var dataList:[T.type]! {get set} //放置数据的数组
//  var currentPage:Int! {get set} //默认要赋值为0
//
//  //刷新数据要调用这个方法 action是refreshPrepare执行完之后 再执行的动作
//  func refreshPrepare()
//  func handleData(_ json:JSON)
//}
//
//extension GuoHuaiLoadMoreDataProtocol where Self:UIViewController {
//
//  func refreshPrepare() {
//    if mainTableView.mj_header.isRefreshing {
//      currentPage = 1
//    }
//    if mainTableView.mj_footer.isRefreshing {
//      currentPage = currentPage+1
//    }
//  }
//
//  func handleData(_ json:JSON) {
//    let common = GuoHuaiStatusModel(json: json)
//    let totalCount = common.total
//    let resultModelArray = T.parseList(json)
//
//    if !resultModelArray.isEmpty {
//      if mainTableView.mj_header.isRefreshing {
//        dataList.removeAll()
//      }
//      dataList.append(contentsOf: resultModelArray)
//      if dataList.count < totalCount {
//        mainTableView.mj_footer.isHidden = false
//      }else {
//        mainTableView.mj_footer.isHidden = true
//      }
//    }
//    mainTableView.reloadData()
//    showNoDataView()
//  }
//
//  func showNoDataView() {
//    if dataList.count == 0 {
//      mainTableView.addNoDataView(title: "暂无数据！", btTitle: nil, btClick: nil)
//    }else {
//      mainTableView.removeNoDataView()
//    }
//  }
//
//}
//
////MARK:- 加载更多数据和 下拉刷新数据自定制添加无数据视图
////protocol LoadMoreDataForCustomAddNoDataViewProtocol:class {
////  associatedtype T:ProtocolParseModelList
////  var mainTableView:UITableView! {get set}
////  var dataList:[T.type]! {get set} //放置数据的数组
////  var currentOffset:Int! {get set} //默认要赋值为0
////
////  //刷新数据要调用这个方法 action是refreshPrepare执行完之后 再执行的动作
////  func refreshPrepare()
////  func handleData(_ json:JSON)
////  func handleDataList(_ json:JSON)
////}
////
////extension LoadMoreDataForCustomAddNoDataViewProtocol where Self:UIViewController {
////
////
////  //json["data"]
////  func handleData(_ json:JSON) {
////    let resultModelArray = T.parseListForData(json)
////    commonHandle(originJson: json, arr: resultModelArray)
////  }
////
////  //json["data"]["list"]
////  func handleDataList(_ json:JSON) {
////    let resultModelArray = T.parseListForDataList(json)
////    commonHandle(originJson: json, arr: resultModelArray)
////  }
////
////  func commonHandle(originJson:JSON,arr:[T.type]) {
////    let common = CommonModel(json: originJson)
////    let totalCount = common.totalCount
////    if !arr.isEmpty {
////      if mainTableView.mj_header.isRefreshing {
////        dataList.removeAll()
////      }
////      dataList.append(contentsOf: arr)
////    }
////    let footIsHi = currentOffset!+DataOfPageNum < totalCount
////    mainTableView.mj_footer.isHidden = !footIsHi
////    mainTableView.reloadData()
////  }
////
////  func refreshPrepare() {
////    if mainTableView.mj_header.isRefreshing {
////      currentOffset = 0
////    }
////    if mainTableView.mj_footer.isRefreshing {
////      currentOffset = currentOffset+DataOfPageNum
////    }
////  }
////
////}
//
//MARK:- 提示框

extension UIViewController {
  fileprivate struct MBProgressKeys {
    static var forView     = "MBProgressViewKey"
    static var forWindow   = "MBProgressWindowKey"
  }
}

protocol LoadingPresenterProtocol:class {

  //在VC的view上
  func showLoadingView(_ text:String?)
  func hiddenLoadingView()
  func showMessage(_ msg:String)

  //在window上
  func showLoadingViewOnWindow(_ text:String?)
  func hiddenLoadingViewOnWindow()
  func showMessageOnWindow(_ msg:String)

}

extension LoadingPresenterProtocol where Self:UIViewController {

  func customHudStyle(_ hud:MBProgressHUD) {
    hud.animationType = .zoom
    hud.offset.y =  hud.offset.y - 50
    hud.mode = .text
    hud.detailsLabel.font = UIFont.systemFont(ofSize: 12.ratioHeight)
    hud.margin = 10
    hud.bezelView.backgroundColor = UIColor.black
    hud.contentColor = UIColor.white
    hud.removeFromSuperViewOnHide = true
    hud.hide(animated: true, afterDelay: 1.5)
  }

  //在view上显示MBProgressHUD
  func showLoadingView(_ text:String?) {
    let loadingView = objc_getAssociatedObject(self, &MBProgressKeys.forView)
    guard let loadingV =  loadingView as? MBProgressHUD else {
      let oneLoadingView = MBProgressHUD(view: self.view)
      oneLoadingView.bezelView.backgroundColor = .black
      oneLoadingView.contentColor = .white
      oneLoadingView.offset.y = oneLoadingView.offset.y - 50
      oneLoadingView.removeFromSuperViewOnHide = true
      if let tx = text {
        oneLoadingView.detailsLabel.text = tx
      }
      objc_setAssociatedObject(self, &MBProgressKeys.forView, oneLoadingView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      self.view.addSubview(oneLoadingView)
      oneLoadingView.show(animated: true)
      return
    }
    self.view.addSubview(loadingV)
    loadingV.show(animated: true)
  }

  func hiddenLoadingView() {
    let loadingView = objc_getAssociatedObject(self, &MBProgressKeys.forView)
    guard let loadingV = loadingView as? MBProgressHUD else {
      return
    }
    loadingV.hide(animated: true)
  }

  func showMessage(_ msg:String) {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.detailsLabel.text = msg
    customHudStyle(hud)
  }

  ///在window上展示loadingview
  func showLoadingViewOnWindow(_ text:String?) {
    let window = UIApplication.shared.keyWindow!
    let loadingView = objc_getAssociatedObject(self, &MBProgressKeys.forWindow)
    guard let loadingV =  loadingView as? MBProgressHUD else {
      let oneLoadingView = MBProgressHUD(view: self.view)
      oneLoadingView.bezelView.backgroundColor = .black
      oneLoadingView.contentColor = .white
      oneLoadingView.offset.y = oneLoadingView.offset.y - 50
      oneLoadingView.removeFromSuperViewOnHide = true
      if let tx = text {
        oneLoadingView.detailsLabel.text = tx
      }
      objc_setAssociatedObject(self, &MBProgressKeys.forWindow, oneLoadingView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      self.view.addSubview(oneLoadingView)
      oneLoadingView.show(animated: true)
      return
    }
    window.addSubview(loadingV)
    loadingV.show(animated: true)
  }

  func hiddenLoadingViewOnWindow() {
    let loadingView = objc_getAssociatedObject(self, &MBProgressKeys.forWindow)
    guard let loadingV = loadingView as? MBProgressHUD else {
      return
    }
    loadingV.hide(animated: true)
  }

  func showMessageOnWindow(_ msg:String) {
    let window = UIApplication.shared.keyWindow!
    let hud = MBProgressHUD.showAdded(to:window, animated: true)
    hud.detailsLabel.text = msg
    customHudStyle(hud)
  }

}

//
//protocol SubViewControllersSwitchProtocol:class {
//  //必须属性
//  var currentVC:UIViewController! {get set}
//  var vcArray:[UIViewController]! {get set}
//  var contentView:UIView! {get set}
//}
//
//extension SubViewControllersSwitchProtocol where Self:UIViewController {
//
//  func replace(old oldVC:UIViewController,use newVC:UIViewController) {
//    if currentVC == newVC {return}
//
//    addChildViewController(newVC)
//    newVC.willMove(toParentViewController: self)
//    oldVC.willMove(toParentViewController: nil)
//
//    let size = oldVC.view.frame.size
//
//    //决定动画方向
//    let direction = (vcArray.index(of: oldVC)! > vcArray.index(of: newVC)!)
//    let screenWidth = UIScreen.main.bounds.width
//    let directionValue = direction ? screenWidth : -screenWidth
//    newVC.view.frame = CGRect(origin: CGPoint(x:-directionValue,y:0), size:size)
//
//    //oldVC的view不能做动画 所以创建一个快照 来做动画
//    guard let animationView = oldVC.view.snapshotView(afterScreenUpdates: false) else {
//      newVC.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//      newVC.didMove(toParentViewController: self)
//      oldVC.removeFromParentViewController()
//      currentVC = newVC
//      return
//    }
//
//    animationView.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//    contentView.addSubview(animationView)
//    transition(from: oldVC, to: newVC, duration: 0.5, options:.init(rawValue: 0), animations: {
//      newVC.view.frame = CGRect(origin: CGPoint(x:0,y:0), size: size)
//      animationView.frame = CGRect(origin: CGPoint(x:directionValue,y:0), size: size)
//    }) { (finish) in
//      if finish {
//        animationView.removeFromSuperview()
//        newVC.didMove(toParentViewController: self)
//        oldVC.removeFromParentViewController()
//        self.currentVC = newVC
//      }else {
//        self.currentVC = oldVC
//      }
//    }
//  }
//}
//
//
////MARK:-进入网贷提现页面之前判断用户是否已经完善了支行信息
////已完善才能去网贷提现 未完善去完善
//protocol ProtocolEntryDrawCashVC {
//  func entryDrawCashVCFrom<T:UIViewController>(_ originVC:T) where T:LoadingPresenterProtocol
//}
//
//extension ProtocolEntryDrawCashVC  {
//
//  func entryDrawCashVCFrom<T:UIViewController>(_ originVC:T) where T:LoadingPresenterProtocol {
//    originVC.showLoadingView(nil)
//    UserRequest.userAssetInfo() {(result) in
//      originVC.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        let model = AssetInfoModel(json: json["data"])
//        handelResult(model)
//      case .failure(let error):
//        originVC.showMessage(error.reason)
//      }
//    }
//
//    func handelResult(_ model:AssetInfoModel) {
//      if !model.banSubName {
//        originVC.showMessage("请先完善银行卡支行信息！")
//        GCDHelper.entryCountdown(2.5, finishClosure: {
//          let bankInformationVC = ConsummateBankInfoVC()
//          bankInformationVC.usePeopleName = model.realName
//          bankInformationVC.pushType = .drawCash
//          originVC.pushTo(bankInformationVC)
//        })
//      }else {
//        let vc = NetBorrowDrawCashVC()
//        originVC.pushTo(vc)
//      }
//    }
//  }
//}
//
//
////MARK:-网贷充值协议
//protocol ProtocolNetBorrowRecharge {
//  func handelRechargeResult(_ json:JSON)
//}
//
//extension ProtocolNetBorrowRecharge where Self:UIViewController {
//
//  //MARK:点击事件
//  func rechargeOneStep(vc:LoadingPresenterProtocol,realInfo:RealNameInfoModel,
//                       amount:Double,chargeType:String,tradeNo:String?)  {
//    //发送验证码
//    vc.showLoadingView(nil)
//    UserRequest.netBorrowSendSmsCode() {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      vc.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        verifyCode()
//      case .failure(let error):
//        vc.showMessage(error.reason)
//      }
//    }
//
//    func verifyCode() {
//      let verifyVC = PhoneVerificationCodeVC()
//      let suffixPreMobile = String(realInfo.preMobile.suffix(4))
//      verifyVC.tipStr = "请输入尾号为\(suffixPreMobile)的6位手机短信验证码"
//      verifyVC.sendCodeClosure = {[unowned self] code in
//        self.rechargeTwoStep(vc:vc,realInfo: realInfo, amount: amount.toDecimalString, smsCode: code,chargeType:chargeType,tradeNo:tradeNo)
//      }
//      verifyVC.modalPresentationStyle = .overCurrentContext
//      present(verifyVC, animated: false, completion: nil)
//    }
//  }
//
//  fileprivate func rechargeTwoStep(vc:LoadingPresenterProtocol,
//                                   realInfo:RealNameInfoModel,
//                                   amount:String,smsCode:String,
//                                   chargeType:String,tradeNo:String?) {
//    vc.showLoadingView(nil)
//    UserRequest.netBorrowRecharge(amount: amount, premobile: realInfo.preMobile, way: "depositios",bankNo:realInfo.bankAccount, bankId: realInfo.bankId.stringValue, smsCode:smsCode, chargeType:chargeType, tradeNo: tradeNo) {[weak self] (result) in
//      guard let strongSelf = self else {return}
//      vc.hiddenLoadingView()
//      switch result {
//      case .success(let json):
//        strongSelf.handelRechargeResult(json)
//      case .failure(let error):
//        vc.showMessage(error.reason)
//      }
//    }
//  }
//
//}








