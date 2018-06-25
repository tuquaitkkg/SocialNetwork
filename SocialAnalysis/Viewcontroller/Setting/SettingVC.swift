//
//  SettingVC.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class SettingVC: BaseVC,MFMailComposeViewControllerDelegate {
    fileprivate var arrSettingData = [SettingObject]()
    var bannerView: GADBannerView!
    @IBOutlet weak var tbvContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData() 
        self.initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbvContent.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Init
    func initLayout() -> Void {
//        self.setupBackButton()
        self.setupTitleNavi(title: "Setting")
        self.tbvContent.register(UINib(nibName: SettingCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: SettingCell.getIdentifier())
        self.tbvContent.register(UINib(nibName: SettingConfigCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: SettingConfigCell.getIdentifier())
        self.tbvContent.tableFooterView = UIView()
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = kAdmobBanner
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func initData() -> Void {
        let setting1 = SettingObject(name: "Change Passcode", content: "", value: false)
        self.arrSettingData.append(setting1)
        
//        let setting2 = SettingObject(name: "History", content: "", value: true)
//        self.arrSettingData.append(setting2)
//        
        var contents = ""
        if let filepath = Bundle.main.path(forResource: "policy", ofType: "txt") {
            do {
                contents = try String(contentsOfFile: filepath)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }
        let setting3 = SettingObject(name: "Privacy Policy", content: contents, value: true)
        self.arrSettingData.append(setting3)
        
//        let setting4 = SettingObject(name: "Terms of Service", content: "If you continue to use this application (Secret Santa), you are agreeing to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern Secret Santa relationship with you in relation to this application. If you disagree with any part of these terms and conditions, please do not use our website.\n\nThe use of this app is subject to the following terms of use:\n\nThe content of the pages of this app is for your general information and use only. It is subject to change without notice.\nThe following subscription plan is available:\n12 months subscription for $4.99\n\nInformation about the auto-renewable nature of the subscription\n\n- Subscription period 12 months. After 12 months your subscription renews.\n- Payment will be charged to iTunes Account at confirmation of purchase\n- Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period\n- Account will be charged for renewal within 24-hours prior to the end of the current period.\n- You can cancel your subscription via this url: https://support.apple.com/en-us/HT202039\n\nContact\n\nIf you have any questions about this Privacy Policy, please email us at toan@forsharing.info", value: true)
//        self.arrSettingData.append(setting4)
//
//        let setting5 = SettingObject(name: "Retore Puchase", content: "", value: true)
//        self.arrSettingData.append(setting5)
        
        let setting6 = SettingObject(name: "Support", content: "", value: true)
        self.arrSettingData.append(setting6)
        
        let setting7 = SettingObject(name: "Share this app", content: "", value: true)
        self.arrSettingData.append(setting7)
    }
}
extension SettingVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSettingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.getIdentifier(), for: indexPath) as! SettingCell
        cell.configCell(object: self.arrSettingData[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = self.arrSettingData[indexPath.row]
        if object.content != ""{
            let detailsVC = SettingContentVC(nibName: "SettingContentVC", bundle: nil)
            detailsVC.settingObject = object
            detailsVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }else if object.name == "Support"{
            sendEmail()
        }else if object.name == "Share this app"{
            let text = "Secret Santa"
            
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }else if object.name == "Change Passcode"{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let passcodeVC = storyboard.instantiateViewController(withIdentifier: "PasscodeViewController") as! PasscodeViewController
            passcodeVC.typeView = 1
            present(passcodeVC, animated: true, completion: nil)
        }
        
        tbvContent.deselectRow(at: indexPath, animated: true)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["mayman.huongdisaptoi251103@gmail.com"])
            
            present(mail, animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Please setting email on your iPhone or iPad.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                print("You've pressed default");
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
