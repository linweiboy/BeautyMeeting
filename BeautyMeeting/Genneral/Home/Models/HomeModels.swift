//
//  HomeModels.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/5.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation

struct BannarModel:ProtocolUnifyModel,ProtocolParseModelList {
  
  typealias type=BannarModel
  
  let imgUrl:String //image图片
  let link:String  //外部链接
  let title:String  //标题
  
  init(json:JSON) {
    self.imgUrl = json["imgUrl"].stringValue
    self.link = json["link"].stringValue
    self.title = json["title"].stringValue
  }
}

struct DiscoverListModel: ProtocolUnifyModel, ProtocolParseModelList{
  
  typealias type = DiscoverListModel
  
  let imgUrl:String
  let title:String
  let endDate:String
  let startDate:String
  let link:String
  
  init(json: JSON) {
    self.imgUrl = json["imgUrl"].stringValue
    self.title = json["title"].stringValue
    self.endDate = json["endDate"].stringValue
    self.startDate = json["startDate"].stringValue
    self.link = json["link"].stringValue
  }
    
  func timeTranform(_ time:String) -> String {
    let array = time.components(separatedBy: " ")
    return array[0]
  }
}


