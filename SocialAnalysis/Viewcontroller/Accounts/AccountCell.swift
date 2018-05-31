//
//  AccountCell.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

protocol AccountCellDelegate {
    func doConnectClick(tag:Int)
}

class AccountCell: UITableViewCell {
    var delegate:AccountCellDelegate?
    @IBOutlet weak var btnConnect: UIButton!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgAvarta: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnConnect.border(color: nil, radius: 5, width: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(object:AccountObject, index:Int) -> Void {
        self.btnConnect.tag = index
        self.imgAvarta.image = UIImage.init(named: object.icon)
        self.lbName.text = object.name
        if object.status == true{
            self.lbStatus.text = "Connected"
            self.btnConnect.setTitle("Disconnect", for: .normal)
        }else{
            self.lbStatus.text = "No Connect"
            self.btnConnect.setTitle("Connect", for: .normal)
        }
    }
    
    @IBAction func btnConnectClick(_ sender: Any) {
        self.delegate?.doConnectClick(tag: btnConnect.tag)
    }
}
