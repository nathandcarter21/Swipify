//
//  Actions.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct ActionsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var showLikedToast = false
    @State var showUnlikedToast = false
    @State var showPlaylists = false
    @State var showAddedToPlaylistToast = false
    
    @Binding var showError: Bool
    @Binding var errorMessage: String
    @Binding var authError: Bool
    @Binding var currSong: Song?
    @Binding var isPaused: Bool
    @Binding var isEnded: Bool
    @Binding var isHearted: Bool
    
    var audio: Audio
    var auth: Auth
    
    var actionsViewModel = ActionsViewModel()
    
    var body: some View {
        
        ZStack {
            
            HStack {
                
                if isEnded {
                    Button {
                        isEnded.toggle()
                        audio.playSong(url: currSong?.preview_url)
                    } label: {
                        Image(systemName: "repeat")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                }
                
                else {
                    
                    Button {
                        
                        if self.isPaused {
                            audio.playSound()
                        } else {
                            audio.pauseSound()
                        }
                        
                        isPaused.toggle()
                        
                    } label: {
                        Image(systemName: isPaused ? "play.circle" : "pause.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    }
                    
                }
                
                Spacer()
                
                Button {
                    if !isHearted {
                        Task {
                            guard let token = await auth.getAccessToken() else {
                                errorMessage = "Could not validate your auth token. Please log back in."
                                showError = true
                                authError = true
                                return
                            }
                            actionsViewModel.saveSongToLibrary(id: currSong?.id, token: token) { res in
                                switch res {
                                    
                                case .success():
                                    withAnimation {
                                        isHearted.toggle()
                                        showUnlikedToast = false
                                        showLikedToast = true
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                    switch error {
                                        
                                    case SpotifyError.unauthorized:
                                        errorMessage = "Error authorizing your account. Please log back in."
                                        showError = true
                                        authError = true
                                        
                                    case SpotifyError.badReq:
                                        errorMessage = "Invalid Request"
                                        showError = true
                                        
                                    case SpotifyError.oathError:
                                        errorMessage = "OATH2.0 Error. Please log back in."
                                        showError = true
                                        authError = true
                                        
                                    case SpotifyError.notFound:
                                        errorMessage = "Song not found"
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
                    } else {
                        Task {
                            guard let token = await auth.getAccessToken() else {
                                errorMessage = "Could not validate your auth token. Please log back in."
                                showError = true
                                authError = true
                                return
                            }
                            actionsViewModel.removeSongFromLibrary(id: currSong?.id, token: token) { res in
                                switch res {
                                    
                                case .success():
                                    withAnimation {
                                        isHearted.toggle()
                                        showLikedToast = false
                                        showUnlikedToast = true
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                    switch error {
                                    case SpotifyError.unauthorized:
                                        errorMessage = "Error authorizing your account. Please log back in."
                                        showError = true
                                        authError = true
                                        
                                    case SpotifyError.badReq:
                                        errorMessage = "Invalid Request"
                                        showError = true
                                        
                                    case SpotifyError.oathError:
                                        errorMessage = "OATH2.0 Error. Please log back in."
                                        showError = true
                                        authError = true
                                        
                                    case SpotifyError.notFound:
                                        errorMessage = "Song not found"
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
                    }
                } label: {
                    Image(systemName: isHearted ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
                }
                
                Spacer()
                
                Button {
                    showPlaylists = true
                } label: {
                    Image(systemName: "text.badge.plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
                }
                
            }
            .frame(maxWidth: 250)
            .padding(20)
            
            if showLikedToast {
                
                Text("Added to Liked Songs")
                    .padding()
                    .background(Color("AppGray"))
                    .opacity(0.8)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .offset(y: -50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLikedToast = false
                            }
                        }
                    }
                
            }
            
            if showUnlikedToast {
                
                Text("Removed from Liked Songs")
                    .padding()
                    .background(Color("AppGray"))
                    .opacity(0.8)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .offset(y: -50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showUnlikedToast = false
                            }
                        }
                    }
            }
            
            if showAddedToPlaylistToast {
                
                Text("Added to playlist")
                    .padding()
                    .background(Color("AppGray"))
                    .opacity(0.8)
                    .cornerRadius(10)
                    .foregroundColor(Color.white)
                    .offset(y: -50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showAddedToPlaylistToast = false
                            }
                        }
                    }
            }
        }
        
        .sheet(isPresented: $showPlaylists) {
            PlaylistView(auth: auth, showPlaylists: $showPlaylists, currSong: $currSong, showAddedToPlaylistToast: $showAddedToPlaylistToast, showError: $showError, errorMessage: $errorMessage, authError: $authError)
        }
        
    }
}

struct Actions_Previews: PreviewProvider {
    static var previews: some View {

        @State var currSong: Song? = nil
        @State var isPaused = false
        @State var isEnded = false
        @State var isHearted = false
        @State var showError = false
        @State var errorMessage = ""
        @State var authError = false

        ActionsView(showError: $showError, errorMessage: $errorMessage, authError: $authError, currSong: $currSong, isPaused: $isPaused, isEnded: $isEnded, isHearted: $isHearted, audio: Audio(), auth: Auth())

    }
}
