//
//  Cart+Extension.swift
//  PathaoShop
//
//  Created by MacBook Pro on 26/12/22.
//

import UIKit
import CoreData


extension Store{
    
    class func updateCart(withProduct item: Item){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name LIKE %@", "\(item.name!)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                cart.quantity += 1
                cart.subtotal = (item.price! * cart.quantity)
            }else{
                let cart = Store.init(context: context)
                cart.quantity = 1
                cart.price = item.price!
                cart.image = item.image!
                cart.name = item.name
                cart.subtotal = item.price!
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func removeCart(withProduct item: Item){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name LIKE %@", "\(item.name!)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                if cart.quantity == 1 {
                    context.delete(cart)
                }else{
                    cart.quantity -= 1
                    cart.subtotal = (item.price! * cart.quantity)
                }
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func updateCart(withProduct store: Store, forQuantity quantity:Int){
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name LIKE %@", "\(store.name!)")
        do {
            let result = try context.fetch(fetchRequest)
            if let cart = result.first{
                if quantity == 0 {
                    context.delete(cart)
                }else{
                    cart.quantity = Int64(quantity)
                    cart.subtotal = (store.price * cart.quantity)
                }
            }
            DatabaseManager.saveContext()
        } catch {
            print("Could not fetch cart")
        }
    }
    
    class func getAllCartItems() -> Int {
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.quantity
            }
            return Int(count)
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
    
    class func cartItemsTotal() -> Int{
        let context = DatabaseManager.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let count = result.reduce(0) { (value, item)  in
                value + item.subtotal
            }
            return Int(count)
        } catch {
            print("Could not fetch all cart items")
        }
        return 0
    }
    
    
}
