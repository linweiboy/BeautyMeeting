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

struct ArticleModel:ProtocolUnifyModel,ProtocolParseModelList {
  
  typealias type = ArticleModel
  
  let title:String  //标题
  let itemId:Int  //文章id
  let time:String //发布时间
  let isRecommend:Bool  //是否推荐
  let description:String  //简介
  let author:String  //作者
  let backupCoverUrl:String  //备用图
  let coverUrl:String  //封面图
  let content:String  //文章内容
  
  init(json:JSON) {
    self.title = json["title"].stringValue
    self.itemId = json["itemId"].intValue
    self.time = json["time"].stringValue
    self.isRecommend = json["isRecommend"].boolValue
    self.description = json["description"].stringValue
    self.author = json["author"].stringValue
    self.backupCoverUrl = json["backupCoverUrl"].stringValue
    self.coverUrl = json["coverUrl"].stringValue
    self.content = json["content"].stringValue
  }
  
}

struct HomePortalModel: ProtocolUnifyModel {
  let catalogName:String //分组名称
  let typeCode:String  //类型
  let name:String  //标题
  let isClicked: Bool //是否可跳转
  let url: String
  let order :Int
  let catalogData:[CatalogDataModel]
  
  init(json:JSON) {
    self.catalogName = json["catalogName"].stringValue
    self.typeCode = json["typeCode"].stringValue
    self.name = json["name"].stringValue
    self.isClicked = json["isClicked"].boolValue
    self.url = json["url"].stringValue
    self.order = json["order"].intValue
    self.catalogData = CatalogDataModel.parseList(json["catalogData"])
  }
  
  static func parseList(_ json:JSON) -> [HomePortalModel] {
    let result = json["data"].arrayValue
    var rt = [HomePortalModel]()
    for item in result {
      let model = HomePortalModel(json: item)
      rt.append(model)
    }
    return rt
  }
}

struct CatalogDataModel: ProtocolUnifyModel,ProtocolParseModelList{
  typealias type = CatalogDataModel
  
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
  
  static func parseList(_ json:JSON) -> [CatalogDataModel] {
    let result = json.arrayValue
    var rt = [CatalogDataModel]()
    for item in result {
      let model = CatalogDataModel(json: item)
      rt.append(model)
    }
    return rt
  }
}


