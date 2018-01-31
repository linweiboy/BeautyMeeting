//
//  HomeVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,VcDefaultConfigProtocol {
  
  fileprivate let mainTableView = UITableView(frame: .zero, style: .grouped)
  fileprivate let navTitleView = NavTitleView()
  fileprivate var popularizeView = PopularizeView()
  fileprivate var firstHeaderView = HomeTabFirstHeaderView()
  fileprivate let titles = ["美会介绍","美会播报","美会商院","美会联盟"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      createView()
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    firstHeaderView.showBannerDate(["","","",""])
    firstHeaderView.showNoticeDate(["第一天","第二天","第三天","第四天"])
  }
  
  //四个品牌点击
  func popularizeClick(_ tag:Int) {
  }

  
  //MARK: 点击事件
  func clickBanner(_ tag:Int) {
    
  }
  
  //消息更多点击
  func noticeClick(_ type: NoticeClickType,index:Int){
    
  }
  
  //更多点击事件
  func moreClick(_ section: Int) {
    
  }
}


extension HomeVC:UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
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
      firstView.showTitleDateStr("财富推荐",moreLBIsHidden: false)
      firstView.snp.makeConstraints({ (make) in
        make.top.equalTo(popularizeView.snp.bottom).offset(5.ratioHeight)
        make.left.right.bottom.equalTo(firstHeaderView)
      })
      return firstHeaderView
    default:return UIView()
    }
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
