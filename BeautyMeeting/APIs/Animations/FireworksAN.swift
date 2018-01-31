////
////  FireworksAN.swift
////  XiaoZhuGeJinFu
////
////  Created by rongteng on 2017/2/8.
////  Copyright © 2017年 rongteng. All rights reserved.
////
//
////烟花动画
//
//import QuartzCore
//import AVFoundation
//import UIKit
//
//class FireworksAN {
//  
//  class func beginFireworks(targetView:UIView) {
//
//    func decorate(emitterLayer:CAEmitterLayer) {
//      emitterLayer.emitterPosition = CGPoint(x: targetView.frame.width/2, y: targetView.frame.height)
//      emitterLayer.emitterSize = CGSize(width: targetView.frame.width-100, height: 0)
//      emitterLayer.emitterMode = kCAEmitterLayerOutline
//      emitterLayer.emitterShape = kCAEmitterLayerLine
//      emitterLayer.renderMode = kCAEmitterLayerAdditive
//      emitterLayer.seed = (arc4random() % 100) + 1
//    }
//
//    func decorateBehavior(emitterLayer:CAEmitterLayer) {
//
//      let beha = caemi
//
//      let  behavior11 = CAEmitterBehavior(type: kCAEmitterBehaviorAlignToMotion)
//      let  behavior12 = CAEmitterBehavior(type: kCAEmitterBehaviorDrag)
//      emitterLayer.setValue([behavior11,behavior12], forKey: "emitterBehaviors")
//    }
//
//    func decorateCannonball(emitterCell:CAEmitterCell) {
//      emitterCell.birthRate = 0.8
//      emitterCell.lifetime = 1.4
//      emitterCell.velocity = 480
//      emitterCell.velocityRange = 400;
//      emitterCell.contents = UIImage(named:"animation_cannonball")?.cgImage
//      emitterCell.scale = 1.2
//      emitterCell.color = UIColor.rgbValue(red: 255, green: 249, blue: 231).cgColor
//    }
//
//    func decorateBurst(emitterCell:CAEmitterCell) {
//      emitterCell.birthRate = 0.75
//      emitterCell.scale = 2.5
//      emitterCell.lifetime = 0.35
//    }
//
//    func decorateSpark(emitterCell:CAEmitterCell) {
//      emitterCell.birthRate = 400
//      emitterCell.velocity = 125
//      emitterCell.emissionRange = CGFloat(Double.pi)
//      emitterCell.yAcceleration = 70
//      emitterCell.lifetime = 2
//      emitterCell.contents = UIImage(named: "animation_spark")?.cgImage
//      emitterCell.scaleSpeed = -0.2
//      emitterCell.alphaSpeed = -0.5
//      emitterCell.scale = 0.15
//    }
//
//
//    let backLayer = CALayer()
//    backLayer.frame = targetView.frame
//    backLayer.backgroundColor = UIColor.black.cgColor
//    backLayer.opacity = 0.3
//    targetView.layer.addSublayer(backLayer)
//
//    //发射器1
//    let caELayer1 = CAEmitterLayer()
//    decorate(emitterLayer: caELayer1)
//
//    //行为定制1
//    decorateBehavior(emitterLayer: caELayer1)
//
//    //炮弹1
//    let cannonball1 = CAEmitterCell()
//    decorateCannonball(emitterCell: cannonball1)
//
//    //爆炸1
//    let burst1 = CAEmitterCell()
//    decorateBurst(emitterCell: burst1)
//
//    //火花1
//    let spark1 = CAEmitterCell()
//    decorateSpark(emitterCell: spark1)
//    spark1.color = UIColor.rgbValue(red: 73, green: 179, blue: 155).cgColor
//
//    //装载1
//    caELayer1.emitterCells = [cannonball1]
//    cannonball1.emitterCells = [burst1]
//    burst1.emitterCells = [spark1]
//    targetView.layer.addSublayer(caELayer1)
//
//    //发射器2
//    let caELayer2 = CAEmitterLayer()
//    decorate(emitterLayer: caELayer2)
//
//    decorateBehavior(emitterLayer: caELayer2)
//
//    //炮弹2
//    let cannonball2 = CAEmitterCell()
//    decorateCannonball(emitterCell: cannonball2)
//
//    //爆炸2
//    let burst2 = CAEmitterCell()
//    decorateBurst(emitterCell: burst2)
//
//    //火花2
//    let spark2 = CAEmitterCell()
//    decorateSpark(emitterCell: spark2)
//    spark2.color = UIColor.rgbValue(red: 227, green: 59, blue: 117).cgColor
//
//    //装载2
//    caELayer2.emitterCells = [cannonball2]
//    cannonball2.emitterCells = [burst2]
//    burst2.emitterCells = [spark2]
//    targetView.layer.addSublayer(caELayer2)
//
//    //发射器3
//    let caELayer3 = CAEmitterLayer()
//    decorate(emitterLayer: caELayer3)
//
//    decorateBehavior(emitterLayer: caELayer3)
//
//    //炮弹2
//    let cannonball3 = CAEmitterCell()
//    decorateCannonball(emitterCell: cannonball3)
//
//    //爆炸2
//    let burst3 = CAEmitterCell()
//    decorateBurst(emitterCell: burst3)
//
//    //火花2
//    let spark3 = CAEmitterCell()
//    decorateSpark(emitterCell: spark3)
//    spark3.color = UIColor.rgbValue(red: 255, green: 249, blue: 231).cgColor
//
//    //装载2
//    caELayer3.emitterCells = [cannonball3]
//    cannonball3.emitterCells = [burst3]
//    burst3.emitterCells = [spark3]
//    targetView.layer.addSublayer(caELayer3)
//
//    GCDHelper.entryCountdown(15) {
//      backLayer.removeFromSuperlayer()
//      caELayer1.removeFromSuperlayer()
//      caELayer2.removeFromSuperlayer()
//      caELayer3.removeFromSuperlayer()
//    }
//
//  }
//
//}

