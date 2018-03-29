//
//  ActivityViews.swift
//  XiaoZhuGeJinFu
//
//  Created by rongtengjituan on 2017/5/26.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation

class ActivityHeaderView: UIView, ProtocolHeadButtonSwitch {
  
  var activityStatusClosure:((_ tag: Int)->())?
  
  var firstBT: UIButton! = UIButton(type: .custom)
  var backView:RoundCornerView!
  
  fileprivate var selectBT:UIButton! //记录刚开始第一个按钮被选择
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    self.backgroundColor =  .backGround
    backView = RoundCornerView(borderColor:   .prittyBlue, radian: (headHeight/2))
    
    //必须要实现的
    selectBT = firstBT
    selectBT.isSelected = true
    createView(titleStrArray: ["进行中","未开始","已结束"],sel:#selector(selectCurrentTypeClick))
  }
  
  @objc func selectCurrentTypeClick(_ bt:UIButton) {
    guard selectBT != bt else {return}
    commonSelected(bt)
    if activityStatusClosure != nil {
      activityStatusClosure!(bt.tag)
    }
  }
  
  //要实现的外部方法
  fileprivate func commonSelected(_ bt:UIButton) {
    selectBT.isSelected = false
    selectBT = bt
    selectBT.isSelected = true
    backView.snp.remakeConstraints({ (make) in
      make.centerY.equalTo(selectBT!)
      make.centerX.equalTo(selectBT!)
      make.width.equalTo(selectBT!)
      make.height.equalTo(28.ratioHeight)
    })
    UIView.animate(withDuration: 0.2) {
      self.layoutIfNeeded()
    }
  }
  
  //让外界通过tag值 选择对应的按钮
  func selectedButton(_ tag:Int) {
    if let bt = self.viewWithTag(tag) as? UIButton {
      commonSelected(bt)
    }
  }
  
  override func draw(_ rect: CGRect) {
    drawInRect(rect)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


//最新活动
class ActiveListCell: UITableViewCell, ReusableView {
  
  fileprivate let activityTitleLB = UILabel() //活动标题
  fileprivate let activityIMV = UIImageView() //活动图片
  fileprivate let acttivityTimeLB = UILabel() //活动时间
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    let titleView = CellHeaderTitleView(activityTitleLB)
    addSubview(titleView)
    titleView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(35.ratioHeight)
    }
    
    addSubview(activityIMV)
    activityIMV.backgroundColor =   .garyTitleColor
    activityIMV.image = UIImage(named: "home_active_defulat")
    activityIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titleView.snp.bottom)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.height.equalTo(125.ratioHeight)
    }
    
    addSubview(acttivityTimeLB)
    acttivityTimeLB.decorateStyleOfLB(title: "2017-10-10 23：00", textColor:  .title, textFont: 12)
    acttivityTimeLB.snp.makeConstraints { (make) in
      make.top.equalTo(activityIMV.snp.bottom).offset(5.ratioHeight)
      make.left.equalTo(13.ratioHeight)
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
  
  func showData(_ model: DiscoverListModel) {
    activityTitleLB.text = model.title
    activityIMV.kf.setImage(with: URL(string: model.imgUrl), placeholder: UIImage(named: "home_active_defulat"))
    acttivityTimeLB.text = model.timeTranform(model.startDate) + "~" + model.timeTranform(model.endDate)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


