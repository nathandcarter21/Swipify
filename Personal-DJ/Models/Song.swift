//
//  Song.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct TopTracksRes: Hashable, Codable {
    var items: [Song]
    var total: Int
    var limit: Int
    var next: String
}

struct Song: Hashable, Codable {
    var id: String
    var href: String
    var name: String
    var popularity: Int
    var preview_url: String
    var uri: String
    var is_local: Bool
    var album: Album
    
    init(id: String, href: String, name: String, popularity: Int, preview_url: String, uri: String, is_local: Bool, album: Album) {
        self.id = id
        self.href = href
        self.name = name
        self.popularity = popularity
        self.preview_url = preview_url
        self.uri = uri
        self.is_local = is_local
        self.album = album
    }
}

struct Album: Hashable, Codable {
    var id: String
    var album_type: String
    var name: String
    var release_date: String
    var release_date_precision: String
    var genres: [String]?
    var images: [AlbumImage]
    var artists: [Artist]
    
    init(id: String, album_type: String, name: String, release_date: String, release_date_precision: String, genres: [String]? = nil, images: [AlbumImage], artists: [Artist]) {
        self.id = id
        self.album_type = album_type
        self.name = name
        self.release_date = release_date
        self.release_date_precision = release_date_precision
        self.genres = genres
        self.images = images
        self.artists = artists
    }
    
    func getImage() -> AlbumImage {
        return images[0]
    }
    
    func getArtist() -> Artist {
        return artists[0]
    }
}

struct Artist: Hashable, Codable {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

struct AlbumImage: Hashable, Codable {
    var height: Int
    var width: Int
    var url: String
 
    init(height: Int, width: Int, url: String){
        self.height = height
        self.width = width
        self.url = url
    }
}

