//
//  UtilsAdd.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/4/10.
//  Copyright © 2017年 rongteng. All rights reserved.
//

//统一放大html里文字的大小
//    if webView == contentWebView {
//      let fontBig = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"
//      contentWebView.evaluateJavaScript(fontBig, completionHandler: nil)
//
//      let colorValue = "document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#4c4c4c'"
//      contentWebView.evaluateJavaScript(colorValue, completionHandler: nil)
//    }


extension RegularManage {
  
  ///是否是 正确的手机号码
  public class func isPhoneNumber(_ targetStr:String) -> Bool {
    if targetStr.isEmpty {
      return false
    }
    // ^匹配开始位置  $匹配结束位置
    let regex = "^((13[0-9])|(14[0-9])|(17[0-9])|(19[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$"
    let predicte = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicte.evaluate(with: targetStr)
  }
  
}


extension String {
//  //MARK: - Range 转 NSRange
//  func nsRange(from range: Range<String.Index>) -> NSRange {
//    let from = range.lowerBound.samePosition(in: utf16)
//    let to = range.upperBound.samePosition(in: utf16)
//
//    let dd = NSRange(location: <#T##Int#>, length: <#T##Int#>)
//
//    return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
//                   length: utf16.distance(from: from, to: to))
//  }
}


extension Double {
  
  var stringValue:String {
//    let intValue = floor(self)
//    if self > intValue {
//      return String(self)
//    }else {
//      return String(self) + "0"
//    }
    
    //正常使用 String(self)  会出现
    //1、如1.40  返回的是1.4
    //2、如1.00 或者 1 返回的是1.0
    //3、其它的正常显现 4.59 返回4.59
    let strValue = String(self)
    let subStrArr = strValue.components(separatedBy: ".")
    guard subStrArr.count == 2 else { return strValue}
    let lastStr = subStrArr[1]
    if lastStr.count >= 2 {
      return strValue
    }else {
      return subStrArr[0] + "." + lastStr + "0"
    }
  }
  
  //小数点后有有效值就返回保留2位小数的值  小数点后无有效值就返回整数值
  var intStrOrDecimalStr:String  {
    let intValue = floor(self)
    if self > intValue {
      return stringValue
    }else {
      return toIntString
    }
  }
}

extension UIButton {
  
  // 替换UIButtonExtension.swift 中 方法: public func decorateStyleOfBT(title:String,textColor:UIColor,textFont:CGFloat,backGroundColor:UIColor = UIColor.white,rightImage: UIImage)  替换之后我的积分_做任务赚积分那里有一个调用也要改一下
  public func decorateStyleOfBT(title:String,textColor:UIColor,textFont:CGFloat,backGroundColor:UIColor = UIColor.white,rightImage name: String) {
    let img = UIImage(named: name)
    self.imageView?.contentMode = .center
    self.setImage(img, for: .normal)
    var titleSize = CGRect();
    let size2 = CGSize();
    titleSize = title.boundingRect(with: size2, options: NSStringDrawingOptions.usesFontLeading, attributes: nil, context: nil)
    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(img!.size.width * 2), bottom: 0, right: 0)
    self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -((titleSize.width * 2) + 55))
    self.titleLabel?.contentMode = .center
    self.decorateStyleOfBT(title: title, textColor: textColor, textFont: textFont, backGroundColor: backGroundColor)
  }
  
}

public class RoundCornerIMV: UIImageView {
  public var btRadius:CGFloat = 5
  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: btRadius, height: btRadius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = rect; //设置大小
    maskLayer.path = maskPath.cgPath;  //设置图形样子
    self.layer.mask = maskLayer;
    
  }
  
}

