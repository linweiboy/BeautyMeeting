//
//  UILabelExtension.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/11/30.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

extension UILabel {
  
//  产品标签上的文字 更新宽度 因为自适应的话 距离左右两边太紧
  func updateWidthConstraint() {
    guard let text = self.text, !text.isEmpty else { return }
    let font = (self.font != nil) ? self.font! : UIFont.systemFont(ofSize: 11)
    let wid = text.getWidth(maxWidth: 100, font:font.pointSize)
    self.snp.updateConstraints { (make) in
      make.width.equalTo(wid + 6)
    }
  }
  
}
