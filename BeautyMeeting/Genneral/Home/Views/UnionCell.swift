//
//  UnionCell.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/6.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class UnionCell: UITableViewCell,ReusableView {

  
  fileprivate let titleLB = UILabel()
  fileprivate let oneIMV = RoundCornerIMV()
  fileprivate let twoIMV = RoundCornerIMV()
  fileprivate let threeIMV = RoundCornerIMV()
  fileprivate let detailLB = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.white
    
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "北欧风情的泰晤小镇", textColor: .black, textFont: 12.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.top.equalTo(8.ratioHeight)
      make.left.equalTo(15)
    }
    
    addSubview(oneIMV)
    oneIMV.image = UIImage(named: "home_one")
    oneIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titleLB.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.height.equalTo(90.ratioHeight)
    }
    
    addSubview(twoIMV)
    twoIMV.image = UIImage(named: "home_meidu")
    twoIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titleLB.snp.bottom).offset(10)
      make.left.equalTo(oneIMV.snp.right).offset(15)
      make.height.equalTo(90.ratioHeight)
      make.width.equalTo(oneIMV)
    }
    
    addSubview(threeIMV)
    threeIMV.image = UIImage(named: "small_defualt")
    threeIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titleLB.snp.bottom).offset(10)
      make.left.equalTo(twoIMV.snp.right).offset(15)
      make.height.equalTo(90.ratioHeight)
      make.width.equalTo(twoIMV)
      make.right.equalTo(-15)
    }
    
    addSubview(detailLB)
    detailLB.decorateStyleOfLB(title: "   腾讯多元化的服务包括：社交和通信服务QQ及维修、社交网络平台QQ空间腾讯游戏旗下xxxxxxx", textColor: UIColor.rgbValue(sameValue: 76), textFont: 11.ratioHeight)
    detailLB.numberOfLines = 2
    detailLB.snp.makeConstraints { (make) in
      make.top.equalTo(oneIMV.snp.bottom).offset(10)
      make.left.equalTo(15)
      make.right.equalTo(-15)
    }
    
    let line = UIView()
    line.backgroundColor = UIColor.separateLine
    addSubview(line)
    line.snp.makeConstraints { (make) in
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.bottom.equalTo(self)
      make.height.equalTo(1)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
