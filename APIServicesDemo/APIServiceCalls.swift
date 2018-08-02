//
//  APIServiceCalls.swift
//  APIServicesDemo
//
//  Created by CSPLT18 on 02/08/18.
//  Copyright © 2018 MadhuPilla. All rights reserved.
//

import UIKit


protocol WebServiceDelegate: NSObjectProtocol {
    func ApiServiceSucessWithPostData(with response: [String: AnyObject])
    func ApiServiceFailWithPostErrorMsg(errorMsg : String)
}

weak var WebSDelegate: WebServiceDelegate?



class APIServiceCalls: NSObject {
    
    func sendRequestForAPICallwith(urlString: String, methodType: String, params: [String: AnyObject]) {
        
        //        if !checkInternetConnection() {
        //            let alert = UIAlertController(title: "Alert", message:"No internet connection, Try again later!", preferredStyle: UIAlertControllerStyle.alert)
        //            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        //            UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
        //            WSDelegate?.ApiServiceFailWithPostErrorMsg(errorMsg: "")
        //            return
        //        }
        let parameterString = params.stringFromHttpParameters()
        var config                              :URLSessionConfiguration!
        var urlSession                          :URLSession!
        config = URLSessionConfiguration.default
        urlSession = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "Content-Type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod                     = methodType
        let callURL = URL.init(string: "\(urlString)?\(parameterString)")
        print("urlstring -> \(String(describing: callURL!))")
        var request = URLRequest.init(url: callURL!)
        request.timeoutInterval = 60.0
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
        request.httpMethod = HTTPMethod
        let dataTask = urlSession.dataTask(with: request) { (data,response,error) in
            if error != nil{
                print("sasasasasasasasasasa\(String(describing: error))")
                return
            }
            do {
                let resultJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                DispatchQueue.main.async {
                    print(resultJson ?? "No data Here")
                    WebSDelegate?.ApiServiceSucessWithPostData(with: resultJson!)
                    
                    // var arrayRecords = [AnyHashable]()
                    // var records = arrayRecords[indexPath.row] as? [String: Any] ?? [:]
                }
                
            } catch {
                DispatchQueue.main.async {
                    WebSDelegate?.ApiServiceFailWithPostErrorMsg(errorMsg: error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    
    

}
