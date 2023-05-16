import SwiftUI
import CryptoKit

class Auth: ObservableObject {
    
    @AppStorage("signedIn") var signedIn = false

    @Published var user: User?
    @Published var playlists: [Playlist]?
    
    let client = "815d77f6e74645738bf81edb150d456e"
    var codeVerifier: String?
    var url = "https://accounts.spotify.com/authorize?response_type=code&client_id=815d77f6e74645738bf81edb150d456e&scope=user-top-read,user-read-private,user-read-email,user-library-read,user-library-modify,playlist-modify-public,playlist-modify-private&redirect_uri=https://github.com/nathandcarter21&code_challenge_method=S256&code_challenge="
    
    init() {
        guard signedIn == true else {
            return
        }
        if let token = self.getToken(service: "access_token", account: "spotify") {
            getUser(token: token)
        }
    }
    
    func saveToken(data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
        
        SecItemAdd(query, nil)
    }
    
    func getToken(service: String, account: String) -> String? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
        
        var res: AnyObject?
        SecItemCopyMatching(query, &res)
        
        if let res = res as? Data {
            return String(data: res, encoding: .utf8)
        }
        
        return nil
    }
    
    func getUser(token: String) {
        guard let url = URL(string: "https://api.spotify.com/v1/me") else {
            return
        }
        
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
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

                let res = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self?.user = res
                    self?.getPlaylists(token: token)
                }
            }
            catch{
                print("ERROR\(error)")
            }
        }.resume()
    }
    
    func getPlaylists(token: String) {
        
        guard let url = URL(string: "https://api.spotify.com/v1/me/playlists?limit=50") else {
            return
        }
        
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer " + token]
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
                
                let res = try JSONDecoder().decode(UserPlaylistsRes.self, from: data)
                DispatchQueue.main.async {
                    self?.playlists = res.items?.filter { $0.owner.id == self?.user?.id } ?? []
                }
            }
            catch{
                print("ERROR\(error)")
            }
        }.resume()
    }
    
    func createCodeVerifier() -> String {
        self.codeVerifier = generateRandomString(len: 128)
        return makeCodeChallenge(codeVerifier: codeVerifier!)
    }
    
    
    func getAuthURL(codeChallenge: String) -> URL{
        let newUrl = url + codeChallenge
        return URL(string: newUrl)!
    }
    
    func generateRandomString(len: Int) -> String{
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        for _ in 0..<len {
            let randomIndex = Int(arc4random_uniform(UInt32(characters.count)))
            let randomChar = characters[characters.index(characters.startIndex,offsetBy: randomIndex)]
            randomString.append(randomChar)
        }
        
        return randomString
    }
    
    func base64URLEncodedString(
        data:Data,
        options: Data.Base64EncodingOptions = []
    ) -> String {
        return data.base64EncodedString(options: options)
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
    
    func makeCodeChallenge(codeVerifier: String) -> String {
        let data = codeVerifier.data(using: .utf8)!
        let hash = SHA256.hash(data: data)
        let bytes = Data(hash)
        return base64URLEncodedString(data: bytes)
    }
    
    func getAccessToken(code:String){
        let reqHeaders : [String:String] = ["Content-Type": "application/x-www-form-urlencoded"]
        var reqBody = URLComponents()
        reqBody.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://github.com/nathandcarter21"),
            URLQueryItem(name: "client_id", value: client),
            URLQueryItem(name: "code_verifier", value: codeVerifier),
        ]
                
        var req = URLRequest(url:URL(string: "https://accounts.spotify.com/api/token")!)
        req.httpMethod = "POST"
        req.allHTTPHeaderFields = reqHeaders
        req.httpBody = reqBody.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: req){
            [weak self]
            (data,response,error) in
            guard let data = data, error == nil else {
                print("ERROR: \(error!)")
                return
            }
            do {
//                print("JSON")
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//                   if let responseJSON = responseJSON as? [String: Any] {
//                       print(responseJSON)
//                   }
                
                let res = try JSONDecoder().decode(AccessTokenRes.self, from: data)
                
                guard res.access_token != "" else {
                    return
                }
                DispatchQueue.main.async {
//                    self?.token = res.access_token
                    self?.signedIn = true
                    self?.getUser(token: res.access_token)
                    self?.saveToken(data: Data(res.access_token.utf8), service: "access_token", account: "spotify")
                    self?.saveToken(data: Data(res.refresh_token.utf8), service: "refresh_token", account: "spotify")
                }
            }
            catch{
                print("ERROR: \(error)")
            }
        }.resume()
    }
    
    func logOut(){
        DispatchQueue.main.async {
            self.signedIn = false
            //FIXME: CLear token
            self.user = nil
        }
    }
}
