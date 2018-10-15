//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// A general classification between different sources for runtime errors.
public enum ErrorSource: CaseIterable {
    case invalidUserInput
    case internalInconsistency
    case externalSystemUnavailable
    case externalSystemBehavedUnexpectedly
}
