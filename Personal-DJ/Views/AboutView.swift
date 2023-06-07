//
//  AboutView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 6/7/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("Welcome to Personal DJ, the ultimate music companion that revolutionizes your music discovery experience. By seamlessly integrating with your Spotify account, Personal DJ fetches recommended songs based on your favorite tracks, providing you with a personalized playlist like no other.")
                .multilineTextAlignment(.center)
            Text("With Personal DJ, exploring new music that resonates with your taste has never been easier. You can preview these recommended songs within the app and swipe right for the ones you like or left for the ones that don't resonate with you. Plus, you can effortlessly add songs to your liked songs collection or create custom playlists for any occasion, putting you in complete control of your music library.")
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
