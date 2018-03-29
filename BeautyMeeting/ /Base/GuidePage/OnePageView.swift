//
//  OnePageView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/19.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class OnePageView: UIView {
  
  var onePageViewSkipClosure:(()->())?
  
  ///含有跳过按钮
  convenience init(titleImageName:String,bottomImageCanClick:Bool = false) {
    self.init(frame:CGRect.zero)
    self.backgroundColor = .white
    
    let iconImageV = UIImageView()
    addSubview(iconImageV)
    let iconImage = UIImage(named: titleImageName)!
    iconImageV.image = iconImage
    iconImageV.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    if bottomImageCanClick {
      let immediatelyExperienceBT = UIButton(type: .custom)
      addSubview(immediatelyExperienceBT)
      immediatelyExperienceBT.addTarget(self, action: #selector(skipBTClick), for: .touchUpInside)
      immediatelyExperienceBT.snp.makeConstraints { (make) in
        make.width.equalTo(120)
        make.height.equalTo(50)
        make.centerX.equalTo(self)
        make.bottom.equalTo(self.snp.bottom).offset(-40)
      }
    }
    
  }
  
  //引导页消失
  @objc func skipBTClick() {
    if onePageViewSkipClosure != nil {
      onePageViewSkipClosure!()
    }
  }
  
}
