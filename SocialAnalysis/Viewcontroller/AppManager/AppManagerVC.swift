//
//  AppManagerVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AppManagerVC: BaseVC,AppManagerCellDelegate {
    fileprivate var listDataApp = [AppManagerObject]()
    fileprivate var listDataFavorite = [AppManagerObject]()
    @IBOutlet weak var tbvContent: UITableView!
    var segment: UISegmentedControl! = nil
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    //MARK: Init
    func initLayout() -> Void {
        segment = UISegmentedControl(items: ["Appkeys", "Favorites"])
        segment.sizeToFit()
        segment.setWidth(100, forSegmentAt: 0)
        segment.setWidth(100, forSegmentAt: 1)
        segment.tintColor = UIColor.white
        segment.selectedSegmentIndex = 0;
        segment.setTitleTextAttributes([kCTFontAttributeName: UIFont.systemFont(ofSize: 16)],
                                       for: UIControlState.normal)
        segment.addTarget(self, action: #selector(mapTypeChanged), for: .valueChanged)
        self.navigationItem.titleView = segment
        
        
        self.setupTitleNavi(title: "App Manager")
        self.tbvContent.register(UINib(nibName: AppManagerCell.getIdentifier(), bundle: nil), forCellReuseIdentifier: AppManagerCell.getIdentifier())
        self.tbvContent.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "ic_UnSetting")!, style: .done, target: self, action: #selector(goToSetting))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = kAdmobBanner
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    @IBAction func mapTypeChanged(segControl: UISegmentedControl) {
        self.tbvContent.reloadData()
    }
    
    @IBAction func goToSetting() {
        let settingVC = SettingVC(nibName: "SettingVC", bundle: nil)
        self.navigationController?.pushViewController(settingVC, animated: true)
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
        
        let link = AppManagerObject(name: "Linkedln", icon: "ic_LinkedIn", color: "#127cb3", url: "https://vn.linkedin.com/")
        self.listDataApp.append(link)
        
        let pinter = AppManagerObject(name: "Pinterest", icon: "ic_Pinterest", color: "cb2028", url: "https://www.pinterest.com/")
        self.listDataApp.append(pinter)
        
        let googledriver = AppManagerObject(name: "Google Driver", icon: "ic_GoogleDrive", color: "d6d6d6", url: "https://www.google.com/drive/")
        self.listDataApp.append(googledriver)
        
        let badoo = AppManagerObject(name: "Badoo", icon: "badoon", color: "6f20e0", url: "https://badoo.com/signin")
        self.listDataApp.append(badoo)
        
        let meetup = AppManagerObject(name: "Meetup", icon: "Meetup", color: "#e82245", url: "https://secure.meetup.com/login/")
        self.listDataApp.append(meetup)
        
        let snapchat = AppManagerObject(name: "Snapchat", icon: "snapchat", color: "#fee834", url: "https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fwelcome")
        self.listDataApp.append(snapchat)
        
        let flickr = AppManagerObject(name: "Flickr", icon: "flickr", color: "#008000", url: "https://www.flickr.com/signin")
        self.listDataApp.append(flickr)
        
        let viber = AppManagerObject(name: "Viber", icon: "viber", color: "#6e43a8", url: "https://account.viber.com/en/login")
        self.listDataApp.append(viber)
        
        let yahoo = AppManagerObject(name: "Yahoo", icon: "Yahoo", color: "#5419bc", url: "https://login.yahoo.com/config/login?.src=fpctx&.intl=vn&.lang=vi-VN&.done=https%3A%2F%2Fvn.yahoo.com")
        self.listDataApp.append(yahoo)
        
        let messager = AppManagerObject(name: "Messager", icon: "Messager", color: "#1788fd", url: "https://www.messenger.com/login/")
        self.listDataApp.append(messager)
        
        let kik = AppManagerObject(name: "Kik", icon: "Kik", color: "#333333", url: "https://kikusernames.com/login")
        self.listDataApp.append(kik)
        
        let gmail = AppManagerObject(name: "Gmail", icon: "gmail", color: "d6d6d6", url: "https://mail.google.com/")
        self.listDataApp.append(gmail)
        
        let taggedn = AppManagerObject(name: "Tagged", icon: "taggedn", color: "333333", url: "https://m.tagged.com/login")
        self.listDataApp.append(taggedn)
        
        let pofn = AppManagerObject(name: "Pof", icon: "pofn", color: "d6d6d6", url: "https://www.pof.com/inbox.aspx")
        self.listDataApp.append(pofn)
        
        let okcn = AppManagerObject(name: "Okc", icon: "okcn", color: "2cbda5", url: "https://www.okcupid.com/login")
        self.listDataApp.append(okcn)
        
        let digg = AppManagerObject(name: "Digg", icon: "Digg", color: "ff1494", url: "http://digg.com/register")
        self.listDataApp.append(digg)
        
        let xing = AppManagerObject(name: "Xing", icon: "icons8-xing-96", color: "00aff0", url: "https://login.xing.com/")
        self.listDataApp.append(xing)
        
        let match = AppManagerObject(name: "Match", icon: "match.com_", color: "1574bb", url: "https://www.match.com/login/")
        self.listDataApp.append(match)
        
        let mylife = AppManagerObject(name: "Mylife", icon: "mylife", color: "39aa51", url: "https://www.mylife.com/site/login.pubview")
        self.listDataApp.append(mylife)
        
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "favorite") != nil) {
            let decoded  = userDefaults.object(forKey: "favorite") as! Data
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Favorites
            listDataFavorite = decodedTeams.array
        }
        
        print("")
    }
}
extension AppManagerVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return self.listDataApp.count
        } else {
            return self.listDataFavorite.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppManagerCell.getIdentifier(), for: indexPath) as! AppManagerCell
        cell.delegate = self
        cell.indexPath = indexPath
        if segment.selectedSegmentIndex == 0 {
            let object : AppManagerObject = self.listDataApp[indexPath.row]
            let filtered_list = listDataFavorite.filter({$0.name == object.name})
            if filtered_list.count > 0 {
                cell.btnFavorite.isSelected = true
            } else {
                cell.btnFavorite.isSelected = false
            }
            cell.configCell(object: object)
        } else {
            cell.btnFavorite.isSelected = true
            cell.configCell(object: self.listDataFavorite[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = AppManagetDetailsVC(nibName: "AppManagetDetailsVC", bundle: nil)
        if segment.selectedSegmentIndex == 0 {
            controller.accManager = self.listDataApp[indexPath.row]
        } else {
            controller.accManager = self.listDataFavorite[indexPath.row]
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func clickFavorite(indexPath : IndexPath!, button : UIButton!) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            listDataFavorite.append(self.listDataApp[indexPath.row])
        } else {
            var object : AppManagerObject!
            if segment.selectedSegmentIndex == 0 {
                object = self.listDataApp[indexPath.row]
            } else {
                object = self.listDataFavorite[indexPath.row]
            }
            
            let filtered_list = listDataFavorite.filter({$0.name == object.name})
            let index : Int = listDataFavorite.index(of: filtered_list.first!)!
            
            listDataFavorite.remove(at: index)
        }
        let array : Favorites = Favorites(array: self.listDataFavorite)
        array.save()
        tbvContent.reloadData()
    }
    
}


