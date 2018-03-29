//
//  NotOpenCityVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/27.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class NotOpenCityVC: UIViewController, VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "未开通城市"
    defaultConfig()
    popLastPage()
    createView()
    refreshData()
  }
  
  @objc func refreshData() {
    //    showLoadingView(nil)
    //    HomeRequest.homeListTypeCode(typeCode: "introduce") {[weak self](result) in
    //      guard let strongSelf = self else{return}
    //      strongSelf.hiddenLoadingView()
    //      //      strongSelf.mainTableView.mj_header.endRefreshing()
    //      switch result {
    //      case .success(let json):
    //        printLog(message: json)
    //        //        strongSelf.dataList.removeAll()
    //        //        strongSelf.dataList += DailyReadModel.parseList(json)
    //        strongSelf.mainTableView.reloadData()
    //      case .failure(let errpr):
    //        strongSelf.showMessage(errpr.reason)
    //      }
    //    }
  }
  
}

extension NotOpenCityVC:UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()
    cell.textLabel?.text = "甘肃兰州"
    cell.accessoryType = .disclosureIndicator
    tableView.separatorStyle = .singleLine
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 45.ratioHeight
    
  }
  
}




extension NotOpenCityVC{
  
  func createView(){
    mainTableView.separatorStyle = .none
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.clearOtioseSeparatorLine()
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.register(IntroductionCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
}

