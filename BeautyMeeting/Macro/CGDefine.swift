//
//  CGDefine.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/7/18.
//  Copyright © 2017年 rongteng. All rights reserved.
//


class CGDefine {
  
  class width {
    
    //cell上右边显示文字的label的右边距离屏幕右边的偏移量
    static let cellRightLabelRightOffset = -25.ratioWidth
    
    //cell左边图标的CenterX距离屏幕左边的偏移量
    static let cellLeftImageCenterXOffset:CGFloat = 15 + 10
    
    //cell左边标题的左边 距离cell左边图标的CenterX的偏移量  cell左边缘---image---title
    static let cellLeftTitleLeftFromImageCenterXOffset:CGFloat = 20
  }
  
  class height {
    static let wealthTopAccumulateInfo:CGFloat = 200
    static let textField = 40.ratioHeight  //TextField统一高度
    static let maxButton = 40.ratioHeight  //Button统一高度
    static let separate:CGFloat = 10 // 所有页面的大一点儿的 统一间隔
    static let buttonSeparate:CGFloat = 40 // 所有页面的大一点儿的 统一间隔
  }
}





