import SwiftUI
import AVFoundation

class SongViewModel: ObservableObject {
    
    @Published var songs: [Song] = []
    
    init() {}
    
    init(songs: [Song]) {
        self.songs = songs.reversed()
    }
    
    func getRecommendedSongs(token: String, seeds: [Song], completion: @escaping ((Result<Void, Error>) -> Void)) {
        let base = "https://api.spotify.com/v1/recommendations?limit=50&seed_tracks="
        
        var songIds: [String] = []
        
        for seed in seeds {
            if let id = seed.id {
                songIds.append(id)
            }
        }
        
        let url = base + songIds.joined(separator: ",")
        
        guard let url = URL(string: url) else {
            return
        }
        
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = reqHeaders
        
        
        URLSession.shared.dataTask(with: req) {
            [weak self]
            data, res, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                switch httpResponse.statusCode  {
                    
                case 200:
                    if let data = data {
                        do {
                            let res = try JSONDecoder().decode(RecommendedSongsRes.self, from: data)
                            
                            guard let songs = res.tracks else {
                                completion(.failure(SpotifyError.unknown))
                                return
                            }
                            
                            let songsWithPreview = songs.filter { $0.preview_url != nil}
                                                        
                            DispatchQueue.main.async {
                                self?.songs = songsWithPreview.reversed()
                                completion(.success(()))
                            }
                        }
                        catch {
                            completion(.failure(SpotifyError.unknown))
                        }
                    }
                    else {
                        completion(.failure(SpotifyError.unknown))
                    }
                    
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
            } else {
                completion(.failure(SpotifyError.unknown))
            }
        }.resume()
    }
    
    func loadSongs(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
                        
        guard self.songs.count <= 0 else {
            return
        }
                
        guard let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?limit=5&time_range=short_term") else {
            return
        }
        
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = reqHeaders
        
        URLSession.shared.dataTask(with: req){
            [weak self]
            data, res, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                switch httpResponse.statusCode  {
                    
                case 200:
                    if let data = data {
                        do {
                            let res = try JSONDecoder().decode(TopSongsRes.self, from: data)
                            
                            guard let seedSongs = res.items, res.items?.count == 5 else {
                                completion(.failure(SpotifyError.unknown))
                                return
                            }
                                                        
                            DispatchQueue.main.async {
//                                self?.songs = songsWithPreview?.reversed() ?? []
//                                completion(.success(()))
                                self?.getRecommendedSongs(token: token, seeds: seedSongs, completion: completion)
                            }
                        }
                        catch {
                            completion(.failure(SpotifyError.unknown))
                        }
                    }
                    else {
                        completion(.failure(SpotifyError.unknown))
                    }
                    
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
            } else {
                completion(.failure(SpotifyError.unknown))
            }
        }.resume()
    }
}
