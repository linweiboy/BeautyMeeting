//
//  URLDefine.swift
//  RongTeng
//
//  Created by rongteng on 16/3/28.
//  Copyright © 2016年 Mike. All rights reserved.
//

//线上版

//MARK: -小诸葛独立接口
struct XZGURL {
  struct server {
    static let formal = "https://oapi.xzgjf.com/"      //正式
    static let huidu = "http://114.55.158.120"        //灰度
    static let pre = "https://pre-wd-api.xzgjf.com/"  //预发布
    static let test = "http://test-wd-api.xzgjf.com/" //测试
    static let zeng = "http://192.168.1.161:8080/web/"
    static let lifeng = "http://192.168.1.121:8280/web/"
    static let hehe = "https://101.37.72.222/"
    static var currentUrl:String { return formal }
  }
  
  struct h5 {
    static let formal = "https://m.xzgjf.com/"      //正式
    static let test = "http://test-wd-m.xzgjf.com/" //测试
    static let pre = "http://pre-wd-m.xzgjf.com/"   //预发布
    static var currentH5:String { return formal }
  }
}

//MARK: - 国槐独立接口
struct GuoHuaiURL {
  struct server {
    static let formal = "http://api.xzgjf.cn/"       //正式
    static let test = "http://test-cf-api.xzgjf.cn/" //测试
    static let pre = "http://pre-cf-api.xzgjf.cn/"   //预发布
    static var currentUrl:String { return formal }
  }
  
  struct h5 {
    static let formal = "http://m.xzgjf.cn/"       //正式
    static let test = "http://test-cf-m.xzgjf.cn/" //测试
    static let pre = "http://pre-cf-m.xzgjf.cn/"   //预发布
    static var currentH5:String { return formal }
  }
}


//MARK: - 商城接口
struct MallURL {
  struct server {
    static let formal = "https://shop.xzgjf.com/index.php/" //正式
    static let wd = "https://shop-test.xzgjf.com/index.php/"
    static var currentUrl:String { return formal }
  }
}






