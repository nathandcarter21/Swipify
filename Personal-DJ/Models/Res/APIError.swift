//
//  APIError.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/15/23.
//

import SwiftUI

class APIError: Decodable {
    var status: Int?
    var message: String?
}
