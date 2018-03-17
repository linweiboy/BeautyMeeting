//
//  HomeCells.swift
//  XiaoZhuGeJinFu
//
//  Created by LinweiTan on 2017/5/17.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

//首页美读
class HomeMeiDuCell: UITableViewCell, ReusableView {
  
  fileprivate let headerIMV = UIImageView() //头像
  fileprivate let bigDetailIMV = RoundCornerIMV()
  fileprivate let nameLB = UILabel() //作者名
  fileprivate let descriptLB = UILabel() //详情
  fileprivate let titleNameLB = UILabel()
  fileprivate let timeLimitLB = UILabel()
  fileprivate let actionBT = UIButton(type: .custom)

  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .white
    
    let headerView = CellMeiDuHeaderView(headerIMV: headerIMV, nameLB: nameLB, titleLB: descriptLB, activeBT:actionBT)
    headerIMV.image = UIImage(named:"home_header")
    addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(50.ratioHeight)
    }
    
    addSubview(bigDetailIMV)
    bigDetailIMV.image = UIImage(named: "big_defualt")
    bigDetailIMV.snp.makeConstraints { (make) in
      make.top.equalTo(headerView.snp.bottom).offset(5.ratioHeight)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(120.ratioHeight)
    }
    

    
    addSubview(titleNameLB)
    titleNameLB.decorateStyleOfLB(title: "摸鱼儿.更能消几番风月", textColor: .black, textFont: 13.ratioHeight)
    titleNameLB.snp.makeConstraints { (make) in
      make.top.equalTo(bigDetailIMV.snp.bottom).offset(10)
      make.left.equalTo(15)
    }
    
    addSubview(timeLimitLB)
    timeLimitLB.decorateStyleOfLB(title: "2017-10-10 22:10", textColor: .tipText, textFont: 11.ratioHeight)
    timeLimitLB.snp.makeConstraints { (make) in
      make.top.equalTo(titleNameLB.snp.bottom).offset(5)
      make.left.equalTo(15)
    }
    
    let lineView = UIView()
    lineView.backgroundColor = .backGround
    addSubview(lineView)
    lineView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(self)
      make.height.equalTo(5.ratioHeight)
    }
    
  }
  
  func showDate(_ model:CatalogDataModel) {
    bigDetailIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
//    nameLB.text = model.author
    timeLimitLB.text = model.time
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//最新活动
class HomeActiveCell: UITableViewCell, ReusableView {
  
  fileprivate let activityState = UILabel() //活动状态(正在进行，已结束，未开始)
  fileprivate let activityTitleLB = UILabel() //活动标题
  fileprivate let activityIMV = UIImageView() //活动图片
  fileprivate let acttivityTimeLB = UILabel() //活动时间
  
  func showDate(_ model:CatalogDataModel) {
    activityIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
    activityTitleLB.text = model.title
    acttivityTimeLB.text = model.time
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let titleView = CellHeaderTitleView(activityTitleLB)
    addSubview(titleView)
    titleView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(35.ratioHeight)
    }
    
    addSubview(activityIMV)
    activityIMV.image = UIImage(named: "home_active_defulat")
    activityIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titleView.snp.bottom)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.height.equalTo(125.ratioHeight)
    }
    
    addSubview(activityState)
    activityState.decorateStyleOfLB(title: "活动时间：", textColor:   .textBlackColor, textFont: 12.ratioHeight)
    activityState.snp.makeConstraints { (make) in
      make.top.equalTo(activityIMV.snp.bottom).offset(5.ratioHeight)
      make.left.equalTo(13.ratioHeight)
    }
    
    addSubview(acttivityTimeLB)
    acttivityTimeLB.decorateStyleOfLB(title: "2017-10-10 22:22", textColor:   .garyTitleColor, textFont: 11.ratioHeight)
    acttivityTimeLB.snp.makeConstraints { (make) in
      make.bottom.equalTo(activityState)
      make.left.equalTo(activityState.snp.right).offset(10.ratioHeight)
    }
    
    let lineView = UIView()
    lineView.backgroundColor =   .separateLine
    addSubview(lineView)
    lineView.snp.makeConstraints { (make) in
      make.bottom.equalTo(self)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.height.equalTo(0.5)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

//猜你喜欢
class HomeGuessCell: UITableViewCell, ReusableView {
  
  fileprivate let guessIMV = UIImageView()
  fileprivate let titLB = UILabel()
  
  func showDate(_ model:CatalogDataModel) {
    guessIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
    titLB.text = model.title
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(titLB)
    titLB.decorateStyleOfLB(title: "最美澳洲升级", textColor: .textBlackColor, textFont: 11.ratioHeight)
    titLB.snp.makeConstraints { (make) in
      make.top.equalTo(self)
      make.left.equalTo(13.ratioWidth)
      make.height.equalTo(35.ratioHeight)
    }
    
    addSubview(guessIMV)
    guessIMV.image = UIImage(named: "home_guess")
    guessIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titLB.snp.bottom).offset(5)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.bottom.equalTo(-5)
    }
    
    let lineView = UIView()
    lineView.backgroundColor =   .separateLine
    addSubview(lineView)
    lineView.snp.makeConstraints { (make) in
      make.bottom.equalTo(self)
      make.left.equalTo(0)
      make.right.equalTo(0)
      make.height.equalTo(0.5)
    }

  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class CellHeaderTitleView: UIView {
  convenience init(_ titleLB: UILabel) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = .white
    
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "东南亚风情游梦幻新马", textColor:   .textBlackColor, textFont: 12.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(13.ratioHeight)
    }
  }
}

class CellMeiDuHeaderView: UIView {
  
  convenience init(headerIMV:UIImageView,nameLB: UILabel,titleLB:UILabel,activeBT:UIButton) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = .white
    
    addSubview(headerIMV)
    headerIMV.layer.cornerRadius = 17
    headerIMV.layer.masksToBounds = true
    headerIMV.snp.makeConstraints { (make) in
      make.left.equalTo(15)
      make.centerY.equalTo(self)
      make.width.equalTo(34.ratioWidth)
      make.height.equalTo(34.ratioHeight)
    }
    
    addSubview(nameLB)
    nameLB.decorateStyleOfLB(title: "辛弃疾", textColor:.black, textFont: 11.ratioHeight)
    nameLB.snp.makeConstraints { (make) in
      make.top.equalTo(headerIMV)
      make.left.equalTo(headerIMV.snp.right).offset(10)
    }
    
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "更能消愁，几番风雨几番愁，匆匆有归去。", textColor:   .textBlackColor, textFont: 11.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.bottom.equalTo(headerIMV)
      make.left.equalTo(headerIMV.snp.right).offset(10)
    }
    
    addSubview(activeBT)
    activeBT.setImage(UIImage(named: ""), for: .normal)
    activeBT.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.right.equalTo(0)
      make.width.equalTo(40.ratioWidth)
      make.height.equalTo(20.ratioHeight)
    }
  }
}

