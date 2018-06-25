//
//  AppManagetDetailsVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/12/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AppManagetDetailsVC: BaseVC,GADInterstitialDelegate {
    var interstitial: GADInterstitial!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var accManager:AppManagerObject!
    @IBOutlet weak var webContent: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.initData()
        self.webContent.delegate = self
        if accManager.name == "Messager" {
             UserDefaults.standard.register(defaults: ["UserAgent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36"])
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData() -> Void {
        self.setupBackButton()
        self.setupTitleNavi(title: accManager.name)
        self.webContent.loadRequest(URLRequest.init(url: URL.init(string: accManager.url)!))
        
        interstitial = GADInterstitial(adUnitID: kAdmobInterstitial)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
}

extension AppManagetDetailsVC:UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
    }
}


