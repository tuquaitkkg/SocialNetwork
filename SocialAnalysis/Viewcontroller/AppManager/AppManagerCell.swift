//
//  AppManagerCell.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

protocol AppManagerCellDelegate:class {
    func clickFavorite(indexPath : IndexPath!, button : UIButton!)
}

class AppManagerCell: UITableViewCell {

    weak var delegate: AppManagerCellDelegate?
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgSocial: UIImageView!
    var indexPath : IndexPath!
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
    @IBAction func clickFavorite(_ sender: Any) {
        let button : UIButton = sender as! UIButton
        delegate?.clickFavorite(indexPath: indexPath, button: button)
    }
    
}
