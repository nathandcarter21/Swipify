//
//  CurrentUserRes.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

struct CurrentUserRes: Decodable, Hashable {
    var id: String?
    var country: String?
    var display_name: String?
    var email: String?
    var explicit_content: ExplicitContent?
    var images: [ProfileImage]?
    var product: String?
    var uri: String?
}

struct ExplicitContent: Decodable, Hashable {
    var filter_enabled: Bool?
    var filter_locked: Bool?
}

struct ProfileImage: Decodable, Hashable {
    var url: String?
    var height: Int?
    var width: Int?
}
