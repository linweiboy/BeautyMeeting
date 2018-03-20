//
//  MeiHuiInductionSubVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/19.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class MeiHuiInductionSubVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      popLastPage()
      createView()
  }

}

extension MeiHuiInductionSubVC:UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "3月\(indexPath.row+1)日"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    if indexPath.row < 3 {
      showMessage("第\(indexPath.row+1)天")
    }else{
      let showView = PlayShowView()
      showView.showView()
    }
    
  }
}

extension MeiHuiInductionSubVC {
  func createView() {
    mainTableView.separatorStyle = .singleLine
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.clearOtioseSeparatorLine()
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.register(BusinessCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
}
