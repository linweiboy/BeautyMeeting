//
//  CashierVC.swift
//  BeautyMeeting
//
//  Created by LinweiTan on 2018/3/2.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

import UIKit

//收银台
class CashierVC: UIViewController,VcDefaultConfigProtocol,PopVCSetProtocol,LoadingPresenterProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "收银台"
      defaultConfig()
      popLastPage()
      createView()
  }
  
  func payClick() {
    showMessage("去支付")
  }

}

extension CashierVC{
  
  func createView() {
    
    let header = CashierView()
    view.addSubview(header)
    header.snp.makeConstraints { (make) in
      make.top.equalTo(5)
      make.left.right.equalTo(self.view)
      make.height.equalTo(100.ratioHeight)
    }
    
    let payView = payTypeView()
    payView.payClick = { [unowned self] in
      self.payClick()
    }
    view.addSubview(payView)
    payView.snp.makeConstraints { (make) in
      make.top.equalTo(header.snp.bottom).offset(5)
      make.left.right.bottom.equalTo(self.view)
    }
    
  }
}
