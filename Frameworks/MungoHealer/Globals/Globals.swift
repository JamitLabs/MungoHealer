//
//  Globals.swift
//  MungoHealer
//
//  Created by Cihat Gündüz on 15.10.18.
//  Copyright © 2018 Jamit Labs GmbH. All rights reserved.
//

import Foundation

func LocalizedString(_ key: String) -> String { // swiftlint:disable:this identifier_name
    return NSLocalizedString(key, tableName: nil, bundle: Bundle(for: MungoHealer.self), value: "", comment: "")
}
