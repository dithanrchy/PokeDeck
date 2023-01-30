//
//  AppDelegate.swift
//  PokeDeck
//
//  Created by Ditha Nurcahya Avianty on 21/01/23.
//

import UIKit
import SDWebImageSVGNativeCoder

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let SVGCoder = SDImageSVGNativeCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)

        return true
    }
}

