//
//  UIButtonExtension.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/6/8.
//  Copyright © 2017年 rongteng. All rights reserved.
//


extension RoundCornerBT {
  
  /// 系统里统一的确认、完成、购买...等按钮的样式
  ///
  /// - Parameter title: 标题
  /// - Returns: 圆角button
  override class func unifyConfirmBT(title:String) -> RoundCornerBT {
    let bt = RoundCornerBT(type: .custom)
    bt.decorateStyleOfBT(title:title, textColor: .white, textFont: FontDefine.fifteen)
    let confirmBTNormalImage = UIImage.createImageWithColor(.main)
    let confirmBTDisabledImage = UIImage.createImageWithColor(.buttonDeselect)
    bt.setBackgroundImage(confirmBTNormalImage, for: .normal)
    bt.setBackgroundImage(confirmBTDisabledImage, for: .disabled)
    return bt
  }
  
}

extension UIButton {
  /// 系统里统一的确认、完成、购买...等按钮的样式
  ///
  /// - Parameter title: 标题
  /// - Returns: 正常button
  @objc class func unifyConfirmBT(title:String) -> UIButton {
    let bt = UIButton(type: .custom)
    bt.decorateStyleOfBT(title:title, textColor: .white, textFont: FontDefine.fifteen)
    let confirmBTNormalImage = UIImage.createImageWithColor(.main)
    let confirmBTDisabledImage = UIImage.createImageWithColor(.buttonDeselect)
    bt.setBackgroundImage(confirmBTNormalImage, for: .normal)
    bt.setBackgroundImage(confirmBTDisabledImage, for: .disabled)
    return bt
  }
}

