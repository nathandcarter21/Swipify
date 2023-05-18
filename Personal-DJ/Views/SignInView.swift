//
//  SignInView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI
import WebKit

struct SignInView: View {
    
    @State var showWebView = false
    
    var auth: Auth
    
    var signInViewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.system(size:24,weight:.semibold, design: .monospaced))
                .fontWeight(.light)
            
            Spacer()
            
            Button(action: {
                showWebView.toggle()
            }, label: {
                
                HStack {
                    
                    Image("Spotify_Icon_Black_Coated")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading, 20)
                    
                    
                    Spacer()
                    
                    Text("Sign in with Spotify")
                        .padding(.trailing, 20)
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color("Spotify"))
                .cornerRadius(10)
                .padding()
                
            })
            .fullScreenCover(isPresented: $showWebView) {
                HStack {
                    Spacer()
                    
                    Button {
                        showWebView.toggle()
                    } label: {
                        Text("Close")
                    }
                }
                .padding(.horizontal)
                WebView(showWebView: $showWebView,
                        auth: auth,signInViewModel: signInViewModel
                )
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    
    @Binding var showWebView: Bool

    @ObservedObject var auth: Auth
    var signInViewModel: SignInViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        let wKWebView = WKWebView()
        wKWebView.navigationDelegate = context.coordinator
        return wKWebView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let codeChallenge = auth.createCodeVerifier()
        let url = auth.getAuthURL(codeChallenge:codeChallenge)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            decisionHandler(.allow)
                        
            if let code = self.parent.signInViewModel.handleUrlChange(url: navigationAction.request.url) {

                guard code != "error" else {
                    DispatchQueue.main.async {
                        self.parent.showWebView = false
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.parent.auth.requestToken(code: code)
                    self.parent.showWebView = false
                }
            }
        }
    }
}
