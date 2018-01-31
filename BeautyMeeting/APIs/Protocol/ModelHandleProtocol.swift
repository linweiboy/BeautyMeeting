//
//  ModelHandleProtocol.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/7/25.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import Foundation


//统一初始化方法的协议
protocol ProtocolUnifyModel {
  init(json:JSON)
}

//网贷数据相应返回的model
struct CommonModel:ProtocolUnifyModel {
  let isSuccess:Bool
  let message:String
  let page:Int
  let size:Int
  let status:Int
  let totalCount:Int
  
  init(json:JSON) {
    self.isSuccess = json["isSuccess"].boolValue
    self.message = json["message"].stringValue
    self.page = json["page"].intValue
    self.size = json["size"].intValue
    self.status = json["status"].intValue
    self.totalCount = json["totalCount"].intValue
  }
}


//解析列表数据的协议
protocol ProtocolParseModelList {
  associatedtype type:ProtocolUnifyModel
  static func parseListForData(_ json:JSON) -> [type]
  static func parseListForDataList(_ json:JSON) -> [type]
}

extension ProtocolParseModelList {
  
  static func parseListForData(_ json:JSON) -> [type] {
    let resultArray = json["data"].arrayValue
    var rt = [type]()
    for item in resultArray {
      let model = type(json:item)
      rt.append(model)
    }
    return rt
  }
  
  static func parseListForDataList(_ json:JSON) -> [type] {
    let resultArray = json["data"]["list"].arrayValue
    var rt = [type]()
    for item in resultArray {
      let model = type(json:item)
      rt.append(model)
    }
    return rt
  }
}


//处理财富产品的年化收益
protocol FinanceExpHandleProtocol {
  func loanRateAndSubsidyRateValue(exp:String,reward:Double,
                                   oneFont:CGFloat,twoFont:CGFloat) -> NSAttributedString
}

extension FinanceExpHandleProtocol where Self:ProtocolUnifyModel {
  
  //以~分开
  func getExpArrorDispValues(exp:String) -> ([Double]) {
    let newExp = exp.replacingOccurrences(of: "%", with: "")
    if exp.contains("~") {
      let arr = newExp.components(separatedBy: "~")
      guard let firstStr = arr.first,let secStr = arr.last else {
        return []
      }
      guard let firstNum = firstStr.doubleValue,let secNum = secStr.doubleValue else {
        return []
      }
      return [firstNum.toDecimal, secNum.toDecimal]
    } else {
      guard let firstNum = newExp.doubleValue else {
        return []
      }
      return [firstNum.toDecimal]
    }
  }
  
  
  func separateExparrorDisp(exp:String) -> [(first:String, sec:String)] {
    let values = getExpArrorDispValues(exp:exp)
    var ss: [(String, String)] = []
    for item in values {
      let dd = item.stringValue.components(separatedBy: ".")
      ss.append((dd.first!, dd.last!))
    }
    return ss
  }
  
  //年化收益+奖励收益
  func loanRateAndSubsidyRateValue(exp:String,reward:Double,oneFont:CGFloat,
                                   twoFont:CGFloat) -> NSAttributedString {
    
    let dispAtt = NSMutableAttributedString()
    let color = UIColor(hexStr: "FF5259")
    let expArr = separateExparrorDisp(exp:exp)
    
    var addStr = "%~"
    for (index,item) in expArr.enumerated()  {
      if index == expArr.count - 1 { addStr = "%" }
      let att = NSAttributedString.attributedOfTwoPartWithSameColor(foregroundColor: color, onePartTitle:item.first, onePartFontSize: oneFont, twoPartTitle: "." + item.sec + addStr, twoPartFontSize: twoFont)
      dispAtt.append(att)
    }
    
    if reward > 0 {
      let attr = NSAttributedString(string: "+" + reward.toDecimalString + "%", attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: UIFont.systemFont(ofSize: twoFont)])
      dispAtt.append(attr)
    }
    return dispAtt
  }
  
}
