//
//  SignHelper.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/7.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import Foundation

class SignHelper {
  
  ///待加密参数按key的字母顺序排序，[注：sign字段不需要参与加密]
  ///把所有参数名和参数值串在一起 前面拼上AppSecret
  ///转换为UTF-8格式后 使用MD5加密生成加密byte数组
  ///把二进制转化为大写的十六进制
  class func XZGSignWith(_ param: [String:String]) -> String  {
    let newDic = param.sorted { $0.0 < $1.0 }
    let combinStr = newDic.map{ $0+$1 }.joined(separator: "")
    let addSecretStr = PlatformKey.AppSecret + combinStr
    let md5ResultStr = addSecretStr.md5
    let resultStr = md5ResultStr.uppercased()
    return resultStr
  }
  
  class func JFSCSignWith(_ signStr:String) -> String{
    let md5ResultStr = signStr.md5
    let resultStr = md5ResultStr.uppercased()
    return resultStr
  }
  
}



















