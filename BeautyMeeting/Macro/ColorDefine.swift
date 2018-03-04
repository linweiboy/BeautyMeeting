//
//   swift
//  RongTeng
//
//  Created by rongteng on 16/3/18.
//  Copyright © 2016年 Mike. All rights reserved.
//

//色值

extension UIColor {
  
  //冰冷寂寞的色值
  static let c3D3D3D = UIColor(hexStr: "3D3D3D")
  static let c666666 = UIColor(hexStr: "666666")
  
  static let main = UIColor(hexStr: "FF7C52")  //主色 看上去橘黄色
  static let second = UIColor(hexStr: "FFC947")  //辅色 看上去是橙色
  static let number = UIColor(hexStr: "F26261")  //数字 看上去是红色
  static let title = UIColor(hexStr: "1B1B1B")  //标题 看上去是黑色
  static let text = UIColor(hexStr: "5E5E5E")  //正文 看上去是深灰色
  static let tipText = UIColor(hexStr: "BCBCBC")  //提示性文字 看上去是灰色
  static let separateLine = UIColor(hexStr: "EDEDED")  //分割线颜色 看上去是淡灰色
  
  static let backGround = UIColor(hexStr: "EFEFEF")
  static let textRed  = UIColor(hexStr: "FF0101")
  static let prittyBlue = UIColor(hexStr: "4CADFE")
  static let buttonDeselect = UIColor(hexStr: "4CADFE").withAlphaComponent(0.5)
  static let textField = UIColor(hexStr: "9CA4AE")
  static let borderLine = UIColor(hexStr: "9CA4AE") //边界分隔线颜色
  static let orangeColor  = UIColor(hexStr: "FF7F00")
  static let garyTitleColor = UIColor(hexStr: "A5A5A5") //浅灰色字体
  static let bankColor = UIColor(hexStr: "0066B3") //完善银行卡
  static let userBackLB = UIColor(hexStr: "E05320")
  //富有感情的色值
  static var textBlackColor:UIColor { //黑色文字颜色
    return c3D3D3D
  }
  
}


















