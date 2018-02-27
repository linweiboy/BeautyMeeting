//
//  BoBaoViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/17.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation
import UIKit

class BoBaoCell: UITableViewCell,ReusableView, ProtocolBorderLineView  {
  
  var locationDirection:LineLocation = .Bottom
  var borderLineColor:UIColor =   .separateLine
  var borderLineWidth:CGFloat = 2.0
  
  let newsImageView = RoundCornerIMV()
  let newsTitleLB = UILabel()
  let newsTime = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = UIColor.white
    
    contentView.addSubview(newsImageView)
    newsImageView.image = UIImage(named: "home_meidu")
    newsImageView.snp.makeConstraints { (make) in
      make.left.equalTo(15)
      make.centerY.equalTo(self)
      make.width.equalTo(110)
      make.height.equalTo(73)
    }
    
    let playIMV = UIImageView()
    let image = UIImage(named: "play")
    playIMV.image = image
    addSubview(playIMV)
    playIMV.snp.makeConstraints { (make) in
      make.center.equalTo(newsImageView)
      make.width.equalTo(30)
      make.height.equalTo(30)
    }
    
    addSubview(newsTitleLB)
    newsTitleLB.decorateStyleOfLB(title: "几番风雨几番愁", textColor: UIColor.black, textFont: 12.ratioHeight)
    
    newsTitleLB.snp.makeConstraints { (make) in
      make.top.equalTo(newsImageView)
      make.left.equalTo(newsImageView.snp.right).offset(8)
      make.right.equalTo(-15)
    }
    
    addSubview(newsTime)
    newsTime.decorateStyleOfLB(title: "  习近平新时代中国特色社会最重要的特征是中国共产党领导。", textColor: UIColor.rgbValue(sameValue: 76), textFont:11, textAlignment: .left)
    newsTime.lineBreakMode = .byTruncatingTail
    newsTime.numberOfLines = 0
    newsTime.snp.makeConstraints { (make) in
      make.top.equalTo(newsTitleLB.snp.bottom)
      make.right.equalTo(-15)
      make.left.equalTo(newsTitleLB)
      make.bottom.equalTo(newsImageView)
    }
  }
  
  func showData() {
    //    newsImageView.kf.setImage(with: URL(string:model.coverUrl), placeholder: UIImage(named: "Media_BigLogo"))
    //    websiteIconIM.kf.setImage(with: URL(string: model.backupCoverUrl), placeholder: UIImage(named:"Media_MinLogo"))
    //    newsDetailLB.text = model.title
    //    let array = model.time.components(separatedBy: " ")
    //    newsTime.text = array[0]
  }
  
  override func draw(_ rect: CGRect) {
    drawInRect(rect)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
