//
//  AppManagetDetailsVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AppManagetDetailsVC: BaseVC {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var accManager:AppManagerObject!
    @IBOutlet weak var webContent: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.initData()
        self.webContent.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData() -> Void {
        self.setupBackButton()
        self.setupTitleNavi(title: accManager.name)
        self.webContent.loadRequest(URLRequest.init(url: URL.init(string: accManager.url)!))
    }
}

extension AppManagetDetailsVC:UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
    }
}
