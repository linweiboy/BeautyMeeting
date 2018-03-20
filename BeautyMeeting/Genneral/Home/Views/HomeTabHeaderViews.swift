//
//  HomeTabHeaderViews.swift
//  XiaoZhuGeJinFu
//
//  Created by LinweiTan on 2017/5/17.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation

enum NoticeClickType {
  case More
  case Deatil
}

class HomeTabFirstHeaderView: UITableViewHeaderFooterView, ReusableView {
  
  var clickBannerClosure:((_ index:Int)->())? ////广告视图点击
//  var noticeClickClosure:((_ type:NoticeClickType, _ index:Int)->())? //广告点击
  
  fileprivate let bannerView = TopBannerView() //广告视图
//  fileprivate var popularizeView = PopularizeView()
//  fileprivate let noticeView = HomeNoticeView()  //公告视图

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor =  .backGround
    //bannar视图
    addSubview(bannerView)
    bannerView.tapClickClosure = { [unowned self] index in
    if self.clickBannerClosure != nil{self.clickBannerClosure!(index)}
    }
    bannerView.snp.makeConstraints({ (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(150.ratioHeight)
    })
    
//    //广告视图
//    addSubview(noticeView)
//    noticeView.passCurrentIndexClosure = {[unowned self] index in
//      if self.noticeClickClosure != nil {self.noticeClickClosure!(.Deatil,index)}
//    }
//    noticeView.snp.makeConstraints { (make) in
//      make.top.equalTo(bannerView.snp.bottom)
//      make.left.equalTo(self)
//      make.width.equalTo(ScreenWidth)
//      make.height.equalTo(25.ratioHeight)
//    }
    
    
  }
  
  func showBannerDate(_ bannerUrlList:[String]){
    bannerView.startScrollWithImageList(bannerUrlList)
  }
  
//  func showNoticeDate(_ noticeList:[String]) {
//    noticeView.startScrollWithTitleArray(noticeList)
//  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class CustomTabHeaderView: UIView {
  
  var moreClickClosure:(()->())?
  
  fileprivate let titleNameLB = UILabel()
  fileprivate let moreTB = UIButton(type: .custom)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    
    let image = UIImage(named: "rectangle")
    let bellIV = UIImageView(image: image)
    self.addSubview(bellIV)
    bellIV.snp.makeConstraints { (make) in
      make.left.equalTo(self).offset(15)
      make.centerY.equalTo(self)
      make.width.equalTo((image?.width)!)
      make.height.equalTo((image?.height)!+8)
    }
    
    addSubview(titleNameLB)
    titleNameLB.decorateStyleOfLB(title: "", textColor:  .title, textFont: 15.ratioHeight)
    titleNameLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(bellIV.snp.right).offset(4)
    }
    
    addSubview(moreTB)
    moreTB.decorateStyleOfBT(title: "更多", textColor: .main, textFont: 11.ratioHeight)
    moreTB.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
    moreTB.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
    moreTB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.right.equalTo(-15.ratioHeight)
      make.width.equalTo(40.ratioHeight)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    let lineView = UIView()
    addSubview(lineView)
    lineView.backgroundColor =   .separateLine
    lineView.snp.makeConstraints { (make) in
      make.left.equalTo(titleNameLB.snp.left)
      make.right.equalTo(moreTB.snp.right)
      make.height.equalTo(0.5)
      make.bottom.equalTo(self)
    }
  }
  
  @objc func moreClick() {
    if moreClickClosure != nil {
      moreClickClosure!()
    }
  }
  
  func showTitleDateStr(_ titleStr: String,moreLBIsHidden: Bool) {
    titleNameLB.text = titleStr
    moreTB.isHidden = moreLBIsHidden
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}




