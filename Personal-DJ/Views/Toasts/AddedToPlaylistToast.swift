//
//  AddedToPlaylistToast.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/23/23.
//

import SwiftUI

struct AddedToPlaylistToast: View {
    
    @Binding var showAddedToPlaylistToast: Bool
    @Binding var playlistName: String
    
    var body: some View {

        ZStack {
            Image(systemName: "text.badge.checkmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black.opacity(0.4))
                .offset(y: -10)
            
            Text(playlistName)
                .offset(y: 70)
                .foregroundColor(Color.black.opacity(0.4))
            
        }
        .frame(width: 225, height: 225)
        .background(Color.gray.opacity(0.78))
        .cornerRadius(35)
        .offset(y: -25)
        .allowsHitTesting(false)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation() {
                    showAddedToPlaylistToast = false
                }
            }
        }
        
    }
}

struct AddedToPlaylistToast_Previews: PreviewProvider {
    @State static var val = false
    @State static var name = "Chillax"

    static var previews: some View {
        AddedToPlaylistToast(showAddedToPlaylistToast: $val, playlistName: $name)
    }
}
