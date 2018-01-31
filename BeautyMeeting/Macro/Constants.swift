//
//  Constants.swift
//  RongTeng
//
//  Created by rongteng on 16/3/28.
//  Copyright © 2016年 Mike. All rights reserved.
//


// MARK: - 定义每页需要多少条数据
let DataOfPageNum:Int = 10

///登陆过期
let Prompt_LoginOverdue = "登录已过期！"
let loginExpireCode:Int = 301 //登录过期
let NetworkRequest_UnknownError = "未知错误"

let CustomerService = "400-611-4589"  //客服电话

//延迟几秒 页面跳转
let AfterDelayTime:TimeInterval = 1.5

// MARK: - 节日名称
let SpringFestival = "springFestival" //春节
let LanternFestival = "lanternFestival" //元宵
let ValentinesDay = "valentinesDay" //情人节
let LabourDay = "labourDay" //劳动节

//等待执行任务 回调
typealias Task = () -> Void

//js代码判断html里有没有分享内容
let ShareContent_jsScript = "document.getElementsByName(\"description\")[0].getAttribute(\"content\")"
























