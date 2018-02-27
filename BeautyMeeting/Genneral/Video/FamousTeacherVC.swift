//
//  FamousTeacherVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/26.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

private let NAVBAR_COLORCHANGE_POINT:CGFloat = -80
private let IMAGE_HEIGHT:CGFloat = 200
private let SCROLL_DOWN_LIMIT:CGFloat = 100
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

class FamousTeacherVC: UIViewController,PopVCSetProtocol,VcDefaultConfigProtocol {
  
  lazy var tableView:UITableView = {
    let table:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: (ScreenWidth), height: (self.view.bounds.height)), style: .plain)
    table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, 0, 65, 0);
    table.showsVerticalScrollIndicator = false
    table.delegate = self
    table.dataSource = self
    return table
  }()
  lazy var cycleScrollView:WRCycleScrollView = {
    let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: CGFloat(ScreenWidth), height: IMAGE_HEIGHT)
    let cycleView = WRCycleScrollView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
    return cycleView
  }()

    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "名师讲堂"
      defaultConfig()
      popLastPage()
      createView()
    }



}

extension FamousTeacherVC {
  
  func createView() {
    let localImages = ["http://p.lrlz.com/data/upload/mobile/special/s252/s252_05471521705899113.png",
                       "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007678060723.png",
                       "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007587372591.png",
                       "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007388249407.png",
                       "http://p.lrlz.com/data/upload/mobile/special/s303/s303_05442007470310935.png"]
    let descs = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                 "勒索病毒攻击再次爆发 国内校园网大面积感染",
                 "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                 "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                 "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]
    cycleScrollView.serverImgArray = localImages
    cycleScrollView.descTextArray = descs
    cycleScrollView.descLabelFont = UIFont.boldSystemFont(ofSize: 16)
    tableView.addSubview(cycleScrollView)
    tableView.register(BoBaoCell.self)
    view.addSubview(tableView)
    
    let footerView = UIView()
    tableView.tableFooterView = footerView
  }
}

extension FamousTeacherVC:UITableViewDelegate,UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 15
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: BoBaoCell.reuseIdentifier) as! BoBaoCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    tableView.deselectRow(at: indexPath, animated: true)
    let vc:UIViewController = UIViewController()
    vc.view.backgroundColor = UIColor.white
    let str = String(format: "知乎日报 %zd", indexPath.row)
    vc.title = str
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85.ratioHeight
  }
}

