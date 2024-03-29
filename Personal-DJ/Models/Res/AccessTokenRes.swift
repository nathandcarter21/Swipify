//
//  AccessTokenReq.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct AccessTokenRes: Decodable {
    let access_token: String?
    let token_type: String?
    let expires_in: Int?
    let refresh_token: String?
    let scope: String?
    var error: String?
    var error_description: String?
}
