//
//  Error.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/18/23.
//

import SwiftUI

enum SpotifyError: Error {
    case unauthorized
    case badReq
    case oathError
    case notFound
    case rateLimit
    case unknown
}
