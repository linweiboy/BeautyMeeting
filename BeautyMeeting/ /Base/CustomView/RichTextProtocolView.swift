//
//  RichTextProtocolView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/11/6.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation


class RichTextProtocolView: UITextView {
  
  var markedTextTapClick: ((_ tag: Int) -> ())!
  var fileNameArray: [String] = [] {
    didSet {
      setAttributedText()
    }
  }
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    isEditable = false
    backgroundColor = .clear
    font = UIFont.systemFont(ofSize: 13.ratioHeight)
    textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    for (index, name) in fileNameArray.enumerated() {
      let ran = self.text.range(of: name)!
      let pp = touches.first?.location(in: self)
      let characterR = characterRange(at: pp!)
      guard let textRange = characterR else {
        return
      }
      let start = offset(from: beginningOfDocument, to: textRange.start)
      let low = ran.lowerBound.encodedOffset
      let hei = ran.upperBound.encodedOffset
      if start >= low && start <= hei  {
        markedTextTapClick(index)
      }
    }
  }
  
  func setAttributedText() {
    let att1 = NSMutableAttributedString(string: "同意", attributes: [NSAttributedStringKey.foregroundColor :UIColor.textBlackColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
    for name in fileNameArray {
      let att = NSMutableAttributedString(string: "《\(name)》", attributes: [NSAttributedStringKey.foregroundColor :  UIColor.prittyBlue,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
      let addAtt = NSMutableAttributedString(string: "和", attributes: [NSAttributedStringKey.foregroundColor : UIColor.textBlackColor,
          NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
      att1.append(att)
      att1.append(addAtt)
    }
    att1.deleteCharacters(in: NSRange(location: att1.length - 1, length: 1))
    attributedText = att1
  }
  
  /// 自定义文字 《xx》、《xx》、《xx》
  func setAttributedTextTwoStyle(tipText:String) {
    let att1 = NSMutableAttributedString(string:tipText, attributes: [NSAttributedStringKey.foregroundColor :UIColor.tipText,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
    for name in fileNameArray {
      let att = NSMutableAttributedString(string: "《\(name)》", attributes: [NSAttributedStringKey.foregroundColor :  UIColor.prittyBlue,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
      let addAtt = NSMutableAttributedString(string: "、", attributes: [NSAttributedStringKey.foregroundColor:UIColor.textBlackColor,
                                                                         
                                                                         NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.ratioHeight)])
      att1.append(att)
      att1.append(addAtt)
    }
    att1.deleteCharacters(in: NSRange(location: att1.length - 1, length: 1))
    attributedText = att1
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
