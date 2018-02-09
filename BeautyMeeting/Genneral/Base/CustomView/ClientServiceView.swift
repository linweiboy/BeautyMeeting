//
//  ClientServiceView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/2.
//  Copyright © 2016年 rongteng. All rights reserved.
//

//客户服务view

class ClientServiceView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let callBT = RoundCornerBT(type: .custom)
    addSubview(callBT)
    callBT.decorateStyleOfBT(title:"客服热线：\(CustomerService)", textColor: UIColor.white, textFont: FontDefine.fourteen, imageName: "detail_callPhone")
    callBT.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    callBT.backgroundColor =   .prittyBlue
    callBT.addTarget(self, action: #selector(callBTClick), for: .touchUpInside)
    callBT.snp.makeConstraints { (make) in
      make.top.equalTo(0)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(CGDefine.height.maxButton)
    }
    
    let noteLB = UILabel()
    addSubview(noteLB)
    noteLB.decorateStyleOfLB(title: "（工作日：9:00-17:30）", textColor: UIColor.rgbValue(red: 94, green: 96, blue: 97), textFont: 12.ratioHeight, textAlignment: .center)
    noteLB.snp.makeConstraints { (make) in
      make.left.right.equalTo(callBT)
      make.top.equalTo(callBT.snp.bottom).offset(10)
      make.bottom.equalTo(0)
    }
  }
  
  @objc func callBTClick() {
    AccessSystem.callTelephony(CustomerService)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
