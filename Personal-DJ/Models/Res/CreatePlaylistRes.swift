//
//  CreatePlaylistRes.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/22/23.
//

import SwiftUI

class CreatePlaylistRes: Decodable {
    var id: String?
    var uri: String?
    var error: APIError?
}
