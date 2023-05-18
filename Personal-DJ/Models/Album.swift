//
//  Album.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/15/23.
//

import SwiftUI

struct Album: Hashable, Decodable {
    var album_type: String?
    var total_tracks: Int?
    var available_markets: [String]?
    var href: String?
    var id: String
    var images: [SpotifyImage]
    var name: String
    var release_date: String?
    var release_date_precision: String?
    var uri: String
    var genres: [String]?
    var label: String?
    var popularity: Int?
    var artists: [Artist]
}
