//
//  UITextFieldExtension.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/5/20.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation


extension UITextField {
  
  /// 系统里所有的UITextField的样式
  ///
  /// - Parameters:
  ///   - placeholderTitle: placeholderTitle
  ///   - keyboardType: keyboardType
  ///   - secureTextEntry: 输入内容是否为保密模式
  func unifyStyle(placeholderTitle:String, keyboardType:UIKeyboardType,secureTextEntry:Bool = false) {
    decorateStyleOfTF(placeholderTitle: placeholderTitle, placeholderColor:  .tipText, keyboardType: keyboardType, borderStyle:.none, secureTextEntry: secureTextEntry, textColor:  .text, textFont: 12.ratioHeight)
  }

  
}
