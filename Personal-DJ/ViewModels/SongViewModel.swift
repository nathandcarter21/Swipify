import SwiftUI
import AVFoundation

class SongViewModel: ObservableObject {
    
    @Published var songs: [Song] = []
    
    init() {}
    
    init(songs: [Song]) {
        self.songs = songs.reversed()
    }
    
    func rightSwipeSong(token: String, song: String?, playlists: [Playlist]?, user: User?, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        guard let song = song, let user = user else {
            completion(.failure(SpotifyError.unknown))
            return
        }
        
        if let playlists = playlists {
                        
            for playlist in playlists {
                if playlist.name == "Swipify" {
                    addSongToPlaylist(token: token, song: song, playlist: playlist.id, newPlaylist: false, completion: completion) 
                    return
                }
            }
        }
        
        createPlaylist(token: token, song: song, user: user.id, completion: completion)
    }
    
    func createPlaylist(token: String, song: String, user: String?, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        guard let user = user else {
            completion(.failure(SpotifyError.unknown))
            return
        }
        
        guard let url = URL(string: "https://api.spotify.com/v1/users/\(user)/playlists") else {
            completion(.failure(SpotifyError.unknown))
            return
        }
        
        let reqHeaders : [String: String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
        let reqBody = CreatePlaylistReq()
        
        do {
            let jsonBody = try JSONEncoder().encode(reqBody)
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.allHTTPHeaderFields = reqHeaders
            req.httpBody = jsonBody
            
            URLSession.shared.dataTask(with: req){ [self]
                data, res, error in
                if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = res as? HTTPURLResponse, let data = data {
                switch httpResponse.statusCode  {
                    
                case 201:
                    do {
                        let res = try JSONDecoder().decode(CreatePlaylistRes.self, from: data)
                        if let error = res.error {
                            print(error)
                            completion(.failure(SpotifyError.unknown))
                        }
                        if let playlistID = res.id {
                            self.addSongToPlaylist(token: token, song: song, playlist: playlistID, newPlaylist: true, completion: completion)
                        } else {
                            completion(.failure(SpotifyError.unknown))
                        }
                    } catch {
                        completion(.failure(error))
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
            }
                
            }.resume()
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func addSongToPlaylist(token: String, song: String?, playlist: String?, newPlaylist: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        if let song = song, let playlist = playlist {
            
            guard let url = URL(string: "https://api.spotify.com/v1/playlists/\(playlist)/tracks") else {
                completion(.failure(SpotifyError.unknown))
                return
            }
            
            let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
            let reqBody = AddSongReq(uris: [song])
            
            do {
                let jsonBody = try JSONEncoder().encode(reqBody)
                var req = URLRequest(url:url)
                req.httpMethod = "POST"
                req.allHTTPHeaderFields = reqHeaders
                req.httpBody = jsonBody
                
                URLSession.shared.dataTask(with: req){
                    data, res, error in
                    if let error = error {
                    completion(.failure(error))
                }
                
                if let httpResponse = res as? HTTPURLResponse {
                    switch httpResponse.statusCode  {
                        
                    case 201:
                        completion(.success(newPlaylist))
                        
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
