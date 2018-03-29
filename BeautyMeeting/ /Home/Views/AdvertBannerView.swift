//
//  AdvertBannerView.swift
//  RongTeng
//
//  Created by rongteng on 16/4/1.
//  Copyright © 2016年 Mike. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AdvertBannerView: UIView {
  
  var passCurrentIndexClosure:((_ currentIndex:Int) -> (Void))?
  
  //动画间隔  多久执行一次动画 外部可设置 默认5秒
  fileprivate var scrollIntervalTime: Double = 5
  //动画效果的时间 默认1秒
  fileprivate var animationDurationTime: Double = 1.0
  
  fileprivate let mainBackScrollView = UIScrollView()
  fileprivate var urlStringArray: [String] = []
  fileprivate var currentImageIndex: Int = 1 {
    willSet {
      self.imagePageControl.currentPage = newValue-1
    }
  }
  
  fileprivate let imagePageControl = UIPageControl()
  fileprivate var scrollTimer: Timer?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(mainBackScrollView)
    mainBackScrollView.isPagingEnabled = true
    mainBackScrollView.delegate = self;
    mainBackScrollView.showsHorizontalScrollIndicator = false
    mainBackScrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.addSubview(imagePageControl)
    imagePageControl.snp.makeConstraints { (make) in
      make.centerX.equalTo(self)
      make.width.equalTo(100)
      make.bottom.equalTo(-5)
      make.height.equalTo(20)
    }
    
  }
  
  @objc internal func passCurrentIndex() {
    if passCurrentIndexClosure != nil {
      passCurrentIndexClosure!(currentImageIndex-1)
    }
  }
  
  func startScrollWithImageList(_ imageUrlArray: [String]) {
    
    guard imageUrlArray.count != 0 else {return}
    urlStringArray.removeAll()
    urlStringArray += imageUrlArray
    
    let viewWidth = self.frame.width
    let viewHeight = self.frame.height
    
    //第一个是最后一个
    let lastUrl = urlStringArray.last
    let firstUrl = urlStringArray.first
    
    urlStringArray.insert(lastUrl!, at: 0)
    urlStringArray.append(firstUrl!)
    
    //正常顺序的imageView
    for i in 0 ..< urlStringArray.count {
      let currentXOffset = CGFloat(i) * viewWidth
      let imageUrl = urlStringArray[i]
      let imageV = self.createBannerImageView(imageUrl)
      imageV.frame = CGRect(x: currentXOffset, y: 0, width: viewWidth, height: viewHeight)
      mainBackScrollView.addSubview(imageV)
    }
    
    imagePageControl.numberOfPages = urlStringArray.count-2
    mainBackScrollView.contentSize = CGSize(width:viewWidth*CGFloat(urlStringArray.count+2), height:viewHeight)
    mainBackScrollView.contentOffset =  CGPoint(x:CGFloat(currentImageIndex)*viewWidth, y:0)
    
    if self.scrollTimer == nil {
      self.scrollTimer = Timer.scheduledTimer(timeInterval: scrollIntervalTime, target: self, selector: #selector(automaticMove), userInfo: nil, repeats: true)
    }
    
  }
  
  //timer自动执行
  @objc func automaticMove() {
    let viewWidth = self.frame.width
    currentImageIndex = currentImageIndex + 1
    UIView.animate(withDuration: animationDurationTime, animations: {
      let offX = CGFloat(self.currentImageIndex)*viewWidth
      self.mainBackScrollView.contentOffset = CGPoint(x:offX,y:0)
    }, completion: { (isCompletion) in
      //移动到最后一个了
      if self.currentImageIndex == self.urlStringArray.count-1  {
        self.currentImageIndex = 1
        let offX = CGFloat(self.currentImageIndex)*viewWidth
        self.mainBackScrollView.contentOffset = CGPoint(x:offX, y: 0)
      }
    })
    
  }
  
  func createBannerImageView(_ urlStr:String) -> UIImageView {
    let imageV = UIImageView()
    imageV.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(passCurrentIndex))
    imageV.addGestureRecognizer(tap)
    imageV.kf.setImage(with: URL(string:urlStr) , placeholder: UIImage(named: "home-defaultBanner"))
    return imageV
  }
  
  deinit {
    self.scrollTimer?.invalidate()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


//MARK: - UIScrollViewDelegate
extension AdvertBannerView: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let viewWidth = self.frame.width
    let currentOffIndex = Int(scrollView.contentOffset.x / viewWidth)
    
    //移动到第一个了
    if currentOffIndex == 0 {
      currentImageIndex = self.urlStringArray.count - 2
      let offX = CGFloat(self.currentImageIndex)*viewWidth
      self.mainBackScrollView.contentOffset = CGPoint(x:offX,y:0)
      return
    }
    
    //移动到最后一个了
    if currentOffIndex == self.urlStringArray.count - 1  {
      currentImageIndex = 1
      let offX = CGFloat(self.currentImageIndex)*viewWidth
      self.mainBackScrollView.contentOffset = CGPoint(x:offX,y:0)
      return
    }
    
    //正常情况移动
    currentImageIndex = currentOffIndex
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    guard let subTimer = self.scrollTimer else {return}
    if subTimer.isValid {
      subTimer.fireDate = Date(timeIntervalSinceNow: scrollIntervalTime-animationDurationTime)
    }
  }
}

enum Direction {
  case DirectionLeft    //向左滑
  case DirectionRight   //向右滑
  case DirectionNone    //未滑动
}

class TopBannerView: UIView,UIScrollViewDelegate {
  
  var tapClickClosure:((_ index:Int)->())?
  var enableAutoScroll:Bool = true {                      //自动滚动
    didSet{
      if enableAutoScroll{self.startTimer()}
    }
  }
  
  fileprivate let autoScrollTimeInterval:Double = 5      //自动滚动时间间隔
  fileprivate let scrollView = UIScrollView()               //滚动视图
  fileprivate var imgWidth: CGFloat?                    //图片宽度
  fileprivate var imgHeight: CGFloat?                    //图片高度
  fileprivate var pageControl = UIPageControl()             //分页控制器
  fileprivate var currentView = UIImageView()                //当前视图
  fileprivate var nextView = UIImageView()                //下一视图
  fileprivate var currentIndex = 0                   //当前索引
  fileprivate var nextIndex = 0                  //下一索引
  fileprivate var timer: Timer?                      //定时器
  fileprivate var urlStringArray: [String] = []
  fileprivate var direction : Direction = .DirectionNone { //滚动方向
    //设置新值之前
    willSet {
      if newValue == direction {return}
    }
    //设置新值之后
    didSet{
      //向右滚动
      if direction == .DirectionRight{
        nextView.frame = CGRect(x: 0, y: 0, width: imgWidth!, height: imgHeight!)
        nextIndex = currentIndex-1
        if nextIndex < 0 {
          nextIndex = (urlStringArray.count) - 1
        }
      }
      //向左滚动
      if direction == .DirectionLeft {
        nextView.frame = CGRect(x: 2*imgWidth!, y: 0, width: imgWidth!, height: imgHeight!)
        nextIndex = (currentIndex+1) % (urlStringArray.count)
      }
      guard urlStringArray.count != 0 else {return}
      nextView.kf.setImage(with: URL(string:urlStringArray[nextIndex]) , placeholder: UIImage(named: "home-defaultBanner"))
    }
  }
  
  override init(frame: CGRect){
    let frameH =  CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 150.ratioHeight)
    super.init(frame: frameH)
    
    imgWidth  = frameH.size.width
    imgHeight = frameH.size.height
    
    addSubview(scrollView)
    scrollView.delegate = self
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.contentSize = CGSize(width: 3*imgWidth!, height: imgHeight!)
    scrollView.contentOffset = CGPoint(x: imgWidth!, y: 0)
    scrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    pageControl = UIPageControl(frame: CGRect(x: 0, y: imgHeight!-20, width: imgWidth!, height: 20))
    pageControl.hidesForSinglePage = true
    pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
    pageControl.currentPageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.2)
    self.addSubview(pageControl)
    
  }
  
  @objc func passCurrentIndex() {
    if tapClickClosure != nil {
      tapClickClosure!(currentIndex)
    }
  }
  
  func startScrollWithImageList(_ imageUrlArray: [String]) {
    
    guard imageUrlArray.count != 0 else {return}
    urlStringArray.removeAll()
    urlStringArray += imageUrlArray
    
    currentView = createBannerImageView()
    currentView.frame = CGRect(x: imgWidth!, y: 0, width: imgWidth!, height: imgHeight!)
    scrollView.addSubview(currentView)
    
    nextView = createBannerImageView()
    nextView.frame = CGRect(x: 2*imgWidth!, y: 0, width: imgWidth!, height: imgHeight!)
    scrollView.addSubview(nextView)
    
    currentView.kf.setImage(with: URL(string:urlStringArray[0]) , placeholder: UIImage(named: "home-defaultBanner"))
    pageControl.currentPage = currentIndex
    pageControl.numberOfPages = (urlStringArray.count)
    
    startTimer()
    
  }
  
  /// 开启定时器
  func startTimer() {
    self.stopTimer()
    if urlStringArray.count > 1 {
      timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval, target: self, selector: #selector(self.nextImage), userInfo: nil, repeats: true)
    } else {
      return
    }
  }
  
  /// 关闭定时器
  func stopTimer(){
    if timer != nil && (timer?.isValid)! {
      timer?.invalidate()
      timer = nil
    }
  }
  
  /// 滚动到下一张图片
  @objc func nextImage() {
    scrollView.setContentOffset(CGPoint(x: imgWidth!*2, y: 0), animated: true)
    
  }
  
  
  
  
  //MARK: -----UIScrollViewDelegate-----
  func scrollViewDidScroll(_ scrollView: UIScrollView){
    let offsetX = scrollView.contentOffset.x;
    self.direction = offsetX > imgWidth! ? .DirectionLeft : offsetX < imgWidth! ? .DirectionRight : .DirectionNone
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
    self.pauseScroll()
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
    self.pauseScroll()
  }
  
  //开始拖拽时停止定时器
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
    self.stopTimer()
  }
  
  //拖拽结束后开启定时器
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
    self.startTimer()
  }
  
  ///停止滚动
  func pauseScroll() {
    let offset = self.scrollView.contentOffset.x;
    let index = offset / self.imgWidth!
    //1表示没有滚动
    if index == 1 { return }
    self.currentIndex = self.nextIndex
    self.pageControl.currentPage = self.currentIndex
    self.currentView.frame = CGRect(x: self.imgWidth!, y: 0, width: self.imgWidth!, height: self.imgHeight!)
    self.currentView.image = self.nextView.image
    self.scrollView.contentOffset = CGPoint(x: imgWidth!, y: 0)
  }
  
  func createBannerImageView () -> UIImageView {
    let imageV = UIImageView()
    imageV.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer.init(target: self, action: #selector(passCurrentIndex))
    imageV.addGestureRecognizer(tap)
    return imageV
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    timer?.invalidate()
  }
}

