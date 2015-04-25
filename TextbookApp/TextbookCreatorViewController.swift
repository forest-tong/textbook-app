//
//  TextbookCreatorViewController.swift
//  TextbookApp
//
//  Created by Daniel Galvez on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit
import Parse

class TextbookCreatorViewController: UITableViewController {
    
    var course : PFObject!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var editionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSaveButtonTap(sender: AnyObject) {
        let book = Textbook(className: "Textbook")
        book.name = nameTextField.text
        book.edition = (editionTextField.text as NSString).integerValue
        book.price = (priceTextField.text as NSString).doubleValue
        book.condition = conditionTextField.text
        book.notes = notesTextView.text
        book.saveInBackgroundWithBlock(nil)
        
        performSegueWithIdentifier("unwindToMyBooks", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
