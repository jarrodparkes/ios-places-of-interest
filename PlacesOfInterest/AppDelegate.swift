//
//  AppDelegate.swift
//  PlacesOfInterest
//
//  Created by Jarrod Parkes on 1/20/17.
//  Copyright © 2017 Jarrod Parkes. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyDEKNxE2eOhpQN1RJwGGjMdqk2V1TOOfNg")
        return true
    }
}
