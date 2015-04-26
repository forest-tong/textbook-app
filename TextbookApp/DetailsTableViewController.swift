//
//  DetailsTableViewController.swift
//  TextbookApp
//
//  Created by Kevin Gerami on 4/26/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    var textbook: PFObject!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var editionTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var conditionTF: UITextField!
    @IBOutlet weak var notesTV: UITextView!
    @IBAction func contactButtonTap(sender: AnyObject) {
        
        // comment so Daniel can get this!!!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameTF.delegate = self
        editionTF.delegate = self
        priceTF.delegate = self
        conditionTF.delegate = self
        notesTV.delegate = self
        
        nameTF.text = textbook.valueForKey("name") as! String
        editionTF.text = String(stringInterpolationSegment: textbook.valueForKey("edition")!)
        priceTF.text = String(stringInterpolationSegment: textbook.valueForKey("price")!)
        conditionTF.text = textbook.valueForKey("condition") as! String
        notesTV.text = textbook.valueForKey("notes") as! String
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
