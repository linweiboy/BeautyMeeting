//
//  UIViewProtocol.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/5/19.
//  Copyright © 2017年 rongteng. All rights reserved.
//


//MARK: 页面无数据时 添加无数据view
//protocol TableViewNoDateAddViewProtocol {
//  func addNoDataView(title:String,btTitle:String?,btClick:(()->())?)
//  func removeNoDataView()
//}
//
//extension TableViewNoDateAddViewProtocol where Self:UIView {
//  
//  func addNoDataView(title:String,btTitle:String?,btClick:(()->())?) {
//    removeNoDataView()
//    let noView = NoDataView(tipTitle:title,btTitle:btTitle)
//    addSubview(noView)
//    noView.clickClo = { btClick?() }
//    noView.backgroundColor = self.backgroundColor
//    noView.snp.makeConstraints { (make) in
//      make.edges.equalTo(self)
//      make.width.equalTo(self)
//      make.height.equalTo(self)
//    }
//  }
//  
//  func removeNoDataView() {
//    let views = self.subviews
//    views.forEach { (subV) in
//      if subV is NoDataView { subV.removeFromSuperview() }
//    }
//  }
//}
//
//
////活期详情head
//protocol ShowAccountInfoProtocol {
//  var topLB:UILabel {get set} // 上
//  var bottomLeft:UILabel {get set} //下左
//  var bottomRight:UILabel {get set} //下右
//  func addShowView(titleArr:[String])
//}
//
//extension ShowAccountInfoProtocol where Self:UIView {
//  
//  func addShowView(titleArr:[String]) {
//    guard titleArr.count == 3 else { return }
//    
//    addSubview(topLB)
//    topLB.decorateStyleOfLB(title: "", textColor: .white, textFont: 26.ratioHeight,textAlignment:.center)
//    topLB.snp.makeConstraints { (make) in
//      make.centerX.equalTo(self)
//      make.top.equalTo(25)
//    }
//    
//    let topLBTitleLB = UILabel()
//    addSubview(topLBTitleLB)
//    topLBTitleLB.decorateStyleOfLB(title: "", textColor: .white, textFont: 13.ratioHeight,textAlignment:.center)
//    topLBTitleLB.text = titleArr[0]
//    topLBTitleLB.snp.makeConstraints { (make) in
//      make.top.equalTo(topLB.snp.bottom).offset(15)
//      make.centerX.equalTo(topLB)
//    }
//    
//    let bottomLeftTitleLB = UILabel()
//    addSubview(bottomLeftTitleLB)
//    bottomLeftTitleLB.decorateStyleOfLB(title: "", textColor: .white, textFont: 13.ratioHeight,textAlignment:.center)
//    bottomLeftTitleLB.text = titleArr[1]
//    bottomLeftTitleLB.snp.makeConstraints { (make) in
//      make.bottom.equalTo(-24)
//      make.centerX.equalTo(ScreenWidth/4)
//    }
//    
//    addSubview(bottomLeft)
//    bottomLeft.decorateStyleOfLB(title: "", textColor: .white, textFont: 13.ratioHeight, textAlignment: .center)
//    bottomLeft.snp.makeConstraints { (make) in
//      make.bottom.equalTo(bottomLeftTitleLB.snp.top).offset(-7)
//      make.centerX.equalTo(bottomLeftTitleLB)
//    }
//    
//    let lineView = UIView()
//    addSubview(lineView)
//    lineView.backgroundColor = .white
//    lineView.snp.makeConstraints { (make) in
//      make.width.equalTo(1)
//      make.top.equalTo(bottomLeft.snp.top).offset(-3)
//      make.bottom.equalTo(bottomLeftTitleLB.snp.bottom).offset(3)
//      make.centerX.equalTo(self)
//    }
//    
//    let bottomRightTitleLB = UILabel()
//    addSubview(bottomRightTitleLB)
//    bottomRightTitleLB.sameStyle(use: bottomLeftTitleLB)
//    bottomRightTitleLB.text = titleArr[2]
//    bottomRightTitleLB.snp.makeConstraints { (make) in
//      make.bottom.equalTo(bottomLeftTitleLB)
//      make.centerX.equalTo(ScreenWidth*3/4)
//    }
//    
//    addSubview(bottomRight)
//    bottomRight.sameStyle(use: bottomLeft)
//    bottomRight.snp.makeConstraints { (make) in
//      make.top.equalTo(bottomLeft)
//      make.centerX.equalTo(bottomRightTitleLB)
//    }
//    
//  }
//  
//  
//}
//
//
////MARK:-操作失败或等待中
//protocol OperateFailOrWaitProtocol {
//  func addShowViews(failReason:String,noteImage:String)
//}
//
//extension OperateFailOrWaitProtocol where Self:UIView {
//  
//  func addShowViews(failReason:String,noteImage:String) {
//    self.backgroundColor =   .separateLine
//    
//    let topView = OperateSuccessTopView()
//    addSubview(topView)
//    topView.backgroundColor = .white
//    topView.snp.makeConstraints { (make) in
//      make.left.right.equalTo(self)
//      make.top.equalTo(0)
//      make.height.equalTo(100.ratioHeight)
//    }
//    
//    let tipLogoIM = UIImage(named:noteImage)!
//    let tipLogoIV = UIImageView(image: tipLogoIM)
//    topView.addSubview(tipLogoIV)
//    tipLogoIV.snp.makeConstraints { (make) in
//      make.center.equalTo(topView)
//      make.width.equalTo(tipLogoIM.ratioWidth)
//      make.height.equalTo(tipLogoIM.ratioHeight)
//    }
//    
//    let reasonLB = UILabel()
//    addSubview(reasonLB)
//    reasonLB.decorateStyleOfLB(title:failReason, textColor:  .text, textFont: 15.ratioHeight, textAlignment: .center, backGroundColor: .white)
//    reasonLB.snp.makeConstraints { (make) in
//      make.top.equalTo(topView.snp.bottom)
//      make.left.right.equalTo(self)
//      make.height.equalTo(40)
//    }
//  }
//}
//
//
//
//
//
//
//
////预留
//protocol ProtocolCustomSegmentedSelect {
//  var bottomLineColor:UIColor {get}
//  var bottomLineWidth:CGFloat {get}
//  func addEqualWidthViews(viewArr:[UIView])
//}
//
//extension ProtocolCustomSegmentedSelect where Self:UIView {
//  
//  var bottomLineColor:UIColor {
//    return UIColor.black
//  }
//  
//  var bottomLineWidth:CGFloat {
//    return 1
//  }
//  
//  func addEqualWidthViews(viewArr:[UIView]) {
//    viewArr.forEach { (view) in
//      view.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//  }
//}
//
//
////MARK:头部按钮切换视图
//protocol ProtocolHeadButtonSwitch {
//  
//  //可选属性
//  var headHeight:CGFloat {get}  //视图按钮高度及背景视图高度
//  var selectTitleColor:UIColor {get}
//  var deselectTitleColor:UIColor {get}
//  var backViewColor:UIColor{get}
//  var titleFont:CGFloat {get}
//  
//  //必须由协议遵循者实现的属性
//  var firstBT: UIButton! {get set} //第一个按钮
//  var backView:RoundCornerView! {get set}  //背景视图
//  func drawInRect(_ rect: CGRect)
//  
//}
//
//extension ProtocolHeadButtonSwitch where Self: UIView {
//  
//  var headHeight:CGFloat { return 28.ratioHeight}
//  var selectTitleColor:UIColor { return .white }
//  var deselectTitleColor:UIColor { return .text }
//  var backViewColor:UIColor { return   .prittyBlue }
//  var titleFont:CGFloat { return 15 }
//  
//  func createView(titleStrArray:[String],sel:Selector) {
//    
//    var btnArray:[UIButton] = []
//    for index in 0 ..< titleStrArray.count {
//      if index == 0 {
//        addSubview(firstBT)
//        firstBT.decorateStyleOfBT(title: titleStrArray[0], textColor: deselectTitleColor, textFont: titleFont, backGroundColor: .clear)
//        firstBT.addTarget(self, action: sel, for: .touchUpInside)
//        firstBT.tag = 100
//        firstBT.setTitleColor(selectTitleColor, for: .selected)
//        btnArray.append(firstBT)
//        firstBT.snp.makeConstraints { (make) in
//          make.top.equalTo(0)
//          make.left.equalTo(self)
//          make.height.equalTo(headHeight)
//        }
//      }else{
//        let btn = UIButton(type: .custom)
//        addSubview(btn)
//        btn.decorateStyleOfBT(title: titleStrArray[index], textColor: deselectTitleColor, textFont: titleFont, backGroundColor: .clear)
//        btn.addTarget(self, action: sel, for: .touchUpInside)
//        btn.tag = 100 + index
//        btn.setTitleColor(selectTitleColor, for: .selected)
//        btnArray.append(btn)
//        btn.snp.makeConstraints({ (make) in
//          make.top.equalTo(self)
//          make.height.equalTo(headHeight)
//          if index == 0 {
//            make.left.equalTo(self)
//          }else {
//            let oldBtn = btnArray[index-1]
//            make.width.equalTo(oldBtn)
//            make.left.equalTo(oldBtn.snp.right)
//            
//          }
//          if index == titleStrArray.count - 1 {
//            make.right.equalTo(self)
//          }
//        })
//      }
//    }
//    insertSubview(backView, belowSubview: firstBT)
//    backView.backgroundColor = backViewColor
//    backView.snp.makeConstraints { (make) in
//      make.centerY.equalTo(firstBT)
//      make.centerX.equalTo(firstBT)
//      make.width.equalTo(firstBT)
//      make.height.equalTo(headHeight)
//    }
//  }
//  
//  func drawInRect(_ rect: CGRect) {
//    self.layer.cornerRadius = rect.size.height/2
//    self.layer.masksToBounds = true
//  }
//  
//}
//
//
//
////左右两个button切换view
//protocol ProtocolLeftAndRightSwitchView {
//  var lineView: UIView! {get set} //滑动线
//  func addSwitchView(leftTitle:String,rightTitle:String,sel:Selector);
//}
//
//extension ProtocolLeftAndRightSwitchView where Self:UIView {
//  
// func addSwitchView(leftTitle:String,rightTitle:String,sel:Selector) {
//    
//    let oneBT = UIButton(type: .custom)
//    addSubview(oneBT)
//    oneBT.tag = 10
//    oneBT.decorateStyleOfBT(title: leftTitle, textColor: .tipText, textFont: 13)
//    oneBT.addTarget(self, action: sel, for: .touchUpInside)
//    oneBT.setTitleColor(.main, for: .selected)
//    oneBT.snp.makeConstraints { (make) in
//      make.left.top.equalTo(self)
//      make.bottom.equalTo(-1)
//    }
//    
//    let twoBT = UIButton(type: .custom)
//    addSubview(twoBT)
//    twoBT.tag = 11
//    twoBT.decorateStyleOfBT(title: rightTitle, textColor: .tipText, textFont: 13)
//    twoBT.addTarget(self, action: sel, for: .touchUpInside)
//    twoBT.setTitleColor(.main, for: .selected)
//    twoBT.snp.makeConstraints { (make) in
//      make.right.top.equalTo(self)
//      make.left.equalTo(oneBT.snp.right)
//      make.bottom.equalTo(oneBT)
//      make.width.equalTo(oneBT)
//    }
//    
//    addSubview(lineView)
//    lineView.backgroundColor = .main
//    lineView.snp.makeConstraints { (make) in
//      make.bottom.equalTo(self)
//      make.centerX.equalTo(oneBT)
//      make.width.equalTo(oneBT)
//      make.height.equalTo(1)
//    }
//    
//    oneBT.isSelected = true
//  }
//  
//}
//
//
////提示view 淡黄色背景 黄色文字  提示
//protocol ProtocolPromptView {
//  func addTipView(title:String)
//}
//
//extension ProtocolPromptView  where Self:UIView {
//  
//  func addTipView(title:String) {
//    self.backgroundColor = UIColor.rgbValue(red: 250, green: 222, blue: 191)
//    let headerLB = UILabel()
//    addSubview(headerLB)
//    headerLB.decorateStyleOfLB(title:title, textColor:   .orangeColor, textFont: 12.ratioHeight)
//    headerLB.sizeToFit()
//    headerLB.snp.makeConstraints { (make) in
//      make.left.equalTo(15)
//      make.centerY.equalTo(self)
//    }
//  }
//  
//}
//
//
////MARK:- 充值结果、投资结果、查询结果 topView  白底 一个image+一个提示文字
//
//protocol ProtocolActionResultView {
//  func addShowView(imageN:String,noteTitle:String)
//}
//
//extension ProtocolActionResultView where Self:UIView {
//  
//  func addShowView(imageN:String,noteTitle:String) {
//    self.backgroundColor = UIColor.white
//    self.clipsToBounds = false
//    let noteIM = UIImage(named: imageN)!
//    let noteIV = UIImageView(image: noteIM)
//    addSubview(noteIV)
//    noteIV.snp.makeConstraints { (make) in
//      make.centerX.equalTo(self)
//      make.centerY.equalTo(self).offset(-10)
//      make.width.equalTo(noteIM.width)
//      make.height.equalTo(noteIM.height)
//    }
//    
//    let noteLB = UILabel()
//    addSubview(noteLB)
//    noteLB.decorateStyleOfLB(title: noteTitle, textColor:  .text, textFont:15, textAlignment: .center)
//    noteLB.snp.makeConstraints { (make) in
//      make.top.equalTo(noteIV.snp.bottom).offset(15)
//      make.centerX.equalTo(self)
//    }
//  }
//}
//
//
//
//
//
//
//










