//
//  BaseDataExtension.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/2/28.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation

extension Double {
  
  ///单位元转换为万元
  var toBankLimitAmountString: String {
    if self >= 10000 {
      let amount = self/10000
      return amount.judgeDoubleOrInt + "万元"
    }
    return self.judgeDoubleOrInt + "元"
  }
  
}

//MARK:分割时间（年月日、时分秒） //分割时间，以空格(" ")分割
extension String {
  
  func splitTime(_ segmentationCharacter:String) -> [String] {
    let array = self.components(separatedBy: segmentationCharacter)
    return array
  }
  
}


















