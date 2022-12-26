//
//  Cell+Extension.swift
//  PathaoShop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit

extension UITableViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
    }
}
