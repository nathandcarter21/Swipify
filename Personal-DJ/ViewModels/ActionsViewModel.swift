//
//  ActionsViewModel.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

class ActionsViewModel {
    
    func saveSongToLibrary(id: String?, token: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        
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
                    
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let httpResponse = res as? HTTPURLResponse {
                        switch httpResponse.statusCode  {
                            
                        case 200:
                            completion(.success(()))
                            
                        case 400:
                            completion(.failure(SpotifyError.badReq))
                            
                        case 401:
                            completion(.failure(SpotifyError.unauthorized))
                            
                        case 403:
                            completion(.failure(SpotifyError.oathError))
                        
                        case 404:
                            completion(.failure(SpotifyError.notFound))
                            
                        case 429:
                            completion(.failure(SpotifyError.rateLimit))
                        
                        default:
                            completion(.failure(SpotifyError.unknown))
                        }
                    }
                    
                }.resume()
                
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func removeSongFromLibrary(id: String?, token: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        
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
                
                URLSession.shared.dataTask(with: req){ data, res, error in
                    
                    if let error = error {
                        completion(.failure(error))
                    }
                    
                    if let httpResponse = res as? HTTPURLResponse {
                        switch httpResponse.statusCode  {
                            
                        case 200:
                            completion(.success(()))
                            
                        case 400:
                            completion(.failure(SpotifyError.badReq))
                            
                        case 401:
                            completion(.failure(SpotifyError.unauthorized))
                            
                        case 403:
                            completion(.failure(SpotifyError.oathError))
                            
                        case 429:
                            completion(.failure(SpotifyError.rateLimit))
                        
                        default:
                            completion(.failure(SpotifyError.unknown))
                        }
                    }
                }.resume()
            } catch {
                print(error)
            }
        }
    }
}
