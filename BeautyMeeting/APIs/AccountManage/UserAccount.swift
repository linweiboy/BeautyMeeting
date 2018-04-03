//
//  UserAccount.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class UserAccount:NSObject,NSCoding {
  
  let head_img_url:String
  let accessToken:String
  let mobile:String
  let id:String
  let role:String
  
  init(username:String,accessToken:String,mobile:String,id:String,role:String) {
    self.head_img_url = username
    self.accessToken = accessToken
    self.mobile = mobile
    self.id = id
    self.role = role
  }
  
  convenience init(json:JSON) {
    let head = json["head_img_url"].stringValue
    let accessT = json["accessToken"].stringValue
    let mobileM = json["mobile"].stringValue
    let idS = json["id"].stringValue
    let roleS = json["role"].stringValue
    self.init(username:head,accessToken:accessT,mobile:mobileM,id:idS,role:roleS)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(head_img_url, forKey: "head_img_url")
    aCoder.encode(accessToken, forKey: "accessToken")
    aCoder.encode(mobile, forKey: "mobile")
    aCoder.encode(id, forKey: "id")
    aCoder.encode(role, forKey: "role")
  }
  
  required init?(coder aDecoder: NSCoder) {
    guard aDecoder.containsValue(forKey: "head_img_url") else {
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
    guard aDecoder.containsValue(forKey: "role") else{
      return nil
    }
    self.head_img_url = (aDecoder.decodeObject(forKey: "head_img_url") as? String)!
    self.accessToken = (aDecoder.decodeObject(forKey: "accessToken") as? String)!
    self.mobile = (aDecoder.decodeObject(forKey: "mobile") as? String)!
    self.id = (aDecoder.decodeObject(forKey: "id") as? String)!
    self.role = (aDecoder.decodeObject(forKey: "role") as? String)!
    super.init()
  }
  
  override var debugDescription: String {
    return "head_img_url=\(head_img_url)" + "accessToken=\(accessToken)" + "mobile=\(mobile)" + "id=\(id)" + "role=\(role)"
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
