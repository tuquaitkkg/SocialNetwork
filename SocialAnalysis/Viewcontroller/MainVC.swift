//
//  MainVC.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.createTabViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Method
    func creatTabbarItemWithTitle(title:String, image:UIImage, imageSelected:UIImage) -> UITabBarItem {
        let img = image.withRenderingMode(.alwaysOriginal)
        let imgSelected = imageSelected.withRenderingMode(.alwaysOriginal)
        return UITabBarItem(title: title, image: img, selectedImage: imgSelected)
    }
    
    func createTabViews() -> Void {
//        self.tabBar.barTintColor = COLOR.TABBAR_COLOR
        
        let naviMyTone = UINavigationController(rootViewController: AccountsVC(nibName: "AccountsVC", bundle: nil))
        naviMyTone.navigationBar.setBackgroundImage(nil, for: .default)
        naviMyTone.tabBarItem = self.creatTabbarItemWithTitle(title: "Account", image: UIImage.init(named: "ic_UnAccount")!, imageSelected: UIImage.init(named: "ic_Account")!)
        naviMyTone.navigationBar.barStyle = .default
        
        let naviHowToUse = UINavigationController(rootViewController: AppManagerVC(nibName: "AppManagerVC", bundle: nil))
        naviHowToUse.navigationBar.setBackgroundImage(nil, for: .default)
        naviHowToUse.tabBarItem = self.creatTabbarItemWithTitle(title: "App Manager", image: UIImage.init(named: "ic_UnAccManager")!, imageSelected: UIImage.init(named: "ic_AccManager")!)
        naviHowToUse.navigationBar.barStyle = .default
        
        let naviSetting = UINavigationController(rootViewController: SettingVC(nibName: "SettingVC", bundle: nil))
        naviSetting.navigationBar.setBackgroundImage(nil, for: .default)
        naviSetting.tabBarItem = self.creatTabbarItemWithTitle(title: "Setting", image: UIImage.init(named: "ic_UnSetting")!, imageSelected: UIImage.init(named: "ic_Setting")!)
        naviSetting.navigationBar.barStyle = .default
        
        self.viewControllers = [naviHowToUse,naviSetting]
        self.selectedViewController = naviHowToUse
    }
    
    func setupUI() -> Void {
        let titleNormalColor = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:titleNormalColor, NSAttributedStringKey.font:UIFont.systemFont(ofSize: 11)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:COLOR.APP_COLOR, NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 11)], for: .selected)
    }
}
