//
//  browseTableViewController.swift
//  TextbookApp
//
//  Created by Kevin Gerami on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

var location = "Cornell"

class browseTableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = "Course"
        self.textKey = "courseID"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Course")
        query.whereKey("school", equalTo: location)
        query.whereKeyExists("textbooks")
        if filter != "" {
            query.whereKey("name", containsString: filter)
        }
        query.orderByAscending("courseID")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("courseCell") as! PFTableViewCell!
        cell.textLabel!.text = object?.valueForKey("courseID") as? String
        cell.detailTextLabel!.text = object?.valueForKey("name") as? String
        
        
        return cell

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "courseSegue" {
            let textbookVC = segue.destinationViewController as! textbooksTableViewController
            textbookVC.courseObject = objectAtIndexPath(tableView.indexPathForSelectedRow()!)
        } 
    }
    

   
}
