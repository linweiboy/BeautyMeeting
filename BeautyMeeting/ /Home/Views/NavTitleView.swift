//
//  NavTitleView.swift
//  XiaoZhuGeJinFu
//
//  Created by LinweiTan on 2017/5/18.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

class NavTitleView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .main
    let titLB = UILabel()
    titLB.decorateStyleOfLB(title: "美读会", textColor: .white, textFont: 21)
//    titLB.font = UIFont.boldSystemFont(ofSize: 21)
    addSubview(titLB)
    titLB.snp.makeConstraints { (make) in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self).offset(8)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
