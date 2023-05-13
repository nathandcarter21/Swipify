import SwiftUI
import CryptoKit
import Foundation

class SignInViewModel {
    
    let urlToMatch = "https://github.com"
    
    func handleUrlChange(url: URL?) -> String? {
        if let urlString = url?.absoluteString {
            
            guard urlString.count > 18 else {
                return nil
            }
            
            let startIndex = urlString.index(urlString.startIndex, offsetBy: 0)
            let endIndex = urlString.index(urlString.startIndex, offsetBy: 18)
            let substring = urlString[startIndex..<endIndex]
            
            if substring == urlToMatch {
                
                var components: NSURLComponents? = nil
                let linkUrl = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                if let linkUrl = linkUrl {
                    components = NSURLComponents(url: linkUrl, resolvingAgainstBaseURL: true)
                }
                
                var queryItems: [String : String] = [:]
                for item in components?.queryItems ?? [] {
                    queryItems[item.name] = item.value?.removingPercentEncoding
                }
                
                if queryItems["error"] != nil {
                    return "error"
                }
                
                return queryItems["code"]
            }
        }
        return nil
    }
}
