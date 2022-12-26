//
//  StoreScreenViewController.swift
//  PathaoShop
//
//  Created by MacBook Pro on 25/12/22.
//

import UIKit
import CoreData

class StoreScreenViewController: UIViewController, RefreshViews {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cartStateLabel: UILabel!
    
    class func cartViewController() -> StoreScreenViewController{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let cartViewController = storyboard.instantiateViewController(withIdentifier: "StoreScreenViewController") as! StoreScreenViewController
        return cartViewController
    }
    
    let datasource = CartDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = datasource
        self.updateUI()
        datasource.delegate = self
        self.updateUI()
    }
    
    func updateUI(){
        if let count = datasource.fetchedResultsController.fetchedObjects?.count, count == 0{
            cartStateLabel.isHidden = false
            self.tableView.isHidden = true
            totalLabel.isHidden = true
        }else{
            cartStateLabel.isHidden = true
            self.tableView.isHidden = false
            totalLabel.text = "Your total is: BDT \(Store.cartItemsTotal())"
            totalLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        self.updateUI()
    }
    func deleteRows(forindexPath indexPath: IndexPath) {
        self.tableView.reloadData()
        self.updateUI()
    }
}
