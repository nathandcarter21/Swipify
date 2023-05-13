import SwiftUI
import AVFoundation

class SongViewModel: ObservableObject {
    
    var token: String
    
    @Published var songs: [Song] = []
    
    init(token: String) {
        self.token = token
    }
    
    init(songs: [Song]) {
        self.songs = songs.reversed()
        self.token = "123"
    }
    
//    func skipSong() -> String? {
//
//        guard self.songs.count > 1 else {
//            return nil
//        }
//        let url = self.songs[1].preview_url
//
//        DispatchQueue.main.async {
//            self.songs.removeFirst()
//        }
//
//        return url
//    }
    
    func skipSong() -> Bool {
        if self.songs.count == 1 {
            
            DispatchQueue.main.async {
                self.songs.removeLast()
            }
            
            return true
        }
        
        DispatchQueue.main.async {
            self.songs.removeLast()
        }
        
        return false
    }
    
    func loadSongs() {
                        
        if self.songs.count > 0{
            return
        }
                
        guard let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?limit=2&time_range=short_term") else {
            return
        }
        
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded",
                                            "Authorization": "Bearer " + token]

        
        var req = URLRequest(url:url)
        req.httpMethod = "GET"
        req.allHTTPHeaderFields = reqHeaders
        
        URLSession.shared.dataTask(with: req){
            [weak self]
            data, res, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                
//                print("JSON")
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                if let responseJSON = responseJSON as? [String: Any] {
//                    print(responseJSON)
//                }
                
                let res = try JSONDecoder().decode(TopTracksRes.self, from: data)
                DispatchQueue.main.async {
                    self?.songs = res.items.reversed()
                }
            }
            catch{
                print("ERROR\(error)")
            }
        }.resume()
    }
}
