//
//  ItemListCollectionCell.swift
//  PathaoShop
//
//  Created by MacBook Pro on 25/12/22.
//

import Foundation
import UIKit

protocol AddToCartDelegate: class{
    func addedToCart()
}

class ItemListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var shopItemDesc: UILabel!
    @IBOutlet weak var itemQty: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shopItemNameCellView: UIView!
    
    weak var delegate: AddToCartDelegate?
    var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemQty.layer.cornerRadius = 6.0
        itemQty.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6.0
        shopItemNameCellView.layer.cornerRadius = 6.0
    }
    
    func setItem(with item: Item?) {
        self.item = item
        let url = URL(string: item?.image ?? "")
        imageView.load(url: url!)
        itemName.text = item?.name
        shopItemDesc.text = item?.description
        price.text = String(describing: (item?.price)!)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let i = Int(itemQty.text ?? "0")
        if (sender as! UIButton).tag == 0 {
            if i ?? 0 > 0 {
                itemQty.text = "\((i ?? 0)-1)"
            }
            Store.removeCart(withProduct: self.item)
        } else {
            itemQty.text = "\((i ?? 0)+1)"
            Store.updateCart(withProduct: self.item)
        }
        delegate?.addedToCart()
    }
}
