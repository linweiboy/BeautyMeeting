//
//  HomeVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,VcDefaultConfigProtocol,LoadingPresenterProtocol{
  
  fileprivate let mainTableView = UITableView(frame: .zero, style: .grouped)
  fileprivate let navTitleView = NavTitleView()
  fileprivate var popularizeView = PopularizeView()
  fileprivate var firstHeaderView = HomeTabFirstHeaderView()
  fileprivate let titles = ["美会介绍","美会播报","美会商院","美会联盟"]
  fileprivate var bannarModelArray: [BannarModel] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      createView()
      refreshData()
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    firstHeaderView.showNoticeDate(["第一天","第二天","第三天","第四天"])
  }
  
  func refreshData() {
    //获取首页的推荐的产品
    HomeRequest.homeProductRecommendation { [weak self] (result) in
      guard let strongSelf = self else{return}
//      strongSelf.mainTableView.mj_header.endRefreshing()
      switch result {
      case .success(let json):
        printLog(message: "首页数据\(json)")
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
    
    //
    HomeRequest.homeNotice { [weak self](result) in
      guard let strongSelf = self else{return}
      switch result {
      case .success(let json):
        printLog(message: "消息公告\(json)")
      case .failure(let errpr):
        strongSelf.showMessage(errpr.reason)
      }
    }
    
    
    HomeRequest.homeBanner { [weak self](result) in
      guard let strongSelf = self else{return}
      switch result {
      case .success(let json):
//        printLog(message: json)
        let modelArray = BannarModel.parseListForData(json)
        if modelArray.count != 0 {
          strongSelf.bannarModelArray.removeAll()
          strongSelf.bannarModelArray.append(contentsOf: modelArray)
          let urlArray = modelArray.map { $0.imgUrl }
          strongSelf.firstHeaderView.showBannerDate(urlArray)
        }
      case .failure(let errpr):
        strongSelf.showMessage(errpr.reason)
      }
    }
  }
  
  //四个品牌点击
  func popularizeClick(_ tag:Int) {
    switch tag {
    case 10:
      let vc = IntroductionVC()
      pushTo(vc)
    case 11:
      break
    case 12:
      break
    case 13:
      let vc = UnionVC()
      pushTo(vc)
    default:break
    }

    
  }

  
  //MARK: 点击事件
  func clickBanner(_ tag:Int) {
    
  }
  
  //消息更多点击
  func noticeClick(_ type: NoticeClickType,index:Int){
    
  }
  
  //更多点击事件
  func moreClick(_ section: Int) {
    switch section {
    case 0:
      let vc = DailyReadVC()
      pushTo(vc)
    case 1:
      let vc = ActivityListVC()
      pushTo(vc)
    default:break
    }
  }
}


extension HomeVC:UITableViewDelegate,UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 4
    }else if section == 1{
      return 3
    }else if section == 2{
      return 2
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 270
    case 1:
      return 220
    case 2:
      return 200
    default:break
    }
    return 45
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: HomeMeiDuCell.reuseIdentifier) as! HomeMeiDuCell
      return cell
    }else if indexPath.section == 1{
      let cell = tableView.dequeueReusableCell(withIdentifier: HomeActiveCell.reuseIdentifier) as! HomeActiveCell
      return cell
    }else if indexPath.section == 2{
      let cell = tableView.dequeueReusableCell(withIdentifier: HomeGuessCell.reuseIdentifier) as! HomeGuessCell
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 312.ratioHeight
    }
    return 48.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    switch section {
    case 0:
      firstHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTabFirstHeaderView.reuseIdentifier) as! HomeTabFirstHeaderView
      
      firstHeaderView.clickBannerClosure = { [unowned self] index in self.clickBanner(index)}
      firstHeaderView.noticeClickClosure = { [unowned self] (type,index) in
        self.noticeClick(type, index: index)}
      
      firstHeaderView.addSubview(popularizeView)
      popularizeView.snp.makeConstraints { (make) in
        make.height.equalTo(79.ratioHeight)
        make.left.right.equalTo(firstHeaderView)
        make.top.equalTo(firstHeaderView.snp.top).offset(180.ratioHeight)
      }
      
      let firstView = CustomTabHeaderView()
      firstHeaderView.addSubview(firstView)
      firstView.moreClickClosure = {[unowned self] in self.moreClick(section)}
      firstView.showTitleDateStr("每日美读",moreLBIsHidden: false)
      firstView.snp.makeConstraints({ (make) in
        make.top.equalTo(popularizeView.snp.bottom).offset(5.ratioHeight)
        make.left.right.bottom.equalTo(firstHeaderView)
      })
      return firstHeaderView
    case 1:
      let TwoHeaderView = CustomTabHeaderView()
      TwoHeaderView.moreClickClosure = {[unowned self] in self.moreClick(section)}
      TwoHeaderView.showTitleDateStr("最新活动", moreLBIsHidden: false)
      return TwoHeaderView
    case 2:
      let ThreeHeaderView = CustomTabHeaderView()
      ThreeHeaderView.showTitleDateStr("节目预告", moreLBIsHidden: false)
      ThreeHeaderView.moreClickClosure = {[unowned self] in self.moreClick(section)}
      return ThreeHeaderView
    default:return UIView()
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
}

extension HomeVC {
  
  func createView() {
    mainTableView.separatorStyle = .none
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.registerHeadCell(HomeTabFirstHeaderView.self)
    view.addSubview(mainTableView)
    mainTableView.register(HomeMeiDuCell.self)
    mainTableView.register(HomeActiveCell.self)
    mainTableView.register(HomeGuessCell.self)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }

    view.addSubview(navTitleView)
    navTitleView.alpha = 0
    navTitleView.snp.makeConstraints { (make) in
      make.left.right.top.equalTo(view)
      make.height.equalTo(64)
    }
    
    popularizeView = PopularizeView(count: 4)
    let images = ["BrandIntroduce","mediue","home_bankstoremanage","SafeGuarantee"]
    popularizeView.fileValueWith(titles: titles, imageNames: images)
    popularizeView.selectClosure = {[unowned self] (tag) in self.popularizeClick(tag) }
    
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let alpha = max(0, (offsetY) / (200))
    if offsetY > 0 {
      navTitleView.alpha = alpha
    }
    else{
      navTitleView.alpha = 0.0
    }
  }

}
