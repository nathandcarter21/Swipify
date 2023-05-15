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
    var images: [ProfileImage]?
    var product: String?
    var uri: String?
    var playlists: [Playlist]?
    
    init(id: String? = nil, country: String? = nil, display_name: String? = nil, email: String? = nil, explicit_content: ExplicitContent? = nil, images: [ProfileImage]? = nil, product: String? = nil, uri: String? = nil) {
        self.id = id
        self.country = country
        self.display_name = display_name
        self.email = email
        self.explicit_content = explicit_content
        self.images = images
        self.product = product
        self.uri = uri
    }
}

struct Playlist: Decodable, Hashable {
    var id: String
    var name: String
    var owner: User
    var images: [AlbumImage]
}
