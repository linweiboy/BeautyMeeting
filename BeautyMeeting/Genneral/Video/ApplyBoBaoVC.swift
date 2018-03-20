//
//  ApplyBoBaoVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/2/26.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class ApplyBoBaoVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {
  
  fileprivate let nameTF = UITextField()
  fileprivate let idCardTF = UITextField()
  fileprivate let sixTF = UITextField()
  fileprivate let phoneTF = UITextField()
  fileprivate let applyCityTF = UITextField()
  fileprivate let addressTF = UITextField()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "申请播报"
      defaultConfig()
      popLastPage()
      createView()
    }

  @objc func btnClick() {
    showMessage("您已提交申请")
  }


}

extension ApplyBoBaoVC {
  
  func createView() {
    
    let mainView = ApplyBoBaoView(nameTF: nameTF, idCardTF: idCardTF, sixTF: sixTF, applyCityTF: applyCityTF, addressTF: addressTF)
    self.view.addSubview(mainView)
    mainView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(240.ratioHeight)
    }
    
    let btn = UIButton(type: .custom)
    btn.decorateStyleOfBT(title: "确认申请", textColor: UIColor.white, textFont: 15.ratioHeight)
    btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    btn.backgroundColor = UIColor.main
    view.addSubview(btn)
    btn.snp.makeConstraints { (make) in
      make.left.equalTo(0.5)
      make.right.bottom.equalTo(-0.5)
      make.height.equalTo(40.ratioHeight)
    }
  }
}

