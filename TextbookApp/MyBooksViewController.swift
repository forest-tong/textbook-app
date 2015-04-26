//
//  MyBooksViewController.swift
//  TextbookApp
//
//  Created by Daniel Galvez on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit
import Parse

class MyBooksViewController: UITableViewController {
    
    var books = [Textbook]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBooks()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchBooks()
        tableView.reloadData()
    }
    
    @IBAction func didPressAddButton(sender: AnyObject) {
        performSegueWithIdentifier("toCourseViewSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textBookCell", forIndexPath: indexPath) as! UITableViewCell
        
        let book = books[indexPath.row]
        book.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            if let obj = object {
            let book = obj as! Textbook
            cell.textLabel!.text = book.name
            cell.detailTextLabel!.text = NSString(format:"%.2f" ,book.price) as String
            }

            
        }
        // Configure the cell...

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let courseName = books[indexPath.row].valueForKey("course") as! String
            var query = PFQuery(className: "Course")
            query.whereKey("name", equalTo: courseName)
            query.includeKey("textbooks")
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if error == nil {
                   let obj = objects!.first as! PFObject
                    /*
                    var badArray = obj.valueForKey("textbooks") as! [PFObject]!
                    var goodArray = [PFObject]()
                    for book in badArray {
                        if book != self.books[indexPath.row] {
                            goodArray.append(book)
                        }
                    }
                    */
                    
                    /*
                    if goodArray.count == 0 {
                        obj.setValue(nil, forKey: "textbooks")
                    } else {
                        obj.setValue(goodArray, forKey: "textbooks")
                    }
                    */
                    
                    /*
                    var badBooks = PFUser.currentUser()!.valueForKey("textbooks") as! [PFObject]
                    var goodBooks = [PFObject]()
                    for book in badBooks {
                        if book != self.books[indexPath.row] {
                            goodBooks.append(book)
                        }
                    }*/
                    
                    
                    
                    let deletedBook = self.books.removeAtIndex(indexPath.row)
                    obj.removeObject(deletedBook, forKey: "textbooks")
                    obj.save()
                    
                    PFUser.currentUser()!.removeObject(deletedBook, forKey: "textbooks")
                    PFUser.currentUser()!.save()

                    deletedBook.delete()
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    })
                }
            }
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: - Parse
    
    func fetchBooks() {
        let user = PFUser.currentUser()!
        user.fetchIfNeeded()
        if user["textbooks"] != nil {
            self.books = user["textbooks"] as! [Textbook]
        	self.tableView.reloadData()
        }
        /*
        let booksForSaleRelation = user.relationForKey("textbooks")
        let query = booksForSaleRelation.query()!
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let books = objects as? [Textbook] {
                self.books = books
                self.tableView.reloadData()
            }
        }
        */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToMyBooks(segue: UIStoryboardSegue) {
        
    }

}
