//
//  StartTabBarController.swift
//  TextbookApp
//
//  Created by Forest Tong on 4/25/15.
//  Copyright (c) 2015 Forest Tong. All rights reserved.
//

import UIKit

class StartTabBarController: UITabBarController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    func presentLoginViewController() {
        let loginViewController = PFLogInViewController()
        loginViewController.delegate = self
        
        let signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        
        loginViewController.signUpController = signUpViewController
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.currentUser() == nil {
            presentLoginViewController()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription ?? "Unspecified error", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
   
}
