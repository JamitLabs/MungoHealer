//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs. All rights reserved.
//

import MungoHealer
import UIKit

var mungo: MungoHealer!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureMungoHealer()
        return true
    }

    private func configureMungoHealer() {
        let errorHandler = AlertLogErrorHandler(window: window!, logError: { print("Error: \($0)") })
        mungo = MungoHealer(errorHandler: errorHandler)
    }
}

