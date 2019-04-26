//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// A localized error type without the overhead of NSError – truly designed for Swift.
///
/// According to SE-0112 the rationale behind LocalizedError & RecoverableError is basically NSError compatibility.
/// https://github.com/apple/swift-evolution/blob/master/proposals/0112-nserror-bridging.md
public protocol BaseError: Error {
    /// A classification of the errors source.
    var source: ErrorSource { get }

    /// A localized message describing what error occurred.
    var errorDescription: String { get }

    /// A more concise description of the error for debugging purposes.
    var debugDescription: String? { get }
}

extension BaseError {
    var localizedDescription: String {
        return errorDescription
    }

    public var debugDescription: String? { return nil }
}
