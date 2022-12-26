//
//  ItemListScreenViewController.swift
//  PathaoShop
//
//  Created by MacBook Pro on 25/12/22.
//

import UIKit
import CoreData

class ItemListScreenViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    
    var shopItem: ShopDataModel?
    
    var count: Int!{
        didSet{
            if count > 0 {
                cartCount.isHidden = false
                cartCount.text = "\(count ?? 0)"
            } else {
                cartCount.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopName.text = shopItem?.shop_name
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.count = Store.getAllCartItems()
    }
}

extension ItemListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (deviceWidth/2) - 10, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopItem?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemListCollectionCell", for: indexPath) as? ItemListCollectionCell else {
            return UICollectionViewCell()
        }
        cell.setItem(with: shopItem?.items?[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension ItemListScreenViewController: AddToCartDelegate{
    func addedToCart() {
        self.count = Store.getAllCartItems()
    }
}
