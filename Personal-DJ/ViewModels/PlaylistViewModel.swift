//
//  PlaylistViewModel.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

class PlaylistViewModel {
    func addSongToPlaylist(token: String, song: String?, playlist: String?) {
        if let song = song, let playlist = playlist {
            
            guard let url = URL(string: "https://api.spotify.com/v1/playlists/\(playlist)/tracks") else {
                return
            }
            
            let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded",
                                                "Authorization": "Bearer " + token]
            
            let reqBody = AddSongReq(uris: [song])
            
            do {
                
                let jsonBody = try JSONEncoder().encode(reqBody)
                var req = URLRequest(url:url)
                req.httpMethod = "POST"
                req.allHTTPHeaderFields = reqHeaders
                req.httpBody = jsonBody
                
                URLSession.shared.dataTask(with: req){
                    data, res, error in
//                    guard let data = data, error == nil else {
//                        return
//                    }
//                    
//                    print("JSON")
//                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                    if let responseJSON = responseJSON as? [String: Any] {
//                        print(responseJSON)
//                    }
                    
                }.resume()
                
            } catch {
                print(error)
            }
            
        }
    }
}
