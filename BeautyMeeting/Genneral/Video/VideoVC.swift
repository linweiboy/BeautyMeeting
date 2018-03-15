//
//  DiscoverVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class VideoVC: UIViewController, VcDefaultConfigProtocol,LoadingPresenterProtocol {

  
  fileprivate var playCollectionView:UICollectionView!
  fileprivate var cellHeader = VideoTabHeaderView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      defaultConfig()
      createView()
      refreshData()
    }

  func refreshData() {
    VideoRequest.videoList { [weak self](result) in
      guard let strongSelf = self else{return}
      switch result {
      case .success(let json):
        printLog(message: json)
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }
    }
  }
  
  
  func moreClick(_ section:Int){
    printLog(message: section)
  }
  
  func headerClick(_ tag:Int){
    switch tag {
    case 10:
      let boVc = BoBaoVC()
      pushTo(boVc)
    case 11:
      let vc = FamousTeacherVC()
      pushTo(vc)
    case 12:
      let vc = ApplyBoBaoVC()
      pushTo(vc)
    default:break
    }
  }
  
}
extension VideoVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseIdentifier, for: indexPath) as! VideoCell
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  //分组头部、尾部
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if indexPath.section == 0 {
      cellHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "VideoTabHeaderView", for: indexPath) as! VideoTabHeaderView
      cellHeader.headerClickClosuer = {[unowned self] tag in
        self.headerClick(tag)
      }
      let oneView = CustomTabHeaderView()
      oneView.showTitleDateStr("在线直播", moreLBIsHidden: false)
      oneView.moreClickClosure = {[unowned self] in self.moreClick(indexPath.section)}
      cellHeader.addSubview(oneView)
      oneView.snp.makeConstraints({ (make) in
        make.left.right.equalTo(cellHeader)
        make.height.equalTo(45.ratioHeight)
        make.bottom.equalTo(cellHeader.snp.bottom)
      })
      return cellHeader
    }else{
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: VideoCustomTitleView.reuseIdentifier, for: indexPath) as! VideoCustomTitleView
      let twoView = CustomTabHeaderView()
      twoView.showTitleDateStr("演讲沟通", moreLBIsHidden: false)
      twoView.moreClickClosure = {[unowned self] in self.moreClick(indexPath.section)}
      headerView.addSubview(twoView)
      twoView.snp.makeConstraints({ (make) in
        make.top.left.right.equalTo(headerView)
        make.height.equalTo(45.ratioHeight)
      })
      return headerView
    }
  }
  
  //返回分组的头部视图的尺寸，在这里控制分组头部视图的高度
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    switch section {
    case 0:
      return CGSize(width: ScreenWidth, height: 130.ratioHeight)
    default:break
    }
    return CGSize(width: ScreenWidth, height: 50.ratioHeight)
  }
  
}




extension VideoVC {
  
  func createView() {
    let layout = VideoCellLayout()
    playCollectionView = {
      $0.delegate = self
      $0.dataSource = self
      $0.decelerationRate = UIScrollViewDecelerationRateFast
      $0.register(VideoCell.self)
      $0.registerHeader(VideoCustomTitleView.self)
      $0.showsHorizontalScrollIndicator = false
      $0.showsVerticalScrollIndicator = false
      $0.backgroundColor = self.view.backgroundColor
      return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    playCollectionView.register(VideoTabHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "VideoTabHeaderView")
    self.view.addSubview(playCollectionView)
    playCollectionView.snp.makeConstraints { (make) in
      make.edges.equalTo(self.view)
    }
  }
  
}
