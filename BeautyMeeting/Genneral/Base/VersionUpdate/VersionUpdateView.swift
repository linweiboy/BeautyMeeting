//
//  VersionUpdateView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/9/22.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import SnapKit

class VersionUpdateView:UIView,ProtocolMaskShowView {
  
  var btClickClosure:(() -> ())?
  let noteTextView = UITextView()
  var maskAnimationView:UIView! = UIView()
  
  ///版本更新
  convenience init(model:VersionUpdateModel) {
    let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 243, height: 140))
    self.init(frame: frame)
    let image = UIImage(named: "focusWeChatBack")
    let backImageV = UIImageView(image:image)
    addSubview(backImageV)
    backImageV.snp.makeConstraints { (make) in
      make.center.equalTo(self)
      make.width.equalTo((image?.width)!)
      make.height.equalTo((image?.height)!)
    }
    
    let leftOffset:CGFloat = 24
    let rightOffset:CGFloat = 22
    
    //更新内容
    noteTextView.isEditable = false
    addSubview(noteTextView)
    noteTextView.text = model.description
    noteTextView.snp.makeConstraints { (make) in
      make.top.equalTo(backImageV).offset(16)
      make.bottom.equalTo(-50)
      make.left.equalTo(leftOffset)
      make.right.equalTo(-rightOffset)
    }
    
    let gotoPayBT = RoundCornerBT(type: .custom)
    addSubview(gotoPayBT)
    gotoPayBT.decorateStyleOfBT(title:"更新", textColor: UIColor.white, textFont: 15,backGroundColor: .prittyBlue)
    gotoPayBT.tag = 11
    gotoPayBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    gotoPayBT.snp.makeConstraints { (make) in
      make.height.equalTo(30)
      make.left.equalTo(leftOffset+5)
      make.right.equalTo(-rightOffset-5)
      make.bottom.equalTo(-15)
    }
    
    if model.status == UpdateIndicate.maybe.rawValue {
      gotoPayBT.snp.remakeConstraints({ (make) in
        make.top.equalTo(noteTextView.snp.bottom).offset(10)
        make.right.equalTo(-rightOffset-5)
        make.bottom.equalTo(-10)
      })
      let cancelBT = RoundCornerBT(type: .custom)
      addSubview(cancelBT)
      cancelBT.decorateStyleOfBT(title:"取消", textColor: UIColor.white, textFont: 15,backGroundColor: UIColor.rgbValue(sameValue: 163))
      cancelBT.tag = 10
      cancelBT.addTarget(self, action: #selector(cancelBTClick), for: .touchUpInside)
      cancelBT.snp.makeConstraints { (make) in
        make.top.equalTo(gotoPayBT)
        make.left.equalTo(leftOffset+5)
        make.right.equalTo(gotoPayBT.snp.left).offset(-10)
        make.bottom.equalTo(gotoPayBT)
        make.width.equalTo(gotoPayBT)
      }
    }
    
  }
  
  @objc func cancelBTClick() {
    dismissView(nil)
  }
  
  @objc func btClick(_ bt:UIButton) {
    if btClickClosure != nil {
      btClickClosure!()
    }
  }
  
  
  
  
  
}







