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
    static let formal = "http://b.oof.com.cn/"      //正式
    static let huidu = "http://222.73.216.198/meiduhui/index.php/"        //灰度
    static var currentUrl:String { return huidu }
  }
}



