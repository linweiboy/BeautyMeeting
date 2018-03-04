//
//  HelpCenterVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/1.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class HelpCenterVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol {
  
  fileprivate let mainTableView = UITableView()
  fileprivate var contentHeight : CGFloat? //存储文字高度
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "帮助中心"
      defaultConfig()
      popLastPage()
      createView()
    }

  
  //解析HTML，获取文章内容高度
  func showDeaitalDataWith(_ content:String) {
    let contentWidth = ScreenWidth - 40
    let str:String = content
    let Height:CGFloat = str.achieveStringRect(contentWidth, font: 13).height
    contentHeight = Height
  }

  
}
extension HelpCenterVC:UITableViewDataSource,UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
    let str = String(format: "帮助信息 %zd", indexPath.row)
    cell.textLabel?.text = str
    cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let str = String(format: "帮助信息 %zd", indexPath.row)
    let showView = HelpInformationView(title: str, content: "哈哈哈哈", height: 100)
    showView.showView()
  }
}


extension HelpCenterVC {
  func createView() {
    mainTableView.separatorStyle = .singleLine
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }

  }
}


class HelpInformationView: UIView,ProtocolMaskShowView {
  
  var maskAnimationView:UIView! = UIView()
  
  convenience init(title:String,content:String,height:CGFloat){
    let conentFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: ScreenWidth-80, height: height + 45))
    self.init(frame: conentFrame)
    self.backgroundColor = .white
    let titleLB = UILabel()
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: title, textColor: .black, textFont: 13.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.top.equalTo(10)
      make.centerX.equalTo(self)
      make.height.equalTo(20.ratioHeight)
    }
    
    let contentLB = UILabel()
    addSubview(contentLB)
    contentLB.decorateStyleOfLB(title: content, textColor: .black, textFont: 12.ratioHeight)
    contentLB.numberOfLines = 0
    contentLB.snp.makeConstraints { (make) in
      make.top.equalTo(titleLB.snp.bottom).offset(15)
      make.left.equalTo(10)
      make.right.equalTo(-10)
    }
    
    
    //关闭按钮
    let trunOffBT = UIButton(type: .custom)
    addSubview(trunOffBT)
    trunOffBT.addTarget(self, action: #selector(trunOffBTClick), for: .touchUpInside)
    trunOffBT.setImage(UIImage(named: "PaymentInfo_Close"), for: .normal)
    trunOffBT.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
    trunOffBT.snp.makeConstraints { (make) in
      make.top.right.equalTo(self)
      make.width.equalTo(50)
      make.height.equalTo(25)
    }

    
  }
  
  @objc func trunOffBTClick() {
    dismissView(nil)
  }
  
  override func draw(_ rect: CGRect) {
    self.layer.cornerRadius = 5
    self.layer.masksToBounds = true
  }
  
}



