//
//  MeiHuiInductionSubVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/19.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class MeiHuiInductionSubVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let mainTableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      popLastPage()
      createView()
  }

}

extension MeiHuiInductionSubVC:UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "3月\(indexPath.row+1)日"
    cell.accessoryType = .disclosureIndicator
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    if indexPath.row < 3 {
      showMessage("第\(indexPath.row+1)天")
    }else{
      let showView = PlayShowView()
      showView.showView()
    }
    
  }
}

extension MeiHuiInductionSubVC {
  func createView() {
    mainTableView.separatorStyle = .singleLine
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    }
    mainTableView.clearOtioseSeparatorLine()
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.showsHorizontalScrollIndicator = false
    mainTableView.showsVerticalScrollIndicator = false
    mainTableView.backgroundColor =  .backGround
    mainTableView.register(MeiHuiPlaySubCell.self)
    self.view.addSubview(mainTableView)
    mainTableView.snp.makeConstraints { (make) in
      make.left.right.bottom.equalTo(view)
      make.top.equalTo(0)
    }
  }
}

class MeiHuiPlaySubCell: UITableViewCell, ReusableView {
  
  fileprivate let guessIMV = UIImageView()
  fileprivate let titLB = UILabel()
  
  func showDate(_ model:CatalogDataModel) {
    guessIMV.kf.setImage(with: URL(string:model.coverUrl) , placeholder: UIImage(named: "big_defualt"))
    titLB.text = model.title
  }
  override init(style: UITableViewCellStyle, reuseIdentifier: String?){
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = .white
    
    addSubview(titLB)
    titLB.decorateStyleOfLB(title: "美洲环湖哈还是", textColor: .black, textFont: 12.ratioHeight)
    titLB.snp.makeConstraints { (make) in
      make.top.equalTo(10)
      make.left.equalTo(13.ratioHeight)
    }
    
    addSubview(guessIMV)
    guessIMV.layer.cornerRadius = 5
    guessIMV.layer.masksToBounds = true
    guessIMV.image = UIImage(named: "home_guess")
    guessIMV.snp.makeConstraints { (make) in
      make.top.equalTo(titLB.snp.bottom).offset(5)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.bottom.equalTo(self.snp.bottom).offset(-10)
    }
    
    let lineView = UIView()
    addSubview(lineView)
    lineView.backgroundColor = UIColor.separateLine
    lineView.snp.makeConstraints { (make) in
      make.bottom.equalTo(self)
      make.left.equalTo(13.ratioHeight)
      make.right.equalTo(-13.ratioHeight)
      make.height.equalTo(1)
    }
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

