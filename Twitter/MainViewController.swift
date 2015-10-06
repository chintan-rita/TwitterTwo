//
//  MainViewController.swift
//  Twitter
//
//  Created by Chintan Rita on 9/28/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    
    var tweetsNavigationController: UIViewController!

    @IBAction func onHomeButton(sender: AnyObject) {
        hideMenuView()
        loadHomeView()
    }
    
    
    @IBAction func onProfileButton(sender: AnyObject) {
        loadProfileView()
    }

    @IBAction func onLogoutButton(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func userDidLogin() {
        loadHomeView()
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogin", name: userDidLoginNotification, object: nil)

        super.viewDidLoad()
        loadHomeView()
    }
    
    func loadHomeView() {
        contentView.removeFromSuperview()
        let tweetsNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TweetsNavigationController") as UIViewController
        
        contentView = tweetsNavigationController.view
        tweetsNavigationController.didMoveToParentViewController(self)

        self.view.addSubview(contentView)
        self.addChildViewController(tweetsNavigationController)
        self.view.bringSubviewToFront(contentView)
        
        // Do any additional setup after loading the view.

    }

    func loadProfileView() {
        contentView.removeFromSuperview()

        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileViewController") as!ProfileViewController
        

        contentView = profileViewController.view
        
        self.view.addSubview(contentView)
        self.addChildViewController(profileViewController)
        self.view.bringSubviewToFront(contentView)
        profileViewController.didMoveToParentViewController(self)
        
        profileViewController.setUser(user: User.currentUser!)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hideMenuView() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height)
            self.menuView.frame = CGRectMake( -self.menuView.frame.width, 0, self.menuView.frame.width, self.menuView.frame.height)
        }, completion:nil)
        
    }
    
    
    @IBAction func onPanGesture(sender: AnyObject) {
        let velocity = sender.velocityInView(view)
        if sender.state == UIGestureRecognizerState.Ended {
            if (velocity.x > 0) {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.menuView.frame = CGRectMake(0, 0, self.menuView.frame.width, self.menuView.frame.height)
                    self.contentView.frame = CGRectMake(self.menuView.frame.width, 0, self.contentView.frame.width, self.contentView.frame.height)
                    //self.view.bringSubviewToFront(self.menuView)
                }, completion:nil)
                
            } else {
                self.hideMenuView()
            }
        }
    }

    
}
