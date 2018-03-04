//
//  MainTabBarVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/1/24.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import IQKeyboardManagerSwift

class MainTabBarVC: UITabBarController,UITabBarControllerDelegate,LoginExpiredProtocol,LoadingPresenterProtocol {
  
  fileprivate let homeVC = HomeVC()
  fileprivate let chatVC = ChatVC()
  fileprivate let videoVC = VideoVC()
  fileprivate let userVC = UserVC()
  fileprivate let mallVC = MallHomeVC()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      delegate = self
      barStyle()
      barButtonItemStyle()
      addSubVC()
    }
  
  func addSubVC() {
    addChildVC(homeVC, title: "首页", image: "tabbar_home", selectedImage: "tabbar_home_selected")
    addChildVC(chatVC, title: "聊天", image: "tabbar_Invest", selectedImage: "tabbar_Invest_selected")
    addChildVC(videoVC, title: "视频", image: "tabbar_discover", selectedImage: "tabbar_discover_selected")
    addChildVC(mallVC, title: "商城", image: "tabbar_Mall", selectedImage: "tabbar_Mall_selected")
    addChildVC(userVC, title: "我的", image: "tabbar_user", selectedImage: "tabbar_user_selected")
  }
  
  fileprivate func addChildVC(_ childVC:UIViewController, title:String, image:String,selectedImage:String) {
    childVC.title = title
    childVC.tabBarItem.image = UIImage(named: image)
    childVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
    childVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
    
    let nav = UINavigationController(rootViewController: childVC)
    nav.delegate = self
    addChildViewController(nav)
  }
  
  func presentRegisterVC() {
    let registerVC = RegisterVC()
    registerVC.entryRegisterVCType = .present
    let nav = UINavigationController(rootViewController: registerVC)
    present(nav, animated: true, completion: nil)
  }
  
  func presentLoginVC() {
    let login = LoginVC()
    let nav = UINavigationController(rootViewController: login)
    present(nav, animated: true, completion: nil)
  }

}

extension MainTabBarVC:UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    switch viewController {
    case is HomeVC,is UserVC:
      viewController.navigationController?.setNavigationBarHidden(true, animated: true)
    default:
      viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
  }
}
extension MainTabBarVC {
//  导航栏统一设置
  fileprivate func barStyle() {
    let titleTextAtt = [
      NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18.ratioHeight),
      NSAttributedStringKey.foregroundColor:UIColor.white
    ]
    UINavigationBar.appearance().titleTextAttributes = titleTextAtt
    UINavigationBar.appearance().barTintColor =  .main
    self.tabBar.tintColor = .main
    UINavigationBar.appearance().isTranslucent = false
  }
  
  //导航栏 item 文字属性和图片属性
  fileprivate func barButtonItemStyle() {
    UIBarButtonItem.appearance().tintColor = UIColor.white
  }
}
