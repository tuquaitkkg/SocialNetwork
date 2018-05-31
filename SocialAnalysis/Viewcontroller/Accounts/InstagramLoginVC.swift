//
//  InstagramLoginVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/14/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class InstagramLoginVC: BaseVC {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLayout() -> Void {
        self.setupTitleNavi(title: "Instargram login")
        self.setupBackButton()
        self.webView.scrollView.bounces = false
        let url = InstagramEngine.shared().authorizationURL()
        self.webView.loadRequest(URLRequest.init(url: url))
    }
    
    func authenticationSuccess() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func doBack() {
        self.webView.stopLoading()
        self.webView = nil
        self.dismiss(animated: true, completion: nil)
    }
}

extension InstagramLoginVC:UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let a = (((try? InstagramEngine.shared().receivedValidAccessToken(from: request.url!)) != nil)) as Bool
        if a == true{
             self.authenticationSuccess()
            
        }
//        guard (try? InstagramEngine.shared().receivedValidAccessToken(from: request.url!)) != nil else {
//            let a = request.url?.absoluteString
//            print("request.url?.absoluteString: ",a!)
//            if a! == "https://www.facebook.com/dao.vanuoc"{
//                self.authenticationSuccess()
//            }
//        }
        
        return true
    }
}
