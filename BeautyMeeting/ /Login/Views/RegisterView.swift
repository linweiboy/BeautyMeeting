//
//  RegisterView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/25.
//  Copyright © 2016年 rongteng. All rights reserved.
//

class HaveInvestPeopleBT:UIView {
  
  var showInviteInputBTClickClosure:(()->())!
  
  fileprivate var showInviteInputBT:UIButton! //我有邀请码
  
  convenience init(inviteInputBT:UIButton) {
    self.init(frame:CGRect.zero)
    self.backgroundColor = UIColor.clear
    showInviteInputBT = inviteInputBT
    addSubview(inviteInputBT)
    inviteInputBT.setImage(UIImage(named: "addSymbol"), for: UIControlState())
    inviteInputBT.setImage(UIImage(named: "decreaseSymbol"), for: .selected)
    inviteInputBT.addTarget(self, action: #selector(showInviteInputTF), for: .touchUpInside)
    inviteInputBT.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(0)
      make.width.equalTo(12)
    }
    
    let textBT = UIButton(type: .custom)
    addSubview(textBT)
    textBT.decorateStyleOfBT(title:"我有邀请人", textColor:   .prittyBlue, textFont: FontDefine.twelve, imageName: "")
    textBT.addTarget(self, action: #selector(showInviteInputTF), for: .touchUpInside)
    textBT.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(showInviteInputBT.snp.right)
      make.right.equalTo(self)
    }
  }
  
  @objc func showInviteInputTF() {
    if !showInviteInputBT.isUserInteractionEnabled {
      return
    }
    showInviteInputBT.isSelected = !showInviteInputBT.isSelected
    showInviteInputBTClickClosure()
  }
  
  
  
  
  
  
}
