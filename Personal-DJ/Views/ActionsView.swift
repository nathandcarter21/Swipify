//
//  Actions.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct ActionsView: View {
    
    @Environment(\.colorScheme) var colorScheme
        
    @Binding var currSong: Song?
    @Binding var isPaused: Bool
    @Binding var isEnded: Bool
    @Binding var isHearted: Bool
    
    @ObservedObject var audio: Audio
    
    var body: some View {
        
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
                print("HEART")
                withAnimation {
                    isHearted.toggle()
                }
            } label: {
                Image(systemName: isHearted ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
            }
            
            Spacer()
            
            Button {
                print("PLAYLIST")
            } label: {
                Image(systemName: "text.badge.plus")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
            }
            
        }
        .frame(maxWidth: 250)
        
    }
}

struct Actions_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var currSong: Song? = nil
        @State var isPaused = false
        @State var isEnded = false
        @State var isHearted = false
        
        ActionsView(currSong: $currSong, isPaused: $isPaused, isEnded: $isEnded, isHearted: $isHearted, audio: Audio())

    }
}
