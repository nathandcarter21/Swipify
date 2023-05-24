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
    @Binding var playlistName: String
    
    @Binding var showError: Bool
    @Binding var errorMessage: String
    @Binding var authError: Bool
    
    
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
                                Task {
                                    guard let token = await auth.getAccessToken() else {
                                        errorMessage = "Could not validate your auth token. Please log back in."
                                        showError = true
                                        authError = true
                                        return
                                    }
                                    playlistViewModel.addSongToPlaylist(token: token, song: currSong?.uri, playlist: playlist.id) { res in
                                        switch res {
                                            
                                        case .success():
                                            withAnimation {
                                                showPlaylists.toggle()
                                                playlistName = playlist.name
                                                showAddedToPlaylistToast = true
                                            }
                                            
                                        case .failure(let error):
                                            print(error)
                                            showPlaylists.toggle()
                                            switch error {
                                                
                                            case SpotifyError.unauthorized:
                                                errorMessage = "Error authorizing your account. Please log back in"
                                                showError = true
                                                authError = true
                                                
                                            case SpotifyError.badReq:
                                                errorMessage = "Invalid Request"
                                                showError = true
                                                
                                            case SpotifyError.oathError:
                                                errorMessage = "OATH2.0 Error. Please log back in"
                                                showError = true
                                                authError = true
                                                
                                            case SpotifyError.notFound:
                                                errorMessage = "Playlist not found"
                                                showError = true
                                                
                                            case SpotifyError.rateLimit:
                                                errorMessage = "Servers are busy. Come back later"
                                                showError = true
                                                
                                            default:
                                                errorMessage = "Unknown error occured"
                                                showError = true
                                            }
                                        }
                                    }
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
        @State var showError = false
        @State var errorMessage = ""
        @State var authError = false
        @State var playlistName = "Chillax"
        
        PlaylistView(auth: Auth(), showPlaylists: $show, currSong: $currSong, showAddedToPlaylistToast: $toast, playlistName: $playlistName, showError: $showError, errorMessage: $errorMessage, authError: $authError)
    }
}
