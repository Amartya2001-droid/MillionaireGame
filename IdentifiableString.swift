//
//  IdentifiableString.swift
//  MillionaireGame
//
//  Created by Amartya Karmakar on 2024-07-08.
//

import Foundation

struct IdentifiableString: Identifiable {
    let id = UUID()
    let value: String
}
