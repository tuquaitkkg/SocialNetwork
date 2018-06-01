//
//  AppManagerVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AppManagerVC: BaseVC {
    fileprivate var listDataApp = [AppManagerObject]()
    @IBOutlet weak var tbvContent: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Init
    func initLayout() -> Void {
        self.setupTitleNavi(title: "App Manager")
        self.tbvContent.register(UINib(nibName: AppManagerCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: AppManagerCell.getIdentifier())
        self.tbvContent.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func initData() -> Void {
        let heroObject = AppManagerObject(name: "Hero Universe", icon: "ic_HeroUniverse", color: "ff1494", url: "http://herouniverse.com/")
        self.listDataApp.append(heroObject)
        
        let skypeObject = AppManagerObject(name: "Skype", icon: "is_Skype", color: "00aff0", url: "https://login.skype.com/login?client_id=578134&redirect_uri=https%3A%2F%2Fweb.skype.com%2F")
        self.listDataApp.append(skypeObject)
        
        let fb = AppManagerObject(name: "Facebook", icon: "ic_Facebook", color: "3b5999", url: "https://www.facebook.com/")
        self.listDataApp.append(fb)
        
        let twitter = AppManagerObject(name: "Twitter", icon: "ic_Twitter-1", color: "00acee", url: "https://twitter.com/")
        self.listDataApp.append(twitter)
        
        let instar = AppManagerObject(name: "Instagram", icon: "ic_Instagram", color: "517fa3", url: "https://www.instagram.com/")
        self.listDataApp.append(instar)
        
        let youtube = AppManagerObject(name: "YouTube", icon: "ic_YouTube", color: "bc0000", url: "https://www.youtube.com/")
        self.listDataApp.append(youtube)
        
        let vine = AppManagerObject(name: "Vine", icon: "ic_Vine", color: "00d09c", url: "https://vine.co/")
        self.listDataApp.append(vine)
        
        let tumblr = AppManagerObject(name: "Tumblr", icon: "ic_Tumblr", color: "324f6d", url: "https://www.tumblr.com/")
        self.listDataApp.append(tumblr)
        
        let reddit = AppManagerObject(name: "Reddit", icon: "ic_Reddit", color: "cde3fb", url: "https://www.reddit.com/")
        self.listDataApp.append(reddit)
        
        let google = AppManagerObject(name: "Google+", icon: "ic_GooglePlus", color: "dd4739", url: "https://plus.google.com/discover")
        self.listDataApp.append(google)
        
        let link = AppManagerObject(name: "Linkedln", icon: "ic_LinkedIn", color: "333333", url: "https://vn.linkedin.com/")
        self.listDataApp.append(link)
        
        let pinter = AppManagerObject(name: "Pinterest", icon: "ic_Pinterest", color: "cb2028", url: "https://www.pinterest.com/")
        self.listDataApp.append(pinter)
        
        let googledriver = AppManagerObject(name: "Google Driver", icon: "ic_GoogleDrive", color: "d6d6d6", url: "https://www.google.com/drive/")
        self.listDataApp.append(googledriver)
    }
}
extension AppManagerVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataApp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppManagerCell.getIdentifier(), for: indexPath) as! AppManagerCell
        cell.accessoryType = .disclosureIndicator
        cell.configCell(object: self.listDataApp[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = AppManagetDetailsVC(nibName: "AppManagetDetailsVC", bundle: nil)
        controller.accManager = self.listDataApp[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}


