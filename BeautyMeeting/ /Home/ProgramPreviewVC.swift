//
//  ProgramPreviewVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/26.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//
//节目预告列表
import UIKit
import MJRefresh

class ProgramPreviewVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "节目预告"
      defaultConfig()
      popLastPage()
      createView()
    }
}

extension ProgramPreviewVC:UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProgramPreviewCell.reuseIdentifier) as! ProgramPreviewCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
//    let vc = MeiHuiInductionSubVC()
//    vc.navigationItem.title = "每日早读"
//    pushTo(vc)
    
  }
  
}

extension ProgramPreviewVC{
  
  func createView() {
    mainTableView.separatorStyle = .none
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.register(ProgramPreviewCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
  
}


class ProgramPreviewCell: UITableViewCell, ReusableView {
  
  fileprivate let guessIMV = UIImageView()
  fileprivate let titleNameLB = UILabel()
  fileprivate let timeLimitLB = UILabel()

  
  func showDate(_ model:CatalogDataModel) {
    guessIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
    
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.backGround
    
    let backView = UIView()
    backView.backgroundColor = UIColor.white
    addSubview(backView)
    backView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.bottom.equalTo(-3)
    }
    
    backView.addSubview(guessIMV)
    guessIMV.layer.cornerRadius = 5
    guessIMV.layer.masksToBounds = true
    guessIMV.image = UIImage(named: "home_guess")
    guessIMV.snp.makeConstraints { (make) in
      make.top.equalTo(backView.snp.top).offset(10)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.height.equalTo(120)
    }
    
    backView.addSubview(titleNameLB)
    titleNameLB.decorateStyleOfLB(title: "摸鱼儿.更能消几番风月", textColor: .black, textFont: 13.ratioHeight)
    titleNameLB.snp.makeConstraints { (make) in
      make.top.equalTo(guessIMV.snp.bottom).offset(10)
      make.left.equalTo(15)
    }
    
    backView.addSubview(timeLimitLB)
    timeLimitLB.decorateStyleOfLB(title: "2017-10-10 22:10", textColor: .tipText, textFont: 11.ratioHeight)
    timeLimitLB.snp.makeConstraints { (make) in
      make.top.equalTo(titleNameLB.snp.bottom).offset(5)
      make.left.equalTo(15)
    }

    
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
