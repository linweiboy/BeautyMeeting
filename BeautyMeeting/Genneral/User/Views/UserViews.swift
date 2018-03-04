//
//  UserViews.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/27.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import Foundation
import UIKit


class UserView:UIView {
  
  var headerClick:(()->())?
  
  fileprivate let headerIMV = UIImageView()
  fileprivate var idTitleLB = UILabel()
  fileprivate let nameLB = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let backIMV = UIImageView()
    backIMV.image = UIImage(named: "user_header")
    addSubview(backIMV)
    backIMV.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(175.ratioHeight)
    }
    
    
    addSubview(headerIMV)
    headerIMV.isUserInteractionEnabled = true
    let image = UIImage(named: "toux")
    headerIMV.image = image
    headerIMV.snp.makeConstraints { (make) in
      make.left.equalTo(20.ratioWidth)
      make.centerY.equalTo(backIMV.snp.centerY).offset(20)
      make.width.equalTo(60.ratioWidth)
      make.height.equalTo(60.ratioHeight)
    }
    let tap = UITapGestureRecognizer(target: self, action: #selector(headerIMVClick))
    headerIMV.addGestureRecognizer(tap)
    
    addSubview(nameLB)
    nameLB.decorateStyleOfLB(title: "德德麦", textColor: .white, textFont: 14.ratioHeight)
    nameLB.snp.makeConstraints { (make) in
      make.left.equalTo(headerIMV.snp.right).offset(10)
      make.centerY.equalTo(headerIMV.snp.centerY).offset(-20)
    }
    
    
    addSubview(idTitleLB)
    idTitleLB.decorateStyleOfLB(title: "ID:1312313241", textColor: .white, textFont: 12.ratioHeight, textAlignment: .center, backGroundColor: .userBackLB)
    idTitleLB.layer.borderWidth = 1.0
    idTitleLB.layer.borderColor = UIColor.white.cgColor
    idTitleLB.layer.cornerRadius = 10
    idTitleLB.layer.masksToBounds = true
    idTitleLB.snp.makeConstraints { (make) in
      make.left.equalTo(headerIMV.snp.right).offset(10)
      make.centerY.equalTo(headerIMV.snp.centerY).offset(20)
      make.width.equalTo(100.ratioWidth)
      make.height.equalTo(20.ratioHeight)
    }
    
  }
  
  @objc func headerIMVClick() {
    if headerClick != nil {
      headerClick!()
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}


class UserVCCell: UITableViewCell,ProtocolCustomCellDirectStyle {
  var iconIV: UIImageView! = UIImageView()
  var titleLB:UILabel! = UILabel()
  
  convenience init(imageName: String, title: String,isSelect: Bool) {
    self.init(style:.default,reuseIdentifier: nil)
    addShowViews(imageName: imageName, title: title, textColor:  .text, textFont: 12.ratioHeight, isSelect: isSelect)
  }
  
}

class RoundLabeView: UIView {
  
  convenience init(idLB:UILabel){
    self.init(frame: .zero)
    let roundView = RoundCornerLineView(borderColor: .white, lineWidth: 1, radian: 5, frame: .zero)
    addSubview(roundView)
    roundView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    roundView.addSubview(idLB)
    idLB.snp.makeConstraints { (make) in
      make.center.equalTo(roundView)
    }
  }
}
