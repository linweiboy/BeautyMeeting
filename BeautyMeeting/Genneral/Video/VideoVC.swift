//
//  DiscoverVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit
import MJRefresh

class VideoVC: UIViewController, VcDefaultConfigProtocol,LoadingPresenterProtocol {

  
  fileprivate let mainTableView = UITableView(frame: .zero, style: .grouped)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      createView()
      refreshData()
    }

  @objc func refreshData() {
    VideoRequest.videoList { [weak self](result) in
      guard let strongSelf = self else{return}
      strongSelf.mainTableView.mj_header.endRefreshing()
      switch result {
      case .success(let json):
        printLog(message: json)
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
  }
  
  
  func moreClick(_ section:Int){
    printLog(message: section)
  }
  
  func headerClick(_ tag:Int){
    switch tag {
    case 10:
      let boVc = BoBaoVC()
      pushTo(boVc)
    case 11:
      let vc = FamousTeacherVC()
      pushTo(vc)
    case 12:showMessage("静待开放")
    case 13:
      let vc = ApplyBoBaoVC()
      pushTo(vc)
    default:break
    }
  }
  
}
extension VideoVC: UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 5
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 {
      return 130.ratioHeight
    }
    return 45.ratioHeight
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 0 {
      let cellHeader = VideoTabHeaderView()
      cellHeader.headerClickClosuer = {[unowned self] tag in
        self.headerClick(tag)
      }
      let oneHeader = CustomTabHeaderView()
      oneHeader.moreClickClosure = {[unowned self] in self.moreClick(section)}
      oneHeader.showTitleDateStr("在线直播", moreLBIsHidden: false)
      cellHeader.addSubview(oneHeader)
      oneHeader.snp.makeConstraints({ (make) in
        make.bottom.left.right.equalTo(cellHeader)
        make.height.equalTo(45.ratioHeight)
      })
      return cellHeader
    }else{
      let TwoHeaderView = CustomTabHeaderView()
      TwoHeaderView.moreClickClosure = {[unowned self] in self.moreClick(section)}
      TwoHeaderView.showTitleDateStr("视频播报", moreLBIsHidden: false)
      return TwoHeaderView
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    }
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.reuseIdentifier) as! VideoCell
    return cell
    
  }
  
  
  
}




extension VideoVC {
  
  func createView() {
    
    mainTableView.separatorStyle = .none
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.clearOtioseSeparatorLine()
    mainTableView.backgroundColor =  .backGround
    mainTableView.registerHeadCell(VideoTabHeaderView.self)
    mainTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
    view.addSubview(mainTableView)
    mainTableView.register(VideoCell.self)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
    
  }
  
}
