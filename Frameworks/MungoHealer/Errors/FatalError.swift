//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// A non-healable (non-recoverable) & localized fatal error type without the overhead of NSError – truly designed for Swift.
public protocol FatalError: BaseError {
    var identifier: String { get }
}
