//
//  MeiHuiBusinessVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/19.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class MeiHuiBusinessVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "美会商院"
      defaultConfig()
      popLastPage()
      createView()
    }

}


extension MeiHuiBusinessVC:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: BusinessCell.reuseIdentifier) as! BusinessCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 165.ratioHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    
  }

  
}

extension MeiHuiBusinessVC {
  
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
    mainTableView.register(BusinessCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
}


class BusinessCell: UITableViewCell, ReusableView {
  
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
    
    //    addSubview(titLB)
    //    titLB.decorateStyleOfLB(title: "最美澳洲升级", textColor: .textBlackColor, textFont: 11.ratioHeight)
    //    titLB.snp.makeConstraints { (make) in
    //      make.top.equalTo(self)
    //      make.left.equalTo(13.ratioWidth)
    //      make.height.equalTo(35.ratioHeight)
    //    }
    
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



