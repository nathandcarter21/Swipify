//
//  Home.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct HomeView: View {
    
    var auth : Auth
    @StateObject var audio = Audio()
    
    var body: some View {
        
        SongView(
            audio:audio,
            auth: auth
        )
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarItems(
            trailing:
                
                HStack {
                    
//                    Image(systemName: "line.3.horizontal.decrease.circle")
                    
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
