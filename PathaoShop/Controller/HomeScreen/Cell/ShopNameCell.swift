//
//  ShopNameCell.swift
//  PathaoShop
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit

class ShopNameCell: UITableViewCell {
    
    typealias SeeAllClosure = ((_ index: Int?) -> Void)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shopName: UILabel!
    
    weak var delegate: AddToCartDelegate?
    var index: Int?
    var onClickSeeAllClosure: SeeAllClosure?
    
    var shopDataModel: ShopDataModel? {
        didSet {
            shopName.text = shopDataModel?.shop_name
            collectionView.reloadData()
        }
    }
    
    @IBAction func onClickSeeAll(_ sender: Any) {
        onClickSeeAllClosure?(index)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension ShopNameCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopDataModel?.items?.count ?? 0 > 5 ? 5 : shopDataModel?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopItemNameCell", for: indexPath) as? ShopItemNameCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self.delegate
        cell.setItem(with: shopDataModel?.items?[indexPath.row])
        return cell
    }
}
