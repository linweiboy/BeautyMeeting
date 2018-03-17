//
//  DailyReadModels.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/16.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation

struct DailyReadModel: ProtocolUnifyModel, ProtocolParseModelList{
  
  typealias type = DailyReadModel
  
  let itemId: String
  let isRecommend: String
  let redirectUrl: String
  let coverUrl: String
  let description: String
  let title: String
  let author: String
  let time: String
  let content:String
  
  
  init(json: JSON) {
    self.itemId = json["itemId"].stringValue
    self.isRecommend = json["isRecommend"].stringValue
    self.redirectUrl = json["redirectUrl"].stringValue
    self.coverUrl = json["coverUrl"].stringValue
    self.description = json["description"].stringValue
    self.title = json["title"].stringValue
    self.author = json["author"].stringValue
    self.time = json["time"].stringValue
    self.content = json["content"].stringValue
  }
  
  static func parseList(_ json:JSON) -> [DailyReadModel] {
    let result = json["data"].arrayValue
    var rt = [DailyReadModel]()
    for item in result {
      let model = DailyReadModel(json: item)
      rt.append(model)
    }
    return rt
  }

}
