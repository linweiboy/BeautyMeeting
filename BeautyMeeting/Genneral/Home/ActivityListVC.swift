//
//  ActivityListVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongtengjituan on 2017/5/26.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit
import MJRefresh

enum ActivityType:String {
  case pre = "pre" //未开始
  case pro = "pro" //进行中
  case end = "end" //已结束
}

class ActivityListVC: UIViewController, VcDefaultConfigProtocol, PopVCSetProtocol, LoadingPresenterProtocol, SwipeGestureRecognizerProtocol,LoadMoreDataProtocol {
  
  fileprivate var activityType:ActivityType = .pre
  fileprivate var currentPage:Int = 1
  fileprivate let headerView = ActivityHeaderView()
  
  //LoadMoreDataProtocol
  internal typealias T = DiscoverListModel
  internal var mainTableView:UITableView! = UITableView()
  internal var dataList:[DiscoverListModel]! =  []
  internal var currentOffset:Int! = 0
  
  //SwipeGestureRecognizerProtocol
  var swipeSelector: Selector!
  fileprivate var currenSelectedIndex:Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "活动列表"
    defaultConfig()
    popLastPage()
    createView()
    selectType(100)
  }
  
  //tag: 100 、101 、102
  func selectType(_ tag: Int) {
    if currenSelectedIndex == tag {return}
    currenSelectedIndex = tag
    switch tag {
    case 100:activityType = .pro
    case 101:activityType = .pre
    case 102:activityType = .end
    default:break
    }
    currentPage = 1
    currentOffset = 0
    dataList.removeAll()
    mainTableView.mj_header.beginRefreshing()
  }
  
  @objc func refreshData() {
    refreshPrepare()
    HomeRequest.homeMoreList(status: activityType, currentPage: currentPage, pageSize: DataOfPageNum) { [weak self] (result) in
      guard let strongeSelf = self else { return }
      strongeSelf.mainTableView.finishRefreshing()
      switch result {
      case .success(let json):
        printLog(message: json)
        strongeSelf.handleData(json)
      case .failure(let error):
        strongeSelf.showMessage(error.reason)
      }
    }
  }

  
}

//MARK: UITableViewDelegate
extension ActivityListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 190.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    guard !dataList.isEmpty else {return}
    let model = dataList[indexPath.row]
    let vc = OpenUrlVC()
    vc.loadUrl = model.link
    pushTo(vc)
  }
  
}

//MARK: UITableViewDataSource
extension ActivityListVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ActiveListCell.reuseIdentifier) as! ActiveListCell
    if !dataList.isEmpty {
      let model = dataList[indexPath.row]
      cell.showData(model)
    }
    return cell
  }
  
}



extension ActivityListVC {
  func createView() {
    
    let headerBackView = UIView()
    view.addSubview(headerBackView)
    headerBackView.backgroundColor = .white
    headerBackView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(view)
      make.height.equalTo(54.ratioHeight)
    }
    
    headerView.activityStatusClosure = { [unowned self] tag in
      self.selectType(tag)
    }
    headerBackView.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.centerY.equalTo(headerBackView)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(28.ratioHeight)
    }
    
    swipeSelector = #selector(swipeAction)
    setupSwipe()
    
    mainTableView.separatorStyle = .none
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.register(ActiveListCell.self)
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
    mainTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(refreshData))
    mainTableView.mj_footer.isHidden = true
    view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(headerBackView.snp.bottom).offset(10)
    }
  }
  
  @objc func swipeAction(_ tap:UISwipeGestureRecognizer) {
    //向左
    if tap.direction.rawValue == 2 {
      let currentTag = currenSelectedIndex + 1
      if currentTag > 102 {return}
      headerView.selectedButton(currentTag)
      selectType(currentTag)
    }

    //向右
    if tap.direction.rawValue == 1 {
      let currentTag = currenSelectedIndex - 1
      if currentTag < 100 {return}
      headerView.selectedButton(currentTag)
      selectType(currentTag)
    }
  }

  
}
