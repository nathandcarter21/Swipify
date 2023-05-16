//
//  TopSongsRes.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/15/23.
//

import SwiftUI

struct TopSongsRes: Decodable {
    var items: [Song]?
    var total: Int?
    var limit: Int?
    var next: String?
    var error: APIError?
}
