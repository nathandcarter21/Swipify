//
//  Song.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct Song: Hashable, Decodable {
    var album: Album
    var artists: [Artist]
    var available_markets: [String]?
    var explicit: Bool?
    var href: String?
    var id: String?
    var is_playable: Bool?
    var name: String
    var popularity: Int?
    var preview_url: String?
    var uri: String
    var is_local: Bool?
}
