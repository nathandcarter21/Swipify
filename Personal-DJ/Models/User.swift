//
//  User.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

struct User: Decodable, Hashable {
    var id: String?
    var country: String?
    var display_name: String?
    var email: String?
    var explicit_content: ExplicitContent?
    var images: [SpotifyImage]?
    var product: String?
    var uri: String?
}
