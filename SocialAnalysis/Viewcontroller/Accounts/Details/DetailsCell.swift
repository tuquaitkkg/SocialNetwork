//
//  DetailsCell.swift
//  SocialAnalysis
//
//  Created by DAO VAN UOC on 12/9/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var btnViewFull: UIButton!
    @IBOutlet weak var clvContent: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clvContent.register(UINib(nibName: UserCell.getIdentifier(), bundle: nil), forCellWithReuseIdentifier: UserCell.getIdentifier())
        self.clvContent.delegate = self
        self.clvContent.dataSource = self
        self.btnViewFull.border(color: nil, radius: 5, width: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnViewFullClick(_ sender: Any) {
    }
    
    func configCell() -> Void {
        self.clvContent.reloadData()
    }
}
extension DetailsCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCell.getIdentifier(), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125 , height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
