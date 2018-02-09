//
//  OperateSuccessView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/10/26.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

class OperateSuccessView: UIView,UITableViewDelegate,UITableViewDataSource  {

  var clickClo:((_ tag:Int)->())!
  
  let tabView = UITableView()
  private var titleData: [String] = []
  private var contentLBData: [UILabel] = []
  
  convenience init(noteTitle:String,titleArr:[String],
                   contentLBArr:[UILabel],btTitleArr:[String]) {
    self.init(frame: .zero)
    
    self.backgroundColor =   .separateLine
    titleData.append(contentsOf: titleArr)
    contentLBData.append(contentsOf: contentLBArr)
    
    let topView = OperateSuccessTopView()
    addSubview(topView)
    topView.backgroundColor = .white
    topView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(130.ratioHeight)
    }
    
    let tipLogoIM = UIImage(named: "user_rechangeSuccess")!
    let tipLogoIV = UIImageView(image: tipLogoIM)
    topView.addSubview(tipLogoIV)
    tipLogoIV.snp.makeConstraints { (make) in
      make.centerX.equalTo(topView.snp.centerX)
      make.centerY.equalTo(topView.snp.centerY).offset(-10.ratioHeight)
      make.width.equalTo(tipLogoIM.ratioWidth)
      make.height.equalTo(tipLogoIM.ratioHeight)
    }
    
    let propmtLB = UILabel()
    topView.addSubview(propmtLB)
    propmtLB.decorateStyleOfLB(title:noteTitle, textColor:   .prittyBlue, textFont: 16.ratioHeight)
    propmtLB.snp.makeConstraints { (make) in
      make.top.equalTo(tipLogoIV.snp.bottom).offset(10.ratioHeight)
      make.centerX.equalTo(tipLogoIV.snp.centerX)
    }
    
    addSubview(tabView)
    tabView.separatorStyle = .none
    tabView.delegate = self
    tabView.dataSource = self
    tabView.allowsSelection = false
    tabView.backgroundColor = .white
    tabView.snp.makeConstraints { (make) in
      make.top.equalTo(topView.snp.bottom)
      make.left.right.equalTo(self)
      make.height.equalTo(CGFloat(titleArr.count)*40.ratioHeight)
    }
    
    guard btTitleArr.count <= 2 else { return }
    
    var leftBT:UIButton!
    if btTitleArr.count == 1 {
      leftBT = RoundCornerBT(type: .custom)
      leftBT.decorateStyleOfBT(title: btTitleArr[0], textColor: .white, textFont: FontDefine.fifteen, backGroundColor:.main)
      addSubview(leftBT)
      leftBT.snp.makeConstraints { (make) in
        make.top.equalTo(tabView.snp.bottom).offset(30.ratioHeight)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(CGDefine.height.maxButton)
      }
    }else {
      leftBT = RoundCornerLineBT(borderColor:.main, lineWidth: 1, radian: 3, fillColor: .white)
      addSubview(leftBT)
      leftBT.decorateStyleOfBT(title: btTitleArr[0], textColor:.main, textFont: FontDefine.fifteen, backGroundColor: .clear)
      leftBT.snp.makeConstraints { (make) in
        make.top.equalTo(tabView.snp.bottom).offset(30.ratioHeight)
        make.left.equalTo(15)
        make.height.equalTo(CGDefine.height.maxButton)
      }
    }
    
    leftBT.tag = 10
    leftBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    
    guard btTitleArr.count == 2  else { return }
    
    let rightBT = RoundCornerBT()
    addSubview(rightBT)
    rightBT.tag = 11
    rightBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    rightBT.decorateStyleOfBT(title: btTitleArr[1], textColor: .white, textFont: FontDefine.fifteen, backGroundColor:.main)
    rightBT.snp.makeConstraints { (make) in
      make.width.top.equalTo(leftBT)
      make.left.equalTo(leftBT.snp.right).offset(15)
      make.height.equalTo(CGDefine.height.maxButton)
      make.right.equalTo(-15)
    }
    
  }
  
  @objc func btClick(bt:UIButton) {
    clickClo(bt.tag)
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titleData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.decorateStyleOfLB(title: titleData[indexPath.row], textColor:.tipText, textFont: 12.ratioHeight)
    let lb = contentLBData[indexPath.row]
    cell.addSubview(lb)
    lb.snp.makeConstraints { (make) in
      make.centerY.equalTo(cell)
      make.right.equalTo(-15)
    }
    return cell
    
  }

}

class OperateSuccessTopView: UIView {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let be = UIBezierPath()
    be.move(to: CGPoint(x: 15, y: rect.height-1))
    be.addLine(to: CGPoint(x: rect.width-15, y: rect.height-1))
    be.lineWidth = 1
    UIColor.separateLine.setStroke()
    be.stroke()
  }
  
}

