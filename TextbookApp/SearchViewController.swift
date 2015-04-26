//
//  SearchViewController.swift
//  TextbookApp
//
//  Created by Kevin Gerami on 4/26/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

var filter = ""


class SearchViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var tableViewController : browseTableViewController!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        //self.performSegueWithIdentifier("toSearchDelegate", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filter = searchBar.text
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        filter = searchBar.text

    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        filter = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filter = searchText
        tableViewController.queryForTable()
        tableViewController.tableView.reloadData()
        tableViewController.loadObjects()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSearchDelegate" {
            let filterVC = segue.destinationViewController as! browseTableViewController
            self.tableViewController = filterVC
        }
    }
}
