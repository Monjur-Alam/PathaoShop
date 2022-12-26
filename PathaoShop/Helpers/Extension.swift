//
//  Extension.swift
//  PathaoShop
//
//  Created by MacBook Pro on 25/12/22.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIViewController{
    @IBAction func pushBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openCart(_ sender: Any) {
        self.navigationController?.pushViewController(StoreScreenViewController.cartViewController(), animated: true)
    }
}
