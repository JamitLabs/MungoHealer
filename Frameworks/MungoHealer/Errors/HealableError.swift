//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// A healable (recoverable) & localized error type without the overhead of NSError – truly designed for Swift.
public protocol HealableError: BaseError {
    /// Provides an array of possible healing options to present to the user.
    var healingOptions: [HealingOption] { get }

    /// Attempt to heal (recover) from this error when the user selected the given option.
    func attemptHealing(option: HealingOption, handler: (Bool) -> Void)
}
