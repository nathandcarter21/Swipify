import SwiftUI
import CryptoKit

class Auth: ObservableObject {
    
    @Published var signedIn = false
    
    let client = "815d77f6e74645738bf81edb150d456e"
    
    var token: String = ""
    var codeVerifier: String?
    
    var url = "https://accounts.spotify.com/authorize?response_type=code&client_id=815d77f6e74645738bf81edb150d456e&scope=user-top-read&redirect_uri=https://github.com/nathandcarter21&code_challenge_method=S256&code_challenge="

    
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
    
    func getToken(code:String){
        
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
                
                let res = try JSONDecoder().decode(AccessTokenReq.self, from: data)
                
                guard res.access_token != "" else{
                    return
                }
                DispatchQueue.main.async {
                    self?.token = res.access_token
                    self?.signedIn = true
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
            self.token = ""
        }
    }
}
