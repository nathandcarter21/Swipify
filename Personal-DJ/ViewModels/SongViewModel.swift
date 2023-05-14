import SwiftUI
import AVFoundation

class SongViewModel: ObservableObject {
    
    
    @Published var songs: [Song] = []
    
    init() {}
    
    init(songs: [Song]) {
        self.songs = songs.reversed()
    }
    
    func loadSongs(token: String) {
                        
        if self.songs.count > 0{
            return
        }
                
        guard let url = URL(string: "https://api.spotify.com/v1/me/top/tracks?limit=25&time_range=long_term") else {
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
                
                let songsWithPreview = res.items.filter {$0.preview_url != nil}
                
                DispatchQueue.main.async {
                    self?.songs = songsWithPreview.reversed()
                }
            }
            catch{
                print("ERROR\(error)")
            }
        }.resume()
    }
}
