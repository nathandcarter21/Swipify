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
                    withAnimation {
                        
                        isHearted.toggle()
                        if isHearted {
                            actionsViewModel.saveSongToLibrary(id: currSong?.id, token: auth.token)
                            withAnimation {
                                showUnlikedToast = false
                                showLikedToast = true
                            }
                        } else {
                            actionsViewModel.removeSongFromLibrary(id: currSong?.id, token: auth.token)
                            withAnimation {
                                showLikedToast = false
                                showUnlikedToast = true
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
            PlaylistView(auth: auth, showPlaylists: $showPlaylists, currSong: $currSong, showAddedToPlaylistToast: $showAddedToPlaylistToast)
        }
    }
}

struct Actions_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var currSong: Song? = nil
        @State var isPaused = false
        @State var isEnded = false
        @State var isHearted = false
        
        ActionsView(currSong: $currSong, isPaused: $isPaused, isEnded: $isEnded, isHearted: $isHearted, audio: Audio(), auth: Auth())

    }
}
