//
//  CountDownView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/7/20.
//  Copyright © 2016年 rongteng. All rights reserved.
//

import UIKit


class CountDownView: UIView {
  
  var countDownStartClosure:(()->())?//传递开始计时的状态
  var countDownCompleteClosure : (()->())?//传递计时结束的状态
  var sendSecondsClosure:(()->())?  //当20秒的时候产生的状态
  
  fileprivate let currentProgressPath = UIBezierPath()
  fileprivate let currentProgressLayer = CAShapeLayer()
  fileprivate let grayLayer = CAShapeLayer()
  fileprivate let progressAnmimation = CABasicAnimation(keyPath: "strokeEnd")
  fileprivate var countLabel = UILabel()//用于中间显示时间倒计时
  
  //存储输入进来的时间
  fileprivate var timeInOut : Int!
  var isCountingDown : Bool?//控制倒计时是否完成
  
  //时间计时器
  fileprivate var timer: DispatchSourceTimer?
  fileprivate var queue: DispatchQueue?
  
  fileprivate override init(frame: CGRect) {
    super.init(frame: frame)
    self.isOpaque = false
  }
  
  // lineWidth:画线的线宽  foilStrokeColor: 衬托色 timeOut 计算的时间
  convenience init(frame:CGRect,lineWidth:CGFloat,progressColor:UIColor,textColor:UIColor,timeDuration:TimeInterval,timeInPut: Int) {
    self.init(frame: frame)
    timeInOut = timeInPut
    let label = UILabel(frame: frame)
    label.textColor = textColor
    label.textAlignment = .center
    label.font = UIFont(name: "Helvetica-Light", size: frame.size.width/2.5)
    self.countLabel = label
    self.addSubview(self.countLabel)
    countLabel.snp.makeConstraints { (make) in
      make.center.equalTo(self.snp.center)
      make.width.equalTo(frame.width)
      make.height.equalTo(frame.height)
    }
    //默认圆
    let radius = (self.frame.size.width-6)/2.0
    let defaultPath = UIBezierPath(arcCenter: CGPoint(x: frame.width/2, y: frame.height/2), radius: radius, startAngle: 0, endAngle:CGFloat(Double.pi)*2.0, clockwise: false)
    
    grayLayer.path = defaultPath.cgPath
    grayLayer.fillColor = UIColor.clear.cgColor
    
    let color = UIColor.rgbValue(red: 240, green: 244, blue: 247)
    grayLayer.strokeColor = color.cgColor
    grayLayer.lineWidth = lineWidth
    grayLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    self.layer.addSublayer(grayLayer)
    grayLayer.isHidden = true
    //currentProgressLayer 当前进度条设置
    currentProgressLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    currentProgressLayer.fillColor = UIColor.clear.cgColor
    currentProgressLayer.strokeColor = progressColor.cgColor
    currentProgressLayer.lineWidth = lineWidth
    self.layer.addSublayer(currentProgressLayer)
    //动画参数设置
    progressAnmimation.duration = timeDuration
    progressAnmimation.fromValue = NSNumber(value: 0 as Int)
    progressAnmimation.toValue = NSNumber(value: timeInPut as Int)
  }
  
  //通过时间比率去展示圆的进度
  fileprivate func showAnimationPregress(_ percent:CGFloat) {
    if percent > 1 || percent < 0 {
      return
    }
    currentProgressPath.removeAllPoints()
    currentProgressLayer.removeAllAnimations()
    currentProgressLayer.path = nil
    let radius = (self.frame.size.width-6)/2.0
    currentProgressPath.addArc(withCenter: CGPoint(x: self.frame.width/2, y: self.frame.height/2), radius: radius, startAngle: CGFloat(Double.pi+Double.pi/2)-CGFloat(Double.pi)*2.0*percent, endAngle: CGFloat(Double.pi+Double.pi/2) ,clockwise: true)
    currentProgressLayer.path = currentProgressPath.cgPath
  }
  
  //时间倒计时开始
  fileprivate func startTime() {
    if timeInOut>0 {
      var timeOut = timeInOut!
      queue = DispatchQueue.global()
      timer = DispatchSource.makeTimerSource(queue: queue)
      timer!.schedule(wallDeadline: .now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
      timer!.setEventHandler(handler: {
        if timeOut <= 0 {
          self.timer!.cancel()
          //主线程更新UI
          DispatchQueue.main.async(execute: {
            self.isCountingDown = false
            self.isHidden = true
            self.stopCountDown()
          })
        }else {
          self.isCountingDown = true
          let seconds = (timeOut % self.timeInOut) <= 0 ? self.timeInOut:timeOut%self.timeInOut
          let prece = CGFloat((timeOut % self.timeInOut) <= 0 ? self.timeInOut:timeOut%self.timeInOut)/CGFloat(self.timeInOut)
          DispatchQueue.main.async(execute: {
            if seconds == self.timeInOut {
              self.countLabel.isHidden = false
              self.countLabel.text = "\(self.timeInOut)"
            }
            self.showAnimationPregress(prece)
            self.countLabel.isHidden = false
            let secondsStr = seconds!
            self.countLabel.text = "\(secondsStr)"
            //20秒发生的状态
            if seconds! <= 20 {
              self.sendStatusClickClosure()
            }
          })
          timeOut = timeOut - 1
        }
      })
      timer!.resume()
      countLabel.text = String(timeOut)
    }
  }
  
  //传递20秒时候的状态传出去
  func sendStatusClickClosure() {
    if sendSecondsClosure != nil {
      sendSecondsClosure!()
    }
  }
  //开始计时
  func startCountDown() {
    self.isHidden = false
    self.grayLayer.isHidden = false
    self.isCountingDown = true
    if countDownStartClosure != nil {
      countDownStartClosure!()
    }
    currentProgressLayer.add(progressAnmimation , forKey: "strokeEnd")
    startTime()
    
  }
  //    停止计时
  func stopCountDown() {
    self.currentProgressLayer.removeAllAnimations()
    self.grayLayer.removeAllAnimations()
    if countDownCompleteClosure != nil {
      countDownCompleteClosure!()
    }
    cancelTimer()
    self.isCountingDown = false
    self.isHidden = true
    
  }
  func cancelTimer() {
    if timer != nil {
      self.timer!.cancel()
    }
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
