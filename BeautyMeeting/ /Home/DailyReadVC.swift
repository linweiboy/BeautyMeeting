//
//  DailyReadVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/4.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit
import MJRefresh

//每日美读
class DailyReadVC: UIViewController, VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol{
  
  //LoadMoreDataProtocol
//  internal typealias T = DailyReadModel
//  internal var mainTableView:UITableView! = UITableView()
//  internal var dataList:[DailyReadModel]! =  []
//  internal var currentOffset:Int! = 0
  
  fileprivate let mainTableView = UITableView()
  fileprivate var dataList:[DailyReadModel] =  []

    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "每日美读"
      defaultConfig()
      popLastPage()
      createView()
      refreshData()
    }
  
  @objc func refreshData() {
    showLoadingView(nil)
    HomeRequest.homeListTypeCode(typeCode: "dailyreading") {[weak self](result) in
      guard let strongSelf = self else{return}
      strongSelf.hiddenLoadingView()
      strongSelf.mainTableView.mj_header.endRefreshing()
      switch result {
      case .success(let json):
        strongSelf.dataList.removeAll()
        strongSelf.dataList += DailyReadModel.parseList(json)
        strongSelf.mainTableView.reloadData()
      case .failure(let errpr):
        strongSelf.showMessage(errpr.reason)
      }
    }
  }
  
  
}

extension DailyReadVC:UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DailyReadCell.reuseIdentifier) as! DailyReadCell
    if dataList.count != 0 {
      let model = dataList[indexPath.row]
      cell.showData(model)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    if  dataList.count != 0 {
      let model = dataList[indexPath.row]
      let htmlVC = OpenHtmlVC()
      htmlVC.navItemTitle = model.title
      htmlVC.htmlContent = model.description
      pushTo(htmlVC)
    }
  }

}


extension DailyReadVC {
  
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
    mainTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
    mainTableView.register(DailyReadCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
  
}
