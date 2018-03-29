//
//  UserVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit
import MJRefresh

class UserVC: UIViewController,LoadingPresenterProtocol,VcDefaultConfigProtocol {
  
  fileprivate let backScrollview = UIScrollView()
  fileprivate let subTabView = UITableView()
  let headerView = UserView()
  fileprivate let titles = ["会员申请","邀请好友","我的积分","帮助中心","设置"]
  fileprivate let images = ["user_vip","user_friend","user_jifen","user_help","user_set"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      createView()
    }

  
  @objc func showSubViewsData() {
    backScrollview.mj_header.endRefreshing()
  }
  
  func headerClick() {
    let noLoginView = NoLoginShowView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 280.ratioHeight, height: 190.ratioWidth)))
    noLoginView.showView()
    noLoginView.loginClosureClick = {[unowned self] tag in
      switch tag {
      case 10:
        let vc = LoginVC()
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
      case 11:
        let vc = RegisterVC()
        vc.entryRegisterVCType = .present
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
      default:break
      }
    }
  }
  
}

extension UserVC:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UserVCCell(imageName: images[indexPath.row], title: titles[indexPath.row], isSelect: true)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    switch indexPath.row {
    case 0:
      let vc = MemberApplyVC()
      pushTo(vc)
    case 1:
      showMessage("邀请好友")
    case 2:
      showMessage("我的积分")
    case 3:
      let vc = HelpCenterVC()
      pushTo(vc)
    case 4:
      let vc = SetVC()
      pushTo(vc)
    default:break
    }
  }
  
}


extension UserVC {
  
  func createView() {
    
    self.view.addSubview(backScrollview)
    if #available(iOS 11.0, *) {
      backScrollview.contentInsetAdjustmentBehavior = .never
    }
    backScrollview.isScrollEnabled = true
    backScrollview.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(showSubViewsData))
    backScrollview.showsVerticalScrollIndicator = false
    backScrollview.backgroundColor = self.view.backgroundColor
    backScrollview.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalTo(self.view)
    }

    
    backScrollview.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.equalTo(backScrollview.snp.top)
      make.right.left.equalTo(self.view)
      make.height.equalTo(180.ratioHeight)
    }
    headerView.headerClick = {[unowned self] in
      self.headerClick()
    }
    
    subTabView.delegate = self
    subTabView.backgroundColor =  .backGround
    subTabView.dataSource = self
    subTabView.bounces = false
    subTabView.separatorColor =   .separateLine
    subTabView.separatorInset = UIEdgeInsets(top: 0, left: 45, bottom: 0, right:0)
    subTabView.clearOtioseSeparatorLine()
    backScrollview.addSubview(subTabView)
    subTabView.snp.makeConstraints({ (make) in
      make.top.equalTo(headerView.snp.bottom)
      make.left.equalTo(self.view)
      make.right.equalTo(self.view)
      let hei = (40.ratioHeight)*CGFloat(titles.count)
      make.height.equalTo(hei)
      make.bottom.equalTo(backScrollview)
    })
    
  }
  
}
