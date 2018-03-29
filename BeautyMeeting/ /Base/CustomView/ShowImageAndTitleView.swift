//
//  ShowImageAndTitleView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/1.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class ShowImageAndTitleView: UIView {
  
  fileprivate let noteLB = UILabel()
  fileprivate let imageV = UIImageView()
  fileprivate let titleLB = UILabel()
  
  convenience init(titleFont:CGFloat,titleColor:UIColor) {
    self.init(frame:CGRect.zero)
    self.clipsToBounds = false
    
    addSubview(noteLB)
    noteLB.decorateStyleOfLB(title: "点击选择银行", textColor:   .garyTitleColor, textFont: titleFont)
    noteLB.snp.makeConstraints { (make) in
      make.left.equalTo(0)
      make.centerY.equalTo(self)
    }
    
    addSubview(imageV)
    imageV.contentMode = .scaleAspectFit
    imageV.snp.makeConstraints { (make) in
      make.left.equalTo(0)
      make.centerY.equalTo(self)
      make.height.width.equalTo(12)
    }
    
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "", textColor: titleColor, textFont: titleFont)
    titleLB.snp.makeConstraints { (make) in
      make.left.equalTo(imageV.snp.right).offset(5)
      make.centerY.equalTo(self)
    }
  }
  
  func showUrlImageAndTitle(_ imageUrl:String,text:String) {
    noteLB.isHidden = true
    imageV.kf.setImage(with: URL(string:imageUrl ), placeholder: UIImage(named: "upLoadFailure_26"))
    titleLB.text = text
  }
  
  func showLocalImageAndTitle(_ imageName:String,text:String) {
    noteLB.isHidden = true
    imageV.image = UIImage(named: imageName)
    titleLB.text = text
  }
  
}

class ShowSafeAndTitleView: UITableViewHeaderFooterView,ReusableView {
  
  fileprivate let imageV = UIImageView()
  fileprivate let titleLB = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)

    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "", textColor: UIColor.rgbValue(sameValue: 153), textFont: 11.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.centerX.equalTo(self.snp.centerX).offset(5)
      make.centerY.equalTo(self)
    }
    
    addSubview(imageV)
    imageV.contentMode = .scaleAspectFit
    imageV.snp.makeConstraints { (make) in
      make.right.equalTo(titleLB.snp.left).offset(-5)
      make.centerY.equalTo(self)
      make.height.width.equalTo(12)
    }
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showLocalImageAndTitle(_ imageName:String,text:String) {
    imageV.image = UIImage(named: imageName)
    titleLB.text = text
  }
  
}

