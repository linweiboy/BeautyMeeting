//
//  URLPath.swift
//  XiaoZhuGeJinFu
//
//  Created by rongteng on 2017/6/16.
//  Copyright © 2017年 rongteng. All rights reserved.
//


//MARK: -小诸葛独立Path
extension XZGURL {
  
  //首页banner
  static let homeProduct = "wd_api/banner/getBannerOn"
  //判断今日是否签到
  static let homeTodaySign = "wd_api/mallIntegral/isSignToday"
  //签到
  static let homeSign = "wd_api/mallIntegral/sign"
  //首页应用列表
  static let newHomePortal = "wd_api/appIndexPortal/getPortalsOn"
  //首页推荐标列表
  static let homeList = "wd_api/recommend/getRecommendProductOn"
  
  
  //产品列表
//  static let investList = "wd_api/subject/getInvestSubjectOn" //旧
  static let investList = "wd_api/subject/getInvestFinaSubjectOn"
  
  //产品详情
  static let investProductDetail = "wd_api/subject/detailNewOn"
  //借呗产品详情
  static let borrowProductDetail = "wd_api/chant/detail"
  //借呗产品项目详情
  static let borrowProjectDetail = "wd_api/chant/info"
  //投资记录
  static let investRecord =  "wd_api/subject/getDetailHistoryOn"
  //投资记录排行前三
  static let investRecordFirstThree = "wd_api/subject/getDetailHistoryRankOn"
  //借款详情
  static let investBorrowMoneyDetail = "wd_api/subject/getDetailOn"
  //红包列表
  static let investCouponList = "wd_api/member/getVouchers"
  //获取银行列表
  static let investBankList = "wd_api/recharge/bankList"
  //计算投资收益
  static let investinvestIncome = "wd_api/subject/investCalOn"
  //充值投资 或 充值绑卡投资 前进行创建订单
  static let investCreateNewOrder = "wd_api/tradeOrdLog/newOrder"
  //充值投资结束 或者 充值绑卡投资结束 查询订单是否成功
  static let investFindOrder = "wd_api/tradeOrdLog/findOrder"
  //确认投资
  static let investConfirmOn = "wd_api/member/investCheckMsgOn"
  //诸葛智投计算收益
  static let zhugeIncome = "wd_api/roaApp/investCalOn";
  

  //不良资产
  //不良资产列表
  static let badPropertyProductList = "wd_api/badLoan/projectListOn"
  //不良资产详情
  static let badPropertyProductDetail = "wd_api/badLoan/getProjectDetailOn"
  //不良资产提交用户申请信息
  static let badPropertyUploadMsg = "wd_api/badLoan/saveOn"
  
  
  //发现
  //文章详情
  static let moreArticleDetail = "wd_api/article/getArticleDetailOn"
  //根据Code获取所有子分类
  static let discoverGetSubCodes = "wd_api/article/getSubCodesOn"
  //上传图片
  static let moreSetUpPicture = "wd_api/userCenter/uploadImgOn"
  //意见反馈
  static let moreFeedbackSuggest = "wd_api/userCenter/feedBackOn"
  //我要借款,提交用户信息
  static let postUserInformation = "wd_api/loanFeedBack/addOn"
  
  static let discoverHome = "wd_api/banner/getActivityOn"
  static let discoverList = "wd_api/banner/getActivityListOn"
  
  
  //我的
  //发送验证码(登录或者注册)
  static let sendVerify_LoginAndRegister = "wd_api/userCenter/sendVerifyForLoginOn"
  //注册
  static let register = "wd_api/userCenter/registerOn"
  //注册 检查手机号码是否已经注册
  static let register_CheckMobile = "wd_api/userCenter/checkMobileOn"
  //登录
  static let login = "wd_api/userCenter/loginOn"
  //发送验证码(找回登录密码)
  static let sendVerify_ResetLoginPassword = "wd_api/userCenter/sendRetrievePwdCodeOn"
  //找回登录密码
  static let resetLoginPassword = "wd_api/userCenter/doRetrievePwdResetOn"
  //修改登录密码
  static let userModifyLoginPassword = "wd_api/userCenter/editPassword"
  //修改交易密码
  static let userModifyTradePassword = "wd_api/userCenter/editOutPassword"
  //找回交易密码
  static let userResetTradePassword = "wd_api/userCenter/doRetrieveOutPwdResetOn"
  //用户资产信息
  static let userAssetInfo = "wd_api/member/info"
  //用户中心资产详情
  static let memberInfoall = "wd_api/member/infoAll"
  //用户的投资记录
  static let userInvestRecord = "wd_api/member/investRecord"
  //资金明细
  static let userAssetItemizedAccount = "wd_api/member/moneyRecord"
  //这个是包含 可用 已用 过期 的所有红包列表
  static let user_CouponList = "wd_api/member/getVoucherList"
  //用户实名信息  账户设置页面使用
  static let user_RealNameInfo = "wd_api/member/getMemberCertiInfo"
  //用户消息列表
  static let userMessageList = "wd_api/userCenter/getUserMessageList"
  //提现
  static let userDrawMoney = "wd_api/recharge/doWithdraw"
  //网贷提现至财富账户
  static let netBorrowDrawMoneyToFinance = "wd_api/appTransfer/newOrder"
  //网贷提现至财富账户订单检查
  static let netBorrowDrawMoneyToFinanceCheckOrder = "wd_api/appTransfer/checkOrder"
  
  //连连充值
  static let userRecharge = "wd_api/recharge/lianlianSubmit"
  //充值签名
  static let userRechargeSign = "wd_api/recharge/lianlianSign"
  //邀请好友-详情
  static let userInviteFriendDetail = "wd_api/inviteIndex/getInvite"
  //已邀请好友列表
  static let userInviteFriendList = "wd_api/inviteIndex/getInviteDetail"
  //修改银行卡信息
  static let userEditBank = "wd_api/recharge/editBankCard"
  //修改用户名
  static let userSetModifyUserName = "wd_api/member/updateUserName"
  //修改手机号码
  static let userSetModifyUserPhoneNumber = "wd_api/userCenter/reValidMobile"
  //提交or修改邮箱
  static let userSetModifyUserEmail = "wd_api/email/bindEmail"
  //充值时获取银行列表
  static let userGetBankList = "wd_api/recharge/getBankList"
  //获取验证码
  static let userGetVerify = "wd_api/userCenter/sendVerifyOn"
  //提现手续费
  static let userDrawCashFee = "wd_api/recharge/getWithdrawFee"
  //获取地区列表
  static let userAreaList = "wd_api/userCenter/areaOn"
  //验证验证码
  static let checkVerifty = "wd_api/userCenter/checkVerifyOn"
  //校验交易密码
  static let chenckPassWord = "wd_api/recharge/checkOutPwd"
  
  //已发布
  static let userMyLoanAlreadyReleased = "wd_api/myBorrow/publishList"
  //已还清
  static let userMyLoanPaidOff = "wd_api/myBorrow/doneList"
  //待还款
  static let userMyLoanWaitPain = "wd_api/myBorrow/repaymentList"
  
  static let userMyLoanRepayment = "wd_api/myBorrow/payment"
  
  static let userMyLoanApplyForRepayment = "wd_api/myBorrow/repayment"
  
  static let userMyLoanPayPlan = "wd_api/myBorrow/repaymentPlan"
  
  
  //公共接口
  //common 接口
  static let achieveBannarLink = "wd_api/banner/getBannerOn"
  //获取系统资源
  static let achieveSystemSource = "wd_api/userCenter/sysConfigOn"
  //版本检测接口
  static let achieveLatestNewVersionNum = "wd_api/userCenter/versionOn"
  //用户操作日志
  static let userOperation = "wd_api/userOperation/addOn"
  //文章列表
  static let commonArticleList = "wd_api/article/getArticleListOn"
  
  
  
  //积分兑换首页
  static let integralExchangeHome = "wd_api/mallIntegral/firstPage"
  //积分兑换列表
  static let integralExchangeList = "wd_api/mallIntegral/waitList"
  //积分兑换详情
  static let integralExchangeDetail = "wd_api/mallIntegral/convertVoucherDetails"
  //立即兑换
  static let integralExchange = "wd_api/mallIntegral/conversion"
  
  //智能投顾标产品详情
  static let intelligentInvestProductDetail = "wd_api/roaApp/getFinaDetailsOn"
  //智能投顾标产品投资记录
  static let intelligentInvestProductInvestHistory = "wd_api/roaApp/getFinaHistoryOn"
  //智能投顾标可用红包列表
  static let intelligentInvestCanUseVoucher = "wd_api/roaApp/getVouchersByFina"
  
  //我的智能顾投列表
  static let myIntelligentInvestList = "wd_api/member/advisorInvestRecords"
  //我的智能顾投详情
  static let myIntelligentInvestDetail = "wd_api/member/advisorInvestDetail"
  //债权列表
  static let roaInvestList = "wd_api/roaApp/roaInvestList"
  
  
  
  
  //托管充值
  static let netBorrowRecharge = "wd_api/recharge/newSubmit"
  //托管获取验证码
  static let netBorrowDepositSmsCode = "wd_api/member/getDepositSmsCode"
  //托管充值查询充值结果
  static let netBorrowRechargeCheckPay = "wd_api/recharge/checkPay"
  
  //托管 申请托管
  static let applyTrusteeship = "wd_api/userCenter/resultBinkCardBinkCard"
  //托管 验证托管
  static let applyTrusteeshipAuthentication = "wd_api/userCenter/doAuthentication"
  
  
  
  //-----------------------------------------------------------H5地址
  //安全保障
  static let H5_SafeGuarantee = "sageguard/index.html"
  //投资协议
  static let H5_InvestAgreement = "center/contract/preview-fqb"
  //注册协议
  static let H5_registerAgreement =  "agreement/service.html"
  //邀请好友活动页面
  static let H5_InviteFriendActivity = "topic/invite/index.html"
  //提现说明
  static let H5_WithdrawalCash = "center/withdraw/explain.html"
  //最新活动
  static let H5_NewActivity = "about/newActivity.html"
  //品牌介绍
  static let H5_BrandIntroduce = "sageguard/introduce.html"
  //操作指南
  static let H5_OperateGuidance = "sageguard/sttrong.html"
  //银行存管
  
  static let H5_BankStoreManage = "topic/activity_mobile/cunguan_h5.html"
//  static let H5_BankStoreManage = "about/content/1386.html"
  
  /**
   * 诸葛结算介绍
   */
   static let H5_ZhuGeIntrodce = "h5/jieshao.html";
  /**
   * 常见问题
   */
   static let H5_NomalProble = "h5/changjianwenti.html";
  /**
   * 诸葛智投服务协议
   */
   static let H5_ZhuGeZhiTou = "h5/zhinengtougu.html";
  /**
   * 风险告示书
   */
   static let H5_FengXian = "h5/risk.html";
  
}




