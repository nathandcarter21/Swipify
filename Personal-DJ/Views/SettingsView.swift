//
//  SettingsView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct SettingsView: View {
    
    var auth: Auth
    @ObservedObject var audio: Audio
            
    var body: some View {

        VStack {
            
            if let user = auth.user {
                
                Button {
                    
                    if let uri = user.uri, let url = URL(string: uri) {
                        
                        UIApplication.shared.open(url)
                        
                    }
                    
                } label: {
                    
                    HStack {
                        
                        Image("Spotify_Icon_Black_Coated")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 20)
                        
                        
                        Spacer()
                        
                        Text(user.email ?? "")
                            .padding(.trailing, 20)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                    }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("Spotify"))
                    .cornerRadius(10)
                    .padding(.top, 50)
                    
                }
                
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                
                NavigationLink(destination: Text("About")) {
                    
                    Text("About")
                        .padding(.leading, 20)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("AppGray"))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                
                
                Divider()
                    .overlay(Color.white)
                
                NavigationLink(destination: Text("Contact")) {
                    
                    Text("Contact")
                        .padding(.leading, 20)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("AppGray"))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                
                Divider()
                    .overlay(Color.white)
                
                NavigationLink(destination: Text("Privacy")) {
                    
                    Text("Privacy")
                        .padding(.leading, 20)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("AppGray"))
                        .foregroundColor(Color.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                }
                
            }
            .cornerRadius(10)
            
            Button(action: {

                audio.stopSound()
                auth.logOut()

            }, label: {
                Text("Log out")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .frame(maxWidth:.infinity)
                    .frame(height: 55)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 75)
            })
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .navigationTitle("Settings")
        .onAppear {
            audio.pauseSound()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(auth: Auth(), audio: Audio())
    }
}
