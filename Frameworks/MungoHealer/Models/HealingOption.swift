//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// A possible healing (recovery) option.
public struct HealingOption {
    /// The style of an option to be considered when presenting it to the user.
    public enum Style {
        case normal
        case recommended
        case destructive
    }

    /// The style of the healing option.
    public let style: Style

    /// The title of the healing option.
    public let title: String

    /// The code to be executed when the user chooses the healing option.
    public let handler: () -> Void
}
