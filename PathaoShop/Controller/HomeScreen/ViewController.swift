//
//  ViewController.swift
//  PathaoShop
//
//  Created by MacBook Pro on 22/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartCount: UILabel!
    
    var shopDataModel: [ShopDataModel]?
    var data: [ShopDataModel]?
    
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
        loadJson()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.count = Store.getAllCartItems()
    }
    
    func loadJson() {
        if let url = Bundle.main.url(forResource: "pathao-shop", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                data = try decoder.decode([ShopDataModel].self, from: jsonData)
            } catch {
                print(error)
            }
        }
        shopDataModel = data
        for i in (0 ..< (data?.count ?? 0)) {
            if data?[i].items == nil {
                shopDataModel?.remove(at: i)
            }
        }
    }
    
    func moveToItemList(index: Int) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemListScreenViewController") as? ItemListScreenViewController
        else {
            return
        }
        vc.shopItem = shopDataModel?[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopDataModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopNameCell") as? ShopNameCell else {
            return UITableViewCell()
        }
        cell.shopDataModel = shopDataModel?[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        cell.onClickSeeAllClosure = {index in
            if let index = index {
                self.moveToItemList(index: index)
            }
        }
        return cell
    }
}

extension ViewController: AddToCartDelegate{
    func addedToCart() {
        self.count = Store.getAllCartItems()
    }
}

