//
//  SaveSongReq.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

struct SaveSongReq: Encodable {
    let ids: [String]
}
struct AddSongReq: Encodable {
    let uris: [String]
}
