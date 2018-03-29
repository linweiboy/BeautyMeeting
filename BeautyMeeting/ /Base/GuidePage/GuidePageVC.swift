//
//  GuidePageVC.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/8/19.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class GuidePageVC: UIViewController {
  
  var finishClosure:(()->())!
  
  let backScrollView = UIScrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(backScrollView)
    backScrollView.backgroundColor = UIColor.white
    backScrollView.isPagingEnabled = true
    backScrollView.showsHorizontalScrollIndicator = false
    backScrollView.snp.makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
    
    let oneView = OnePageView(titleImageName: "guide_one")
    let twoView = OnePageView(titleImageName: "guide_two")
    let threeView = OnePageView(titleImageName: "guide_three")
    let fourView = OnePageView(titleImageName: "guide_four",bottomImageCanClick:true)
    fourView.onePageViewSkipClosure = {[unowned self] in
      self.quitCurrentPage()
    }
    
    backScrollView.addSubview(oneView)
    oneView.snp.makeConstraints { (make) in
      make.top.bottom.left.equalTo(backScrollView)
      make.width.height.equalTo(self.view)
    }
    
    backScrollView.addSubview(twoView)
    twoView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(backScrollView)
      make.left.equalTo(oneView.snp.right)
      make.width.equalTo(oneView)
    }
    
    backScrollView.addSubview(threeView)
    threeView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(backScrollView)
      make.left.equalTo(twoView.snp.right)
      make.width.equalTo(twoView)
    }
    
    backScrollView.addSubview(fourView)
    fourView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(backScrollView)
      make.left.equalTo(threeView.snp.right)
      make.width.equalTo(threeView)
      make.right.equalTo(backScrollView)
    }
  }
  
  func quitCurrentPage() {
    AccountManage.saveWhetherShowGuidePage()
    finishClosure()
  }
  
  
  
  
  
  
  
  
}




