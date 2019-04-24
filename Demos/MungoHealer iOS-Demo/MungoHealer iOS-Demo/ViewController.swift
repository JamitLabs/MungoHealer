//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs. All rights reserved.
//

import MungoHealer
import UIKit

struct MyError: Error {}

struct MyLocalizedError: LocalizedError {
    let errorDescription: String? = "This is a fake localized error message for presenting to the user."
}

struct MyBaseError: BaseError {
    var debugDescription: String?
    
    let errorDescription = "This is a fake base error message for presenting to the user."
    let source = ErrorSource.allCases.randomElement()!
}

struct MyFatalError: FatalError {
    var debugDescription: String?
    
    let errorDescription = "This is a fake fatal error message for presenting to the user."
    let source = ErrorSource.allCases.randomElement()!
}

struct MyHealableError: HealableError {
    var debugDescription: String?
    
    private let retryClosure: () -> Void

    let errorDescription = "This is a fake healable error message for presenting to the user."
    let source = ErrorSource.allCases.randomElement()!

    var healingOptions: [HealingOption] {
        let retryOption = HealingOption(style: .recommended, title: "Try Again", handler: retryClosure)
        let cancelOption = HealingOption(style: .normal, title: "Cancel", handler: {})
        return [retryOption, cancelOption]
    }

    init(retryClosure: @escaping () -> Void) {
        self.retryClosure = retryClosure
    }
}

class ViewController: UIViewController {
    @IBAction func throwErrorButtonPressed() {
        mungo.do {
            throw MyError()
        }
    }

    @IBAction func throwLocalizedErrorButtonPressed() {
        mungo.do {
            throw MyLocalizedError()
        }
    }

    @IBAction func throwBaseErrorButtonPressed() {
        mungo.do {
            throw MyBaseError()
        }
    }

    @IBAction func throwFatalErrorButtonPressed() {
        mungo.do {
            throw MyFatalError()
        }
    }

    @IBAction func throwHealableErrorButtonPressed() {
        mungo.do {
            throw MyHealableError(retryClosure: { [weak self] in self?.throwHealableErrorButtonPressed() })
        }
    }
}

