//
//  User.swift
//  Twitter
//
//  Created by Chintan Rita on 9/28/15.
//  Copyright © 2015 Chintan Rita. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagLine: String?
    var dictionary: NSDictionary
    var profileBannerUrl: String?
    var idNumber: Int?
    var descriptionText: String?
    var followersCount: Int?
    var following: Int?
    var tweetCount: Int?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        idNumber = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagLine = dictionary["description"] as? String
        profileBannerUrl = dictionary["profile_banner_url"] as? String
        profileBannerUrl?.appendContentsOf("/300x100")
        descriptionText = dictionary["description"] as? String
        followersCount = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().dataForKey(currentUserKey)
                if data != nil {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                let data = try! NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: NSJSONWritingOptions())
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: nil)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
