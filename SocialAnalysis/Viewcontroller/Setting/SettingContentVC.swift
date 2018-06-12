//
//  SettingContentVC.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class SettingContentVC: BaseVC {

    var settingObject:SettingObject!
    
    
    @IBOutlet weak var lblContent: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLayout()
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:init
    func initLayout() -> Void {
        self.setupBackButton()
    }
    
    override func doBack() {
        super.doBack()
        self.dismiss(animated: true, completion: nil)
    }
    func initData() -> Void {
        self.setupTitleNavi(title: settingObject.name)
        self.lblContent.text = settingObject.content
    }

}
