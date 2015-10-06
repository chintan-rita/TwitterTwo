//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Chintan Rita on 10/5/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

protocol UserDetailDelegator {
    func setUser(user u: User)
}



class ProfileViewController: UIViewController, UserDetailDelegator {
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusCount: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var profileBackground: UIImageView!
    
    var user: User!
    
    @IBOutlet weak var profileTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUser(user user: User) {
        self.user = user
        profileBackground.setImageWithURL(NSURL(string: user.profileBannerUrl!))
        profileImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
        
        screenNameLabel.text = "@\(user.screenName!)"
        nameLabel.text = user.name
        followersCount.text = "\(user.followersCount!)"
        followingCount.text = "\(user.following!)"
        statusCount.text = "\(user.tweetCount!)"
    }
    
    func updateConstraints() {
        profileTopConstraint.constant = 80
        bannerTopConstraint.constant = 65
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
