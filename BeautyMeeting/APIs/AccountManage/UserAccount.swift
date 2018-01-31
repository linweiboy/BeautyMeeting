//
//  UserAccount.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class UserAccount:NSObject,NSCoding {
  
  let username:String
  let accessToken:String
  let mobile:String
  let id:String
  
  init(username:String,accessToken:String,mobile:String,id:String) {
    self.username = username
    self.accessToken = accessToken
    self.mobile = mobile
    self.id = id
  }
  
  convenience init(json:JSON) {
    let userN = json["username"].stringValue
    let accessT = json["accessToken"].stringValue
    let mobileM = json["mobile"].stringValue
    let idS = json["id"].stringValue
    self.init(username:userN,accessToken:accessT,mobile:mobileM,id:idS)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(username, forKey: "username")
    aCoder.encode(accessToken, forKey: "accessToken")
    aCoder.encode(mobile, forKey: "mobile")
    aCoder.encode(id, forKey: "id")
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard aDecoder.containsValue(forKey: "username") else {
      return nil
    }
    guard aDecoder.containsValue(forKey: "accessToken") else {
      return nil
    }
    guard aDecoder.containsValue(forKey: "mobile") else {
      return nil
    }
    guard aDecoder.containsValue(forKey: "id") else{
      return nil
    }
    self.username = (aDecoder.decodeObject(forKey: "username") as? String)!
    self.accessToken = (aDecoder.decodeObject(forKey: "accessToken") as? String)!
    self.mobile = (aDecoder.decodeObject(forKey: "mobile") as? String)!
    self.id = (aDecoder.decodeObject(forKey: "id") as? String)!
    super.init()
  }
  
  override var debugDescription: String {
    return "username=\(username)" + "accessToken=\(accessToken)" + "mobile=\(mobile)" + "id=\(id)"
  }
  
  var mobileValue:String {
    guard !mobile.isEmpty,mobile.count == 11 else { return "" }
    var replaceStr = mobile
    let beginIndex = replaceStr.index(replaceStr.startIndex, offsetBy: 3)
    let endIndex = replaceStr.index(replaceStr.startIndex, offsetBy: 7)
    let range = Range(beginIndex ..< endIndex)
    replaceStr.replaceSubrange(range, with: "****")
    return replaceStr
  }
  
}
