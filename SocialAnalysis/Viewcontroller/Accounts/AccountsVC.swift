//
//  AccountsVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
class AccountsVC: BaseVC {

    @IBOutlet weak var tbvContent: UITableView!
    fileprivate var arrAccount = [AccountObject]()
    
    fileprivate var instagramEngine:InstagramEngine!
    fileprivate var currentPaginationInfo:InstagramPaginationInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initData()
        self.initlayout()
        
        if (FBSDKAccessToken.current() != nil){
             // User is logged in, do work such as go to next view controller. 
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (InstagramEngine.shared().isSessionValid() == true){
            let fbObject = self.arrAccount[1]
            fbObject.icon = "ic_Instargram"
            fbObject.status = true
            self.arrAccount[1] = fbObject
            self.tbvContent.reloadData()
        }
    }
    
    func initlayout() -> Void {
        self.setupTitleNavi(title: "Account")
        self.tbvContent.delegate = self
        self.tbvContent.dataSource = self
        self.tbvContent.register(UINib(nibName: AccountCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: AccountCell.getIdentifier())
        self.tbvContent.tableFooterView = UIView()
    }

    func initData() -> Void {
        self.instagramEngine = InstagramEngine.shared()
        
        var statusFB = false
        var iconFB = "ic_UnFB"
        if (FBSDKAccessToken.current() != nil){
            statusFB = true
            iconFB = "ic_FB"
        }
        let fb = AccountObject(name: "Facebook", icon: iconFB, status: statusFB)
        self.arrAccount.append(fb)
        
        var statusInstagram = false
        var iconInstagram = "ic_UnInstargram"
        if (InstagramEngine.shared().accessToken != nil){
            statusInstagram = true
            iconInstagram = "ic_Instargram"
        }
        let istar = AccountObject(name: "Instargram", icon: iconInstagram, status: statusInstagram)
        self.arrAccount.append(istar)
        
        var statusTwitter = false
        var iconTwitter = "ic-UnTwitter"
        if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() == true){
            statusTwitter = true
            iconTwitter = "ic_Twitter"
            
            TWTRTwitter.sharedInstance().sessionStore
        }
        
        let twitter  = AccountObject(name: "Twitter", icon: iconTwitter, status: statusTwitter)
        self.arrAccount.append(twitter)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginFB() -> Void {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile",
                                                        "email",
                                                        "user_friends",
                                                        "user_relationships",
                                                        "user_relationship_details"], from: self) { (result, error) in
            if error != nil{
                KSToastView.ks_showToast("Can't not login facebook!")
                return
            }
            let fbObject = self.arrAccount[0]
            fbObject.icon = "ic_FB"
            fbObject.status = true
            self.arrAccount[0] = fbObject
            self.tbvContent.reloadData()
        }
    }
}

extension AccountsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.getIdentifier(), for: indexPath) as! AccountCell
        cell.delegate = self
        cell.configCell(object: self.arrAccount[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = self.arrAccount[indexPath.row]
        let detailsVC = AccountDetailsVC(nibName: "AccountDetailsVC", bundle: nil)
        detailsVC.titleView = object.name
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
extension AccountsVC:AccountCellDelegate{
    func doConnectClick(tag: Int) {
        switch tag {
        case 0:
            if (FBSDKAccessToken.current() != nil){
                FBSDKLoginManager().logOut()
                let fbObject = self.arrAccount[0]
                fbObject.icon = "ic_UnFB"
                fbObject.status = false
                self.arrAccount[0] = fbObject
                self.tbvContent.reloadData()
            }else{
                self.loginFB()
            }
            break
        case 1:
            let login = InstagramLoginVC(nibName: "InstagramLoginVC", bundle: nil)
            let navi = UINavigationController(rootViewController: login)
            self.present(navi, animated: true, completion: nil)
            break
        case 2:
            
            TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                if (session != nil) {
                    print("signed in as \(String(describing: session?.userName))");
                    print("userID in as \(String(describing: session?.userID))");
                    print("authToken in as \(String(describing: session?.authToken))");
                    print("authTokenSecret in as \(String(describing: session?.authTokenSecret))");
                    self.dismiss(animated: true, completion: nil)
                    let twitterObject = self.arrAccount[2]
                    twitterObject.icon = "ic_Twitter"
                    twitterObject.status = true
                    self.arrAccount[2] = twitterObject
                    self.tbvContent.reloadData()
                } else {
                    print("error: \(String(describing: error?.localizedDescription))");
                }
            })
            break
        default:
            break
        }
    }
}


