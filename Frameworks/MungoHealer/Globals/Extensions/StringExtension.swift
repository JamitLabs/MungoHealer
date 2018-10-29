//
//  Created by Niklas Bülow on 23.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

extension String {
    /// - Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
    var isBlank: Bool { return stripped().isEmpty }

    /// - Returns: The string stripped by whitespace and newline characters from beginning and end.
    func stripped() -> String { return trimmingCharacters(in: .whitespacesAndNewlines) }
}
