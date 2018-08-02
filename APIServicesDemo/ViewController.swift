//
//  ViewController.swift
//  APIServicesDemo
//
//  Created by CSPLT18 on 02/08/18.
//  Copyright © 2018 Sankar. All rights reserved.
//

import UIKit




class ViewController: UIViewController,WebServiceDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSDelegate = self
//        sendRequestForAPICallwith(urlString: "", methodType: "GET", params: [:])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func loadData() {
        let param: [String: Any] = [
            "email" : "Vinod.l@gmail.com" ,
            "password" : "******" ,
        ]
        let MAIN_URL   = "https://facebook.com/"
        let url = "\(MAIN_URL)/ControllerName/ServieType"
        // Controller Name = Any Name
        //Service Type = Login Or SignUp
        let ClassInstance = APIServiceCalls()
        ClassInstance.sendRequestForAPICallwith(urlString: url, methodType: "GET", params: param as [String : AnyObject])
    }
    
    
    
    //MARK:- Check Internet Connectivity
    func ApiServiceSucessWithPostData(with response: [String : AnyObject]) {
        // Response Here
    }
    
    func ApiServiceFailWithPostErrorMsg(errorMsg: String) {
        // fail Response here
    }
    
     
    
    
   
    
    
    

    
    
}



