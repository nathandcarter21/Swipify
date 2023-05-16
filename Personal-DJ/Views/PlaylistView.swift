//
//  PlaylistView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/14/23.
//

import SwiftUI

struct PlaylistView: View {
    
    var auth: Auth
    var playlistViewModel = PlaylistViewModel()

    @Binding var showPlaylists: Bool
    @Binding var currSong: Song?
    @Binding var showAddedToPlaylistToast: Bool
    
    
    var body: some View {
        
       VStack {
            
            Button {
                showPlaylists.toggle()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            
           if let playlists = auth.playlists {
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVStack(spacing: 5) {
                        
                        ForEach(Array(playlists.enumerated()), id:\.element) { index, playlist in
                            
                            Button {
                                if let token = auth.getToken(service: "access_token", account: "spotify") {
                                    playlistViewModel.addSongToPlaylist(token: token, song: currSong?.uri, playlist: playlist.id)
                                    showPlaylists.toggle()
                                    showAddedToPlaylistToast = true
                                }
                            } label: {
                                
                                HStack {
                                    
                                    AsyncImage(url: URL(string: playlist.images[0].url), content: { returnedImage in
                                        
                                        returnedImage
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                    }, placeholder: {
                                        
                                        ProgressView()
                                            .frame(width: 50, height: 50)
                                            .background(Color("AppGray"))
                                        
                                    })
                                    
                                    Text(playlist.name)
                                    
                                    Spacer()
                                    
                                }
                                .padding(10)
                                .background(Color("AppGray").opacity(0.3))
                                .cornerRadius(10)
                                
                            }
                            .buttonStyle(.plain)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(25)
                    
                }
                
            }
            
            else {
                Text("Could not find playlists")
            }
            Spacer()

        }
    }
    
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        @State var show = true
        @State var toast = false
        @State var currSong: Song? = nil
        PlaylistView(auth: Auth(), showPlaylists: $show, currSong: $currSong, showAddedToPlaylistToast: $toast)
    }
}
