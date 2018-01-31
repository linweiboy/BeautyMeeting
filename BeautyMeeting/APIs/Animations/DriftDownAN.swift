//
//  DriftDownAF.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/2/10.
//  Copyright © 2017年 rongteng. All rights reserved.
//

import UIKit

//红包下落动画

class DriftDownAN:NSObject {
  
  ///节日加动画的图片数组
  fileprivate lazy var addImageArray = [UIImageView]()
  fileprivate lazy var removeImageArray = [UIImageView]()
  fileprivate lazy var festivalTimer = Timer()
  
  
  //红包下落动画
  func fallDownAnimation(withImage path: String,targetView:UIView) {
    for i in 0..<50 {
      let imgName = getPocketImageName()
      let imageView = UIImageView(image: UIImage(contentsOfFile: "\(path)/\(imgName)"))
      let imgWidth = arc4random_uniform(20) + 30
      let imgStartX = arc4random_uniform(UInt32(ScreenWidth))
      imageView.frame = CGRect(x: Int(imgStartX), y: -50, width: Int(imgWidth), height: Int(imgWidth))
      targetView.addSubview(imageView)
      imageView.tag = i
      self.addImageArray.append(imageView)
    }
    self.festivalTimer.invalidate()
    self.festivalTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(addFestivalPocket), userInfo: nil, repeats: true)
  }
  
  func getPocketImageName() -> String {
    let boo = arc4random_uniform(2)
    switch boo {
    case 0:return "pocketOne"
    case 1:return "pocketTwo"
    default:return "pocketOne"
    }
  }
  
  @objc func addFestivalPocket() {
    if self.addImageArray.count > 0 {
      let imageView = addImageArray.first
      addImageArray.removeFirst()
      removeImageArray.append(imageView!)
      startAnimation(aImageView: imageView!)
    }
  }
  
  func startAnimation(aImageView: UIImageView) {
    UIView.beginAnimations(nil, context: nil)
    UIView.setAnimationDuration(7)
    UIView.setAnimationDelegate(self)
    aImageView.frame = CGRect(x: aImageView.frame.origin.x, y: ScreenHeight, width: aImageView.frame.size.width, height: aImageView.frame.size.height)
    UIView.setAnimationDidStop(#selector(endAnimation))
    UIView.commitAnimations()
  }
  
  @objc func endAnimation() {
    if let imageView = removeImageArray.first  {
      removeImageArray.removeFirst()
      imageView.removeFromSuperview()
      if removeImageArray.count == 0 && imageView.tag == 49 {
//        HomeVC.isRepeats = false
        self.festivalTimer.invalidate()
      }
    }
  }
  
}
