//
//  AFBaseRequest.swift
//  RongTeng
//
//  Created by rongteng on 16/3/28.
//  Copyright © 2016年 Mike. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest:SessionManager {
  
  internal static let shared = BaseRequest()
  
  fileprivate init() {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 15.0
    super.init(configuration: configuration, delegate: SessionDelegate())
  }
  
  struct Router: URLRequestConvertible {
    let path:String
    let parameters:Dictionary<String, Any>
    let baseURL:String
    init(baseURL:String, path:String,parameters:Dictionary<String, Any>) {
      self.baseURL = baseURL
      self.path = path
      self.parameters = parameters
    }
    func asURLRequest() throws -> URLRequest {
      let url = try self.baseURL.asURL()
      var urlRequest = URLRequest(url: url.appendingPathComponent(path))
      urlRequest.httpMethod = HTTPMethod.post.rawValue
      urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
      return urlRequest
    }
  }
  
  //添加公共参数
  func addCommonParamFor(parameters:[String:String]) -> [String:String] {
    var resultPara = parameters
    resultPara["appKey"] =  PlatformKey.AppKey
    resultPara["timestamp"] = DateHepler.transformCurrentTime("yyyy-MM-dd HH:mm:ss")
    resultPara["appVersion"] = AccessSystem.versionNum
    //token有就传
    if let userAccount = AccountManage.shared.currentAccount() {
      resultPara["token"] = userAccount.accessToken
      resultPara["memberId"] = userAccount.id
    }
    resultPara["sign"] = SignHelper.XZGSignWith(resultPara)
    return resultPara
  }
  
  ///post网络请求
  func postRequest(url urlStr:String, parameters:Dictionary<String,String>, completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    printLog(message: "签名前参数\(parameters)")
    let para = addCommonParamFor(parameters: parameters)
    printLog(message: "签名前添加参数\(para)")
    let rot = Router(baseURL:XZGURL.server.currentUrl,path: urlStr, parameters: para)
    printLog(message: "签名后\(rot)")
    request(rot)
    .responseJSON { (response) in
       self.handleResult(response: response, completionHandler: completionHandler)
      printLog(message: response.result)
      printLog(message: response.request)
    }
  }
  
  ///上传图片
  func postUpload(url urlStr:String,parameters:[String:String],data:Data,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    let param = addCommonParamFor(parameters: parameters)
    let imageUrl = XZGURL.server.currentUrl + urlStr
    let dataStr = DateHepler.transformCurrentTime("yyyyMMddHHmmss")
    let fileName = dataStr+".png"
    upload(multipartFormData: { (multipartFormData) in
      multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "image/png")
      for (key,value) in param {
        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
      }
    }, to: imageUrl) { (response) in
      switch response {
      case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
        upload.responseJSON(completionHandler: { (response) in
          self.handleResult(response: response, completionHandler: completionHandler)
        })
      case .failure:
        let errorN = RequestError(code: -1, reason: "上传失败")
        completionHandler(RequestResult.failure(errorN))
      }
    }
  }
  
  
  func handleResult(response:DataResponse<Any>,completionHandler:@escaping (RequestResult<JSON>) -> ()) {
    guard let res = response.response else {
      let errorN = RequestError(code: -201, reason: "网络连接超时！")
      completionHandler(RequestResult.failure(errorN))
      return
    }
    if res.statusCode == 200 {
      guard let result = response.result.value else {
        let error = RequestError.unknownError(200)
        completionHandler(RequestResult.failure(error))
        return
      }
      let common = CommonModel(json: JSON(result))
      if common.isSuccess {
        completionHandler(RequestResult.success(JSON(result)))
      }else {
        let error = RequestError(code: common.status, reason: common.message)
        completionHandler(RequestResult.failure(error))
      }
    }else {
      var errorDescription = ""
      if res.statusCode == 404 {
        errorDescription = "网络请求错误！"
      }else {
        errorDescription = "服务器正在维护，请稍后再试！"
      }
      let error = RequestError(code: res.statusCode, reason: errorDescription)
      completionHandler(RequestResult.failure(error))
    }
  }

 
  
  
}
