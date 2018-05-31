//
//  AccountDetailsVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class AccountDetailsVC: BaseVC {
    var titleView : String!
    var arrHeader = ["People who your followers","People who you follow","People who don't follow me","Friends visit your profile most","Friends visit your profile in the end","Friends Likes my posts the most","Friends comment on my posts the most"]

    @IBOutlet weak var tbvContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.doFBRequestData()
        
//        InstagramBussiness.sharedInstance.requestMyFollow(userID: InstagramEngine.shared().accessToken!, accessToken: InstagramEngine.shared().accessToken!, success: { (response) in
//
//        }) { (error) in
//
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLayout() -> Void {
        self.setupBackButton()
        self.setupTitleNavi(title:titleView)
        self.tbvContent.delegate = self
        self.tbvContent.dataSource = self
        self.tbvContent.tableFooterView = UIView()
        self.tbvContent.register(UINib(nibName: DetailsCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: DetailsCell.getIdentifier())
    }
    
    func doFBRequestData() -> Void {
        if ((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: nil, httpMethod: "GET").start(completionHandler: { (connection, result, error) in
                print("Facebook: ",result)
            })
        }
    }
}
extension AccountDetailsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHeader.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 45))
        viewHeader.backgroundColor = UIColor.white
        let lbHeader = UILabel(frame: CGRect(x: 5, y: 0, width: UIScreen.main.bounds.width, height: 45))
        lbHeader.text = self.arrHeader[section]
        lbHeader.font = UIFont.boldSystemFont(ofSize: 14)
        
        viewHeader.addSubview(lbHeader)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.getIdentifier(), for: indexPath) as! DetailsCell
        cell.configCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
