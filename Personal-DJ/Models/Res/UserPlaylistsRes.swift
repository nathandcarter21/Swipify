//
//  UserPlaylistsRes.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

struct UserPlaylistsRes: Decodable {
    var href: String?
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String?
    var total: Int?
    var items: [Playlist]?
    var error: APIError?
}
