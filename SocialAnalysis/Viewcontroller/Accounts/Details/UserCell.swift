//
//  UserCell.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {


    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgAvatar.border(color: nil, radius: self.imgAvatar.frame.width/2, width: 0)
        self.lbName.border(color: UIColor.black, radius: 8, width: 1)
        self.lbName.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }

}
