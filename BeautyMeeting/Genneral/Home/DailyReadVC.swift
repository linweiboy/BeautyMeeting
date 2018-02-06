//
//  DailyReadVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/4.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class DailyReadVC: UIViewController, VcDefaultConfigProtocol,PopVCSetProtocol{
  
  fileprivate let mainTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.title = "每日美读"
      defaultConfig()
      popLastPage()
      createView()
    }

}

extension DailyReadVC:UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DailyReadCell.reuseIdentifier) as! DailyReadCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85.ratioHeight
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
    mainTableView.register(DailyReadCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
  
}
