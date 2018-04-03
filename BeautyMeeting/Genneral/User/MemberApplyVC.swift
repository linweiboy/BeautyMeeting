//
//  MemberApplyVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/2.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

class MemberApplyVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {

  fileprivate let nameTF = UITextField()
  fileprivate let idCardTF = UITextField()
  fileprivate let sixTF = UITextField()
  fileprivate let applyCityTF = UITextField()
  fileprivate let addressTF = UITextField()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "会员申请"
      defaultConfig()
      popLastPage()
      createView()
        
    }
  
  //下一步点击事件
  @objc func btnClick() {
    
    UserRequest.userMemberApply(nameTF.text!, sex: "2", idCard: idCardTF.text!, address: addressTF.text!, referrer_mobile: applyCityTF.text!) { [weak self](result) in
      guard let strongSelf = self else {return}
      strongSelf.hiddenLoadingView()
      switch result {
      case .success(let data):
        printLog(message: data)
//        strongSelf.handleSuccess(resultJson:data)
      case .failure(let error):
        strongSelf.showMessage(error.reason)
      }

      
    }
    
    
    
    
//    let vc = CashierVC()
//    pushTo(vc)
  }

}


extension MemberApplyVC{
  func createView() {
    let mainView = ApplyView(nameTF: nameTF, idCardTF: idCardTF, sixTF: sixTF, applyCityTF: applyCityTF, addressTF: addressTF)
    self.view.addSubview(mainView)
    mainView.snp.makeConstraints { (make) in
      make.top.left.right.equalTo(self.view)
      make.height.equalTo(240.ratioHeight)
    }
    
    let btn = UIButton(type: .custom)
    btn.decorateStyleOfBT(title: "下一步", textColor: UIColor.white, textFont: 15.ratioHeight)
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
