//
//  Playlist.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/15/23.
//

import SwiftUI

struct Playlist: Hashable, Decodable {
    var href: String?
    var id: String
    var name: String
    var owner: User
    var images: [SpotifyImage]
    var uri: String
}
