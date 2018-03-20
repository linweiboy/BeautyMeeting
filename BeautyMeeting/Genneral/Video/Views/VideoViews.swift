//
//  VideoViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/11.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation
import UIKit

class VideoTabHeaderView: UITableViewHeaderFooterView, ReusableView {
  
  var headerClickClosuer:((_ tag: Int)->())?
  
  fileprivate var popularizeView = PopularizeView()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.backgroundColor =  .backGround
    
    let titles = ["栏目播报","健康讲堂","情感天地","我要播报"]
    let images = ["mediue","home_bankstoremanage","home_bankstoremanage","SafeGuarantee"]
    popularizeView = PopularizeView(count: 4)
    addSubview(popularizeView)
    popularizeView.fileValueWith(titles: titles, imageNames: images)
    popularizeView.selectClosure = {[unowned self] (tag) in
      if self.headerClickClosuer != nil {
        self.headerClickClosuer!(tag)
      }
    }
    popularizeView.snp.makeConstraints { (make) in
      make.height.equalTo(80.ratioHeight)
      make.left.right.equalTo(self)
      make.top.equalTo(0)
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class VideoCustomTitleView: UICollectionReusableView, ReusableView {
  
  
  
  override init(frame:CGRect) {
    super.init(frame: frame)
    self.backgroundColor =  .white
    
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}






class VideoCell: UITableViewCell, ReusableView {
  
  fileprivate let backIMV = UIImageView()
  fileprivate let detailLB = UILabel()
  fileprivate let nameLB = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
//    self.backgroundColor = .white
    
    addSubview(backIMV)
    backIMV.image = UIImage(named: "video_defulat")
    backIMV.layer.cornerRadius = 5
    backIMV.layer.masksToBounds = true
    backIMV.snp.makeConstraints { (make) in
      make.top.equalTo(10)
      make.left.equalTo(15.ratioWidth)
      make.right.equalTo(-15.ratioWidth)
      make.height.equalTo(120.ratioHeight)
    }
    
    let playIMV = UIImageView()
    let image = UIImage(named: "play")
    playIMV.image = image
    addSubview(playIMV)
    playIMV.snp.makeConstraints { (make) in
      make.center.equalTo(backIMV)
      make.width.equalTo(30)
      make.height.equalTo(30)
    }
    
    addSubview(detailLB)
    detailLB.decorateStyleOfLB(title: "欧洲经济近代变化", textColor: .black, textFont: 11.ratioHeight)
    detailLB.snp.makeConstraints { (make) in
      make.left.equalTo(backIMV)
      make.top.equalTo(backIMV.snp.bottom).offset(8)
    }
    
    let line = UIView()
    addSubview(line)
    line.backgroundColor = UIColor.backGround
    line.snp.makeConstraints { (make) in
      make.left.equalTo(15.ratioWidth)
      make.right.equalTo(-15.ratioWidth)
      make.bottom.equalTo(self)
      make.height.equalTo(0.5)
    }
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class CustomNameView:UIView{
  convenience init(nameLB:UILabel){
    self.init(frame: CGRect.zero)
    self.backgroundColor = .black
    
    addSubview(nameLB)
    nameLB.decorateStyleOfLB(title: "演讲者：沫沫", textColor: .white, textFont: 11.ratioHeight)
    nameLB.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.left.equalTo(5.ratioWidth)
    }
    
    self.alpha = 0.4
  }
}












let goodsCellLayout_itemWidth = 145.ratioWidth
let goodsSectionXOffset:CGFloat = 10

class VideoCellLayout: UICollectionViewFlowLayout {
  
  override init() {
    super.init()
    self.itemSize = CGSize(width: goodsCellLayout_itemWidth, height: 130.ratioHeight)
    self.scrollDirection = .vertical
    //最小间距
    self.minimumLineSpacing = 15
    //最左边和最右边 内容偏移10
    self.sectionInset = UIEdgeInsets(top: 10, left: goodsSectionXOffset, bottom: 10, right: goodsSectionXOffset)
}
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
