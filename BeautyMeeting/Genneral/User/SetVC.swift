//
//  SetVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/1.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class SetVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let subTabView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "设置"
      defaultConfig()
      popLastPage()
      createView()
    }
  
  
  
  
}

//MARK: -点击事件
extension SetVC {
  
  @objc func quitAccount() {
    let alertV = UIAlertView(title: "", message: "确认退出当前账户？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
    alertV.tag = 11
    alertV.show()
  }
}
extension SetVC:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0{
      let cell = SystemSetCell()
      cell.showData(title: "密码修改", content: "")
      cell.accessoryType = .disclosureIndicator
      return cell
    }
    
    if indexPath.row == 1{
      let cell = SystemSetCell()
      cell.showData(title: "手机修改", content: "")
      cell.accessoryType = .disclosureIndicator
      return cell
    }
    
    if indexPath.row == 2 {
      let cell = SystemSetCell()
      cell.selectionStyle = .none
      cell.showData(title: "当前版本", content: AccessSystem.versionNum)
      return cell
    }
    
    if indexPath.row == 3 {
      let cell = SystemSetCell()
      let cachesSize = FileManager.getCachesSize()
      cell.showData(title: "清理缓存", content: "\(cachesSize)M")
      cell.accessoryType = .disclosureIndicator
      return cell
    }
    
    if indexPath.row == 4 {
      let cell = UITableViewCell()
      cell.backgroundColor = UIColor.separateLine
      cell.selectionStyle = .none
      cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 500)
      let quitBT = RoundCornerBT.unifyConfirmBT(title: "安全退出")
      cell.addSubview(quitBT)
      quitBT.addTarget(self, action: #selector(quitAccount), for: .touchUpInside)
      quitBT.snp.makeConstraints({ (make) in
        make.top.equalTo(30)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(45)
      })
      return cell
    }

    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0,1,2,3:  return 45
    case 4:  return 80
    default: return 0
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    switch indexPath.row {
    case 0:
      let vc = ModifyPasswordVC()
      pushTo(vc)
    case 1:
      let vc = ModifyPhoneNumVC()
      pushTo(vc)
    case 3:
      let alertV = UIAlertView(title: "", message: "确认清理缓存？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
      alertV.tag = 10
      alertV.show()
    default:break
    }

  }
  
}


extension SetVC{
  
  func createView() {
    subTabView.delegate = self
    subTabView.backgroundColor =  .backGround
    subTabView.dataSource = self
    subTabView.separatorColor =   .separateLine
    subTabView.bounces = false
    subTabView.clearOtioseSeparatorLine()
    view.addSubview(subTabView)
    subTabView.snp.makeConstraints({ (make) in
      make.top.equalTo(view)
      make.left.equalTo(self.view)
      make.right.equalTo(self.view)
      make.height.equalTo(215.ratioHeight)
    })
    
  }
  
}

extension SetVC:UIAlertViewDelegate {
  
  func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
    //清理缓存
    if alertView.tag == 10 {
      if buttonIndex == 1 {
        FileManager.cleanCache(finishClo: {
          let path = IndexPath(row: 3, section: 0)
          self.subTabView.reloadRows(at: [path], with: .automatic)
        })
      }
    }
    
    //退出账户
    if alertView.tag == 11 {
      if buttonIndex == 1 {
        let queue = DispatchQueue.global()
        queue.sync(execute: {
          AccountManage.logoutCurrentAccount()
          DispatchQueue.main.async(execute: { self.popToRootVC() })
        })
      }
    }
  }
}

class SystemSetCell: UITableViewCell,TitleAndRightContentCellProtocol {
  
  var titleLB:UILabel! = UILabel()
  var contentLB:UILabel! = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addShowViews()
  }
  
  func showData(title:String,content:String) {
    titleLB.text = title
    contentLB.text = content
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

