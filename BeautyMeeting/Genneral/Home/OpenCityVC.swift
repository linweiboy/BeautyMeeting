//
//  OpenCityVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/27.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class OpenCityVC: UIViewController, VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "已开通城市介绍"
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

extension OpenCityVC:UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: IntroductionCell.reuseIdentifier) as! IntroductionCell
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 85.ratioHeight
    
  }
  
}




extension OpenCityVC{
  
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

