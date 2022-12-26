//
//  ShopItemNameCell.swift
//  PathaoShop
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit

class ShopItemNameCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var shopItemQty: UILabel!
    @IBOutlet weak var shopItemNameCellView: UIView!
    
    weak var delegate: AddToCartDelegate?
    var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 6.0
        shopItemQty.layer.cornerRadius = 6.0
        shopItemQty.layer.masksToBounds = true
        shopItemNameCellView.layer.cornerRadius = 6.0
    }
    
    func setItem(with item: Item?) {
        self.item = item
        let url = URL(string: item?.image ?? "")
        imageView.load(url: url!)
        itemName.text = item?.name
        desc.text = item?.description
        price.text = String(describing: (item?.price)!)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let i = Int(shopItemQty.text ?? "0")
        if (sender as! UIButton).tag == 0 {
            if i ?? 0 > 0 {
                shopItemQty.text = "\((i ?? 0)-1)"
            }
            Store.removeCart(withProduct: self.item)
        } else {
            shopItemQty.text = "\((i ?? 0)+1)"
            Store.updateCart(withProduct: self.item)
        }
        delegate?.addedToCart()
    }
    
}
