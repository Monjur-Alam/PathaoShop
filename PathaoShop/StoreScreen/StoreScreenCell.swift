//
//  StoreScreenCell.swift
//  PathaoShop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit

class StoreScreenCell: UITableViewCell {
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cartCellView: UIView!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    
    var quantity: Int = 1
    var cart: Store!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        incrementButton.layer.cornerRadius = 6
        incrementButton.clipsToBounds = true
        
        decrementButton.layer.cornerRadius = 6
        decrementButton.clipsToBounds = true
        
        cartCellView.layer.cornerRadius = 6
        cartImageView.layer.cornerRadius = 6
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 1 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        self.quantityLabel.text = String(describing: quantity)
        Store.updateCart(withProduct: cart, forQuantity: quantity)
    }
    
    func configureCell(withCart cart: Store){
        if let name = cart.name{
            self.cart = cart
            let url = URL(string: cart.image ?? "")
            cartImageView.load(url: url!)
            nameLabel.text = cart.name
            priceLabel.text = "Total Price: \(cart.subtotal)"
            quantityLabel.text = "Total count: \(cart.quantity)"
            quantity = Int(cart.quantity)
        }
        
    }

}
