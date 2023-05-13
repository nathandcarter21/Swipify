//
//  Home.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var auth : Auth
    @StateObject var audio = Audio()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            SongView(
                //                        song: Song(id: "12345", href: "www.google.com", is_playable: true, name: "notre dame", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
                //                        audio: audio,
                audio:audio,
                token: auth.token
            )
            
            ActionsView()
            
        }
        .navigationBarItems(
            trailing:
                
                HStack {
                    
                    Image(systemName: "line.3.horizontal.decrease.circle")
                    
                    NavigationLink(destination: SettingsView(auth: auth, audio: audio),
                                   label: {
                        Image(systemName: "gear")
                    })
                    .buttonStyle(.plain)
                    
                }
        )
    }
}

struct Home_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView(auth: Auth())
    }
}
