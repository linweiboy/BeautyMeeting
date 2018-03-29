//
//  NotReceiveVerifyNumView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/28.
//  Copyright © 2016年 rongteng. All rights reserved.
//


//无法收到验证码 提示

class NotReceiveVerifyNumView: UIView,ProtocolMaskShowView {
  
  var btClickClosure:(() -> ())?
  
  //ProtocolMaskShowView
  var maskAnimationView:UIView! = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let image = UIImage(named: "focusWeChatBack")
    let inset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    let image1 = image?.resizableImage(withCapInsets: inset, resizingMode: .stretch)
    let backImageV = UIImageView(image:image1)
    addSubview(backImageV)
    backImageV.contentMode = .redraw
    backImageV.snp.makeConstraints { (make) in
      make.center.equalTo(self)
      make.width.equalTo(frame.width)
      make.height.equalTo(frame.height)
    }
    
    
    let leftOffset:CGFloat = 23
    let rightOffset:CGFloat = 23
    let stepViewHeight:CGFloat = 12.ratioHeight
    
    let reasonLB = UILabel()
    addSubview(reasonLB)
    reasonLB.decorateStyleOfLB(title: "收不到短信验证码？可能原因有：", textColor:   .prittyBlue, textFont: 13.ratioHeight, textAlignment: .center)
    reasonLB.snp.makeConstraints { (make) in
      make.left.equalTo(leftOffset)
      make.right.equalTo(-rightOffset)
      make.top.equalTo(18.ratioHeight)
    }
    
    
    
    let step1View = createStepView("step1", title: "输入手机号码不是本机；")
    addSubview(step1View)
    step1View.snp.makeConstraints { (make) in
      make.left.equalTo(leftOffset+5)
      make.right.equalTo(-rightOffset)
      make.top.equalTo(reasonLB.snp.bottom).offset(20.ratioHeight)
      make.height.equalTo(stepViewHeight)
    }
    let step2View = createStepView("step2", title: "手机处于停机欠费状态；")
    addSubview(step2View)
    step2View.snp.makeConstraints { (make) in
      make.left.equalTo(leftOffset+5)
      make.right.equalTo(-rightOffset)
      make.top.equalTo(step1View.snp.bottom).offset(15.ratioHeight)
      make.height.equalTo(stepViewHeight)
    }
    
    let step3View = createStepView("step3", title: "短信通道拥堵，请稍后再试；")
    addSubview(step3View)
    step3View.snp.makeConstraints { (make) in
      make.left.equalTo(leftOffset+5)
      make.right.equalTo(-rightOffset)
      make.top.equalTo(step2View.snp.bottom).offset(15.ratioHeight)
      make.height.equalTo(stepViewHeight)
    }
    
    let step4View = createStepView("step4", title: "手机安全软件拦截，请暂时关闭拦截功能。")
    addSubview(step4View)
    step4View.snp.makeConstraints { (make) in
      make.left.equalTo(leftOffset+5)
      make.right.equalTo(-rightOffset)
      make.top.equalTo(step3View.snp.bottom).offset(15.ratioHeight)
      make.height.equalTo(stepViewHeight)
    }
    
    let callPhoneNoteLB = UILabel()
    addSubview(callPhoneNoteLB)
    callPhoneNoteLB.decorateStyleOfLB(title: "如仍无法收到验证码，请点击拨打", textColor: UIColor.rgbValue(red: 202, green: 103, blue: 4), textFont: 11.ratioHeight, textAlignment: .center)
    callPhoneNoteLB.snp.makeConstraints { (make) in
      make.top.equalTo(step4View.snp.bottom).offset(10.ratioHeight)
      make.left.right.equalTo(backImageV)
    }
    
    let callPhoneNoteBT = UIButton(type: .custom)
    addSubview(callPhoneNoteBT)
    callPhoneNoteBT.decorateStyleOfBT(title:CustomerService, textColor:   .prittyBlue, textFont: 15.ratioHeight,backGroundColor: UIColor.clear)
    callPhoneNoteBT.tag = 10
    callPhoneNoteBT.addTarget(self, action: #selector(btClick), for: .touchUpInside)
    callPhoneNoteBT.setImage(UIImage(named: "callPhone"), for: UIControlState())
    callPhoneNoteBT.snp.makeConstraints { (make) in
      make.top.equalTo(callPhoneNoteLB.snp.bottom).offset(5.ratioHeight)
      make.left.equalTo(leftOffset)
      make.right.equalTo(-rightOffset)
      make.height.equalTo(30.ratioHeight)
    }
    
    let knowBT = UIButton(type: .custom)
    addSubview(knowBT)
    knowBT.tag = 11
    knowBT.addTarget(self, action: #selector(knowBTClick), for: .touchUpInside)
    knowBT.decorateStyleOfBT(title:"知道了", textColor: UIColor.white, textFont: 15.ratioHeight, backGroundColor:   .prittyBlue)
    knowBT.snp.makeConstraints { (make) in
      make.bottom.equalTo(backImageV.snp.bottom).offset(-5)
      make.height.equalTo(CGDefine.height.maxButton)
      make.left.equalTo(leftOffset)
      make.right.equalTo(-rightOffset)
    }
    
  }
  
  
  @objc func knowBTClick() {
    dismissView(nil)
  }
  
  
  @objc func btClick(_ bt:UIButton) {
    dismissView(nil)
    if btClickClosure != nil {
      btClickClosure!()
    }
  }
  
  
  fileprivate func createStepView(_ imageName:String,title:String) -> UIView {
    
    let view = UIView()
    view.backgroundColor = UIColor.clear
    
    let image = UIImage(named: imageName)
    let imageV = UIImageView(image:image)
    view.addSubview(imageV)
    let width = (image != nil) ? image!.ratioWidth:10
    imageV.snp.makeConstraints { (make) in
      make.width.height.equalTo(width)
      make.left.centerY.equalTo(view)
    }
    
    let noteLB = UILabel()
    view.addSubview(noteLB)
    noteLB.decorateStyleOfLB(title: title, textColor: UIColor.rgbValue(sameValue: 76), textFont: 11.ratioHeight)
    noteLB.snp.makeConstraints { (make) in
      make.left.equalTo(imageV.snp.right).offset(3)
      make.centerY.equalTo(view)
      make.right.equalTo(view)
    }
    return view
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}








