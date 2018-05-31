//
//  SettingCell.swift
//  SecretSanta
//
//  Created by DAO VAN UOC on 11/26/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCell(object:SettingObject) -> Void {
        self.lbTitle.text = object.name
    }
}
