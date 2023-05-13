//
//  Actions.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct ActionsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isPaused = false
    @State var isEnded = false
    @State var isHearted = false
    
    var body: some View {
        
        HStack {
            
            if isEnded {
                Button {
                    print("REPEAT")
                    isEnded.toggle()
                } label: {
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }
            }
            
            else {
                
                Button {
                    print("REPEAT")
                    isPaused.toggle()
                } label: {
                    Image(systemName: isPaused ? "pause.circle" : "play.circle")
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
        ActionsView()
    }
}
