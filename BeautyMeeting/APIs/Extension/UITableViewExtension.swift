////
////  UITableViewExtension.swift
////  XiaoZhuGeJinFu
////
////  Created by rongteng on 16/6/27.
////  Copyright © 2016年 rongteng. All rights reserved.

extension UITableView {
  
  func finishRefreshing() {
    if self.mj_footer != nil {self.mj_footer.endRefreshing()}
    if self.mj_header != nil {self.mj_header.endRefreshing()}
  }
  
}

extension UITableView:TableViewNoDateAddViewProtocol {
  
}
