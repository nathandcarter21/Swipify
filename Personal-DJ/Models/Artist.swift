//
//  Artist.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/15/23.
//

import SwiftUI

struct Artist: Hashable, Decodable {
    var href: String?
    var id: String
    var name: String
    var uri: String?
}
