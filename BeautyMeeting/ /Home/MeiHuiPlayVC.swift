//
//  MeiHuiPlayVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/19.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit
import MJRefresh

//美会播报
class MeiHuiPlayVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "美会播报"
      defaultConfig()
      popLastPage()
      createView()
    }
  


}

extension MeiHuiPlayVC:UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PlayCell.reuseIdentifier) as! PlayCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let vc = MeiHuiInductionSubVC()
    vc.navigationItem.title = "每日早读"
    pushTo(vc)
    
  }
  
}

extension MeiHuiPlayVC{
  
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
    mainTableView.register(PlayCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
  
}


class PlayCell: UITableViewCell, ReusableView {
  
  fileprivate let guessIMV = UIImageView()
  fileprivate let titLB = UILabel()
  
  func showDate(_ model:CatalogDataModel) {
    guessIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
    titLB.text = model.title
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let backView = UIView()
    backView.backgroundColor = UIColor.backGround
    addSubview(backView)
    backView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    addSubview(guessIMV)
    guessIMV.layer.cornerRadius = 5
    guessIMV.layer.masksToBounds = true
    guessIMV.image = UIImage(named: "home_guess")
    guessIMV.snp.makeConstraints { (make) in
      make.top.equalTo(backView.snp.top).offset(10)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.bottom.equalTo(backView.snp.bottom).offset(-10)
    }
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class PlayShowView: UIView,ProtocolMaskShowView {
  
  var payClickClosure:(()->())?
  
  var maskAnimationView:UIView! = UIView()
  
  override init(frame: CGRect) {
    let conentFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: ScreenWidth-120, height: 120))
    super.init(frame: conentFrame)
    self.backgroundColor = .white
    let titleLB = UILabel()
    addSubview(titleLB)
    titleLB.decorateStyleOfLB(title: "这个需要付费哟", textColor: .black, textFont: 13.ratioHeight)
    titleLB.snp.makeConstraints { (make) in
      make.top.equalTo(10)
      make.centerX.equalTo(self)
      make.height.equalTo(20.ratioHeight)
    }
    
    let loginBT = UIButton(type: .custom)
    loginBT.layer.masksToBounds = true
    loginBT.layer.cornerRadius = 15
    loginBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    loginBT.decorateStyleOfBT(title: "去支付", textColor: UIColor.white, textFont: 12.ratioHeight, backGroundColor:   .main)
    addSubview(loginBT)
    loginBT.snp.makeConstraints { (make) in
      make.width.equalTo(80)
      make.height.equalTo(30)
      make.right.equalTo(self.snp.right).offset(-22.ratioWidth)
      make.bottom.equalTo(self.snp.bottom).offset(-18)
    }
    
    let registerBT = UIButton(type: .custom)
    registerBT.layer.masksToBounds = true
    registerBT.layer.cornerRadius = 15
    registerBT.addTarget(self, action: #selector(trunOffBTClick), for: .touchUpInside)
    registerBT.decorateStyleOfBT(title: "取消", textColor: UIColor.white, textFont: 12.ratioHeight, backGroundColor:   .gray)
    addSubview(registerBT)
    registerBT.snp.makeConstraints { (make) in
      make.width.equalTo(loginBT)
      make.height.equalTo(loginBT)
      make.left.equalTo(self.snp.left).offset(22.ratioHeight)
      make.bottom.equalTo(loginBT)
    }

    
    //关闭按钮
    let trunOffBT = UIButton(type: .custom)
    addSubview(trunOffBT)
    trunOffBT.addTarget(self, action: #selector(trunOffBTClick), for: .touchUpInside)
    trunOffBT.setImage(UIImage(named: "PaymentInfo_Close"), for: .normal)
    trunOffBT.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
    trunOffBT.snp.makeConstraints { (make) in
      make.top.right.equalTo(self)
      make.width.equalTo(50)
      make.height.equalTo(25)
    }
    
    
  }
  
  @objc func btClick() {
    if payClickClosure != nil {
      payClickClosure!()
    }
    dismissView(nil)
  }

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func trunOffBTClick() {
    dismissView(nil)
  }
  
  override func draw(_ rect: CGRect) {
    self.layer.cornerRadius = 5
    self.layer.masksToBounds = true
  }
  
}
