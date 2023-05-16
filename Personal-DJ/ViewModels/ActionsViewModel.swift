//
//  ActionsViewModel.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

class ActionsViewModel {
    
    func saveSongToLibrary(id: String?, token: String?) {
        
        if let id = id, let token = token {
            
            guard let url = URL(string: "https://api.spotify.com/v1/me/tracks") else {
                return
            }
            
            let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
            let reqBody = SaveSongReq(ids: [id])
            
            do {
                let jsonBody = try JSONEncoder().encode(reqBody)
                var req = URLRequest(url:url)
                req.httpMethod = "PUT"
                req.allHTTPHeaderFields = reqHeaders
                req.httpBody = jsonBody
                
                URLSession.shared.dataTask(with: req){
                    data, res, error in
//                    guard let data = data, error == nil else {
//                        return
//                    }
                    
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
    
    func removeSongFromLibrary(id: String?, token: String?) {
        
        if let id = id, let token = token {
            
            guard let url = URL(string: "https://api.spotify.com/v1/me/tracks") else {
                return
            }
            
            let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
            let reqBody = SaveSongReq(ids: [id])
            
            do {
                let jsonBody = try JSONEncoder().encode(reqBody)
                var req = URLRequest(url:url)
                req.httpMethod = "DELETE"
                req.allHTTPHeaderFields = reqHeaders
                req.httpBody = jsonBody
                
                URLSession.shared.dataTask(with: req){
                    data, res, error in
//                    guard let data = data, error == nil else {
//                        return
//                    }
                    
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
