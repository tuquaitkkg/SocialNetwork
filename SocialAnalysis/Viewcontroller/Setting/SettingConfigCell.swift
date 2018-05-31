//
//  SettingConfigCell.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class SettingConfigCell: UITableViewCell {

    @IBOutlet weak var swValue: UISwitch!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        swValue.onTintColor = COLOR.APP_COLOR
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(object:SettingObject) -> Void {
        self.lbTitle.text = object.name
        self.swValue.isOn = object.value!
    }
    
    @IBAction func swChange(_ sender: Any) {
//        DataLocal.sharedInstance.setShowSnow(isShow: !swValue.isOn)
//        XAppDelegate.addSnow(isShow: !swValue.isOn)
    }
}
