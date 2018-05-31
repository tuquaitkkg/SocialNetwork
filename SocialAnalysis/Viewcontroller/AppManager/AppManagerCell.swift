//
//  AppManagerCell.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class AppManagerCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgSocial: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func  configCell(object:AppManagerObject) -> Void {
        self.lbName.text = object.name
        self.backgroundColor = UIColor(hexString: object.color)
        self.imgSocial.image = UIImage.init(named: object.icon)
    }
    
}
