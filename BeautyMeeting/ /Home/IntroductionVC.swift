//
//  IntroductionVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/6.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class IntroductionVC: UIViewController, VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "美会介绍"
      defaultConfig()
      popLastPage()
      createView()
      refreshData()
    }

  @objc func refreshData() {
    showLoadingView(nil)
    HomeRequest.homeListTypeCode(typeCode: "introduce") {[weak self](result) in
      guard let strongSelf = self else{return}
      strongSelf.hiddenLoadingView()
//      strongSelf.mainTableView.mj_header.endRefreshing()
      switch result {
      case .success(let json):
        printLog(message: json)
//        strongSelf.dataList.removeAll()
//        strongSelf.dataList += DailyReadModel.parseList(json)
        strongSelf.mainTableView.reloadData()
      case .failure(let errpr):
        strongSelf.showMessage(errpr.reason)
      }
    }
  }

}

extension IntroductionVC:UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row <= 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: IntroductionCell.reuseIdentifier) as! IntroductionCell
      cell.showData("美读会总会介绍")
      return cell
    }else{
      let cell = UITableViewCell()
      cell.textLabel?.text = "未开通城市"
      cell.accessoryType = .disclosureIndicator
      tableView.separatorStyle = .singleLine
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row <= 1 {
      return 115.ratioHeight
    }
    return 45.ratioHeight
  }
  
}




extension IntroductionVC{
  
  func createView(){
    mainTableView.separatorStyle = .none
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.clearOtioseSeparatorLine()
    mainTableView.register(IntroductionCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
}
