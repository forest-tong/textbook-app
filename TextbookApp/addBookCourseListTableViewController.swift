//
//  addBookCourseListTableViewController.swift
//  TextbookApp
//
//  Created by Kevin Gerami on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

class AddBookCourseListTableViewController: PFQueryTableViewController {
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = "Course"
        self.textKey = "courseID"
        self.pullToRefreshEnabled = false
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Course")
        query.whereKey("school", equalTo: location)
        query.orderByAscending("courseID")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("addBookCourseCell") as! PFTableViewCell!
        cell.textLabel!.text = object?.valueForKey("courseID") as? String
        cell.detailTextLabel!.text = object?.valueForKey("name") as? String
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addBookSegue" {
            let addBookVC = segue.destinationViewController as! TextbookCreatorViewController
            addBookVC.course = objectAtIndexPath(tableView.indexPathForSelectedRow()!)
        }
    }
   
}
