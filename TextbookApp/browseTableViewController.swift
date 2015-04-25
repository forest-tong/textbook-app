//
//  browseTableViewController.swift
//  TextbookApp
//
//  Created by Kevin Gerami on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

class browseTableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = "Course"
        self.textKey = ""
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Course")
        query.includeKey("School")
        
        query.orderByAscending("courseID")
    
        
        
        
        
        return query
    }
   
}
