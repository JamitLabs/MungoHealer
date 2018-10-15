//
//  Created by Cihat Gündüz on 27.06.17.
//  Copyright © 2017 Jamit Labs GmbH. All rights reserved.
//

import Foundation

/// The main error handler.
public class MungoHealer {
    private let errorHandler: ErrorHandler

    /// Creates a new MungoHealer object with the given handlers.
    ///
    /// - Parameters:
    ///   - defaultHandler: The code to be run for all "normal" Error types.
    ///   - baseHandler: The code to be run for all BaseError types.
    ///   - fatalHandler: The code to be run for all FatalError types.
    ///   - healableHandler: The code to be run for all HealableError types.
    public init(errorHandler: ErrorHandler) {
        self.errorHandler = errorHandler
    }

    /// Handles the error according to its type.
    ///
    /// - Parameter error: The error object.
    public func handle(_ error: Error) {
        switch error {
        case let healableError as HealableError:
            errorHandler.handle(healableError: healableError)

        case let fatalError as FatalError:
            errorHandler.handle(fatalError: fatalError)

        case let baseError as BaseError:
            errorHandler.handle(baseError: baseError)

        default:
            errorHandler.handle(error: error)
        }
    }
}
