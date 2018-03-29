//
//  VersionUpdateModel.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/9/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//

struct VersionUpdateModel:ProtocolUnifyModel {
  
  let status:String //更新指示
  let url:String //更新地址
  let description:String //更新内容
  let version:String //最新版本号
  
  init(json: JSON) {
    self.status = json["status"].stringValue
    self.url = json["url"].stringValue
    self.description = json["description"].stringValue
    self.version = json["version"].stringValue
  }
}
