//
//  HomeNoticeView.swift
//  RongTeng
//
//  Created by rongteng on 16/4/10.
//  Copyright © 2016年 Mike. All rights reserved.
//

import UIKit

class HomeNoticeView: UIView {
  
  var moreNoticeClick:(()->())!
  var passCurrentIndexClosure:((_ currentIndex:Int) -> Void)?
  
  var scrollIntervalTime:Double = 5 //动画间隔  多久执行一次动画 外部可设置 默认5秒
  var animationDurationTime:Double = 1.0 //动画效果的时间 默认1秒
  
  fileprivate let mainBackScrollView = UIScrollView()
  fileprivate lazy var noticeStringArray: [String] = []
  fileprivate var currentImageIndex = 1 //因为是0的时候 显示的是最后一张
  fileprivate var scrollTimer:Timer?
  
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.backgroundColor = .white
    //小喇叭
    let bellIV = UIImageView(image: UIImage(named: "Trumpet"))
    self.addSubview(bellIV)
    bellIV.snp.makeConstraints { (make) in
      make.left.equalTo(self).offset(24)
      make.centerY.equalTo(self)
      make.width.equalTo(17)
      make.height.equalTo(15)
    }
    
    self.addSubview(mainBackScrollView)
    mainBackScrollView.isPagingEnabled = true
    mainBackScrollView.showsHorizontalScrollIndicator = false
    mainBackScrollView.showsVerticalScrollIndicator = false
    mainBackScrollView.snp.makeConstraints { (make) in
      //15+39+10
      make.top.bottom.equalTo(0)
      make.left.equalTo(45)
      make.right.equalTo(-64.ratioWidth)
    }
    
    let moreDetailBT = UIButton(type: .custom)
    addSubview(moreDetailBT)
    moreDetailBT.addTarget(self, action: #selector(moreDetailBTClick), for: .touchUpInside)
    moreDetailBT.decorateStyleOfBT(title: "更多", textColor: .tipText, textFont: 11.ratioHeight)
    moreDetailBT.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
    moreDetailBT.snp.makeConstraints { (make) in
      make.centerY.equalTo(self)
      make.right.equalTo(-15)
      make.height.equalTo(16.ratioHeight)
      make.width.equalTo(40.ratioWidth)
    }
    
  }
  
  internal func startScrollWithTitleArray(_ noticeTitleArray: [String]) {
    
    guard noticeTitleArray.count != 0  else { return }
    
    mainBackScrollView.removeAllSubViews()
    noticeStringArray.removeAll()
    noticeStringArray.append(contentsOf: noticeTitleArray)
    let viewWidth = mainBackScrollView.frame.width
    let viewHeight = mainBackScrollView.frame.height
    
    if noticeTitleArray.count == 1 {
      mainBackScrollView.contentSize = CGSize(width: viewWidth, height: viewHeight)
      let finallyTitle = noticeStringArray.last
      let finallyLB = self.createNoticeLB(finallyTitle!)
      finallyLB.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
      mainBackScrollView.addSubview(finallyLB)
      return
    }
    
    currentImageIndex = 1
    mainBackScrollView.contentSize = CGSize(width: viewWidth, height: viewHeight*CGFloat(noticeStringArray.count+1))
    
    
    //第一个title 放置最后一个对象
    let finallyTitle = noticeStringArray.last
    let finallyLB = self.createNoticeLB(finallyTitle!)
    finallyLB.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
    mainBackScrollView.addSubview(finallyLB);
    
    //正常顺序的imageView
    for i in 0 ..< noticeStringArray.count {
      let currentYOffset = CGFloat(i+1) * viewHeight
      let noticeTitle = noticeStringArray[i]
      let titleLB = self.createNoticeLB(noticeTitle)
      titleLB.frame = CGRect(x: 0, y: currentYOffset, width: viewWidth, height: viewHeight)
      mainBackScrollView.addSubview(titleLB);
    }
    mainBackScrollView.contentOffset =  CGPoint(x: 0, y: CGFloat(currentImageIndex)*viewHeight)
    
    
    if self.scrollTimer == nil {
      self.scrollTimer = Timer.scheduledTimer(timeInterval: scrollIntervalTime, target: self, selector: #selector(automaticMove), userInfo: nil, repeats: true)
    }
    
  }
  
  //timer自动执行
  @objc func automaticMove() {
    
    let viewHeight = mainBackScrollView.frame.height
    currentImageIndex = currentImageIndex + 1
    UIView.animate(withDuration: animationDurationTime, animations: {
      self.mainBackScrollView.contentOffset = CGPoint(x: 0,y: CGFloat(self.currentImageIndex)*viewHeight)
    }, completion: { (isCompletion) in
      //移动到最后一个了
      if self.currentImageIndex == self.noticeStringArray.count  {
        self.currentImageIndex = 0
        self.mainBackScrollView.contentOffset = CGPoint(x: 0,y: 0)
      }
    })
    
  }
  
  func createNoticeLB(_ title:String) -> UILabel {
    let titleLB = UILabel()
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(passCurrentIndex))
    titleLB.addGestureRecognizer(tap)
    titleLB.isUserInteractionEnabled = true
    titleLB.lineBreakMode = NSLineBreakMode.byTruncatingTail
    titleLB.textColor = UIColor.rgbValue(red: 97, green: 118, blue: 135)
    titleLB.font = UIFont.systemFont(ofSize: 11.ratioHeight)
    titleLB.text = title
    return titleLB
    
    
  }
  
  @objc internal func passCurrentIndex() {
    if passCurrentIndexClosure != nil {
      
      var passIndex:Int
      if currentImageIndex == 0 {
        passIndex = self.noticeStringArray.count-1
      } else {
        passIndex = currentImageIndex-1
      }
      passCurrentIndexClosure!(passIndex)
    }
  }
  
  
  @objc func moreDetailBTClick() {
    moreNoticeClick()
  }
  
  
  deinit {
    self.scrollTimer?.invalidate()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
}











