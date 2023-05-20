//
//  RecommendedSongsRes.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/19/23.
//

import SwiftUI

class RecommendedSongsRes: Decodable {
    var tracks: [Song]?
    var error: APIError?
}
