//
//  PopularizeView.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 16/6/23.
//  Copyright © 2016年 rongteng. All rights reserved.
//


class PopularizeView: UIView {
  
  var backViewArray: [ImageAndBottomTitle] = []
  
  var selectClosure: ((_ tag:Int)->())?
  
  convenience init(count:Int) {
    self.init(frame:CGRect.zero)
    self.backgroundColor = .white
    backViewArray.removeAll()
    
    let oneBackView = ImageAndBottomTitle()
    addSubview(oneBackView)
    oneBackView.tag = 10
    oneBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
      self.selectCurrentType(tag)
    }
    oneBackView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(0)
    }
    
    let twoBackView = ImageAndBottomTitle()
    addSubview(twoBackView)
    twoBackView.tag = 11
    twoBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
      self.selectCurrentType(tag)
    }
    twoBackView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(oneBackView.snp.right)
      make.width.equalTo(oneBackView)
    }
    
    let threeBackView = ImageAndBottomTitle()
    addSubview(threeBackView)
    threeBackView.tag = 12
    threeBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
      self.selectCurrentType(tag)
    }
    threeBackView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(twoBackView.snp.right)
      make.width.equalTo(twoBackView)
    }
    
    let fourBackView = ImageAndBottomTitle()
    addSubview(fourBackView)
    fourBackView.tag = 13
    fourBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
      self.selectCurrentType(tag)
    }
    fourBackView.snp.makeConstraints { (make) in
      make.top.bottom.equalTo(self)
      make.left.equalTo(threeBackView.snp.right)
      make.width.equalTo(threeBackView)
      make.right.equalTo(self)
    }
    
    backViewArray.append(oneBackView)
    backViewArray.append(twoBackView)
    backViewArray.append(threeBackView)
    backViewArray.append(fourBackView)
    
  }
  
    convenience init(count:Int,markStr:String) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = .white
        backViewArray.removeAll()
        
        let oneBackView = ImageAndBottomTitle()
        addSubview(oneBackView)
        oneBackView.tag = 10
        oneBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
            self.selectCurrentType(tag)
        }
        oneBackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(0)
        }
        
        let twoBackView = ImageAndBottomTitle()
        addSubview(twoBackView)
        twoBackView.tag = 11
        twoBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
            self.selectCurrentType(tag)
        }
        twoBackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(oneBackView.snp.right)
            make.width.equalTo(oneBackView)
        }
        
        let threeBackView = ImageAndBottomTitle()
        addSubview(threeBackView)
        threeBackView.tag = 12
        threeBackView.imageAndBottomTitleClickClosure = {[unowned self] (tag)->() in
            self.selectCurrentType(tag)
        }
        threeBackView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.equalTo(twoBackView.snp.right)
            make.width.equalTo(twoBackView)
            make.right.equalTo(self)
        }
        
        
        backViewArray.append(oneBackView)
        backViewArray.append(twoBackView)
        backViewArray.append(threeBackView)

    }
    
  //填充值
  func fileValueWith(titles:[String],imageNames:[String])  {
    guard titles.count == imageNames.count else {return}
    guard backViewArray.count >= titles.count  else {return}
    for (index,titleStr) in titles.enumerated() {
      let imageAndBottomTitle = backViewArray[index]
      let image = UIImage(named: imageNames[index])
      imageAndBottomTitle.loadContent(image, titleName: titleStr)
    }
  }
  
  
  //修改图标
  func modifyIcon(path:String,titles:[String]) {
    let imageArr = ["BrandIntroduce","mediue","home_bankstoremanage","SafeGuarantee"]
      .map { return "\(path)/\($0)"}
    for (index,imagePath) in imageArr.enumerated() {
      let img = UIImage(contentsOfFile: imagePath)
      let imageAndBottomTitle = backViewArray[index]
      imageAndBottomTitle.loadContent(img,titleName:titles[index])
    }
  }
  
  //修改背景
  func modifyPublicityBack(path:String)  {
    //popularizeView image
    let popularizeV = self.subviews
    if let backImg = UIImage(contentsOfFile: "\(path)/popularzeBackView") {
      let backImgV = UIImageView(image: backImg)
      self.insertSubview(backImgV, belowSubview: popularizeV[0])
      backImgV.snp.makeConstraints { (make) in
        make.edges.equalTo(self)
      }
    }
  }
  
  func selectCurrentType(_ tag:Int) {
    if selectClosure != nil {
      selectClosure!(tag)
    }
  }
  
}



class ImageAndBottomTitle: UIView {
  
  var imageAndBottomTitleClickClosure:((_ tag:Int)->())?
  
  fileprivate let imageV = UIImageView()
  fileprivate let bottomTitle = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageV)
    imageV.snp.makeConstraints { (make) in
      make.centerX.equalTo(self)
      make.centerY.equalTo(self).offset(-10)
      make.width.height.equalTo(0)
    }
    
    addSubview(bottomTitle)
    bottomTitle.decorateStyleOfLB(title: "", textColor: UIColor.rgbValue(sameValue: 68), textFont: 11.ratioHeight,textAlignment:.center)
    bottomTitle.snp.makeConstraints { (make) in
      make.top.equalTo(imageV.snp.bottom).offset(5)
      make.left.right.equalTo(self)
      make.height.equalTo(20)
    }
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(imageAndBottomTitleClick))
    self.addGestureRecognizer(tap)
  }
  
  func loadContent(_ image:UIImage?,titleName:String = "") {
    if let image = image {
      imageV.image = image
      imageV.contentMode = .scaleAspectFit
      imageV.snp.updateConstraints({ (make) in
        make.width.equalTo(image.ratioWidth)
        make.height.equalTo(image.ratioHeight)
      })
    }
    
    if !titleName.isEmpty {
      bottomTitle.text = titleName
    }
  }
  
  @objc func imageAndBottomTitleClick() {
    if let closure = imageAndBottomTitleClickClosure {
      closure(self.tag)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


















