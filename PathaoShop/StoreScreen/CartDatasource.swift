//
//  CartDatasource.swift
//  PathaoShop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit
import CoreData

protocol RefreshViews:class {
    func deleteRows(forindexPath indexPath:IndexPath)
    func updateRows(forindexPath indexPath:IndexPath)
}


class CartDatasource:NSObject,  UITableViewDataSource {

    var _fetchedResultsController: NSFetchedResultsController<Store>? = nil
    var managedObjectContext :NSManagedObjectContext = DatabaseManager.persistentContainer.viewContext
    
    weak var delegate:RefreshViews?
    
    var fetchedResultsController: NSFetchedResultsController<Store>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreScreenCell.reuseIdentifier, for: indexPath) as! StoreScreenCell
        let cart = self.fetchedResultsController.object(at: indexPath)
        cell.configureCell(withCart: cart)
        return cell
    }
}


extension CartDatasource:NSFetchedResultsControllerDelegate{
     
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete: delegate?.deleteRows(forindexPath: indexPath!)
        case .update: delegate?.updateRows(forindexPath: indexPath!)
        default:
            break
        }
    }
}
