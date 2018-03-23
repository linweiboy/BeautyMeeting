//
//  ChatListVC.swift
//  BeautyMeeting
//
//  Created by vint on 2018/3/21.
//  Copyright © 2018年 TanLinwei. All rights reserved.
//

class ChatListVC: RCConversationListViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDisplayConversationTypes([RCConversationType.ConversationType_GROUP.rawValue])
    
    conversationListTableView.tableFooterView = UIView()
    emptyConversationView = UIView()
  }
  
  override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
    
    let detailChat = ChatDetailVC()
    detailChat.conversationType = model.conversationType
    detailChat.targetId = model.targetId
    detailChat.title = "test chat"
    self.pushTo(detailChat)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
