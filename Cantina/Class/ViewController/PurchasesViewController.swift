//
//  PurchasesViewController.swift
//  Cantina
//
//  Created by Eduardo Rangel on 8/22/15.
//  Copyright © 2015 Concrete Solutions. All rights reserved.
//

import UIKit
import Google

class PurchasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //////////////////////////////////////////////////////////////////////
    // MARK: - Variables
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var debitLabel: UILabel!
    
    var sales: [Sale] = []
    var debit = 0.0
    
    
    
    //////////////////////////////////////////////////////////////////////
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        CredentialsService.getUser(CredentialStore().get(), completion : { (success, object) -> Void in
            SaleService.getAllByCredential(object!, completion : { (objects, error) -> Void in
                self.sales = objects as! [Sale]
                
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .CurrencyStyle
                formatter.locale = NSLocale(localeIdentifier: "pt_BR")
                
                let totalDebit = self.sales.reduce(0) {$0 + CGFloat($1.product.price)}
                
                self.debitLabel.text = formatter.stringFromNumber(totalDebit)
                
                self.tableView.reloadData()
            })
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //////////////////////////////////////////////////////////////////////
    // MARK: - IBActions
    
    @IBAction func logout(sender: AnyObject) {
        let alertController = UIAlertController(title: "Logout", message: "Já vai?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Não", style: .Cancel) { (action) in
            
        }
        
        let OKAction = UIAlertAction(title: "Sim", style: .Default) { (action) in
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                GIDSignIn.sharedInstance().signOut()
            })
        }
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    
    
    //////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sales.count
    }
    
    
    
    //////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sale = self.sales[indexPath.row]
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "pt_BR")

        if indexPath.row == self.sales.count - 1 {
            let invoiceCell: InvoiceCell = tableView.dequeueReusableCellWithIdentifier("InvoiceCell", forIndexPath: indexPath) as! InvoiceCell

            invoiceCell.invoiceTotal?.text = self.debitLabel.text
//            invoiceCell.invoiceCloseDate?.text = 
            
            return invoiceCell
        }
    
        let purchaseCell: PurchaseCell = tableView.dequeueReusableCellWithIdentifier("PurchaseCell", forIndexPath: indexPath) as! PurchaseCell
        
        purchaseCell.price?.text = formatter.stringFromNumber(sale.product.price)
        purchaseCell.name?.text = sale.product.name
        purchaseCell.purchaseTime?.text = NSDate.hourMinute(sale.createdAt!)
        purchaseCell.purchaseDate?.text = NSDate.dayMonth(sale.createdAt!)
        
        return purchaseCell
    }
    
    
    
    //////////////////////////////////////////////////////////////////////
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    
}