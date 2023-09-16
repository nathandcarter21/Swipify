//
//  PrivacyView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 6/7/23.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("Swipify is an app developed using the open-source Spotify Web API, which requires your Spotify account data to function.")
                .multilineTextAlignment(.center)
            Text("Please note that none of the data utilized by Swipify is stored and is never shared with an third-party services. The information is solely used to recommend, like, and add songs to your Spotify library.")
                .multilineTextAlignment(.center)
            Text("If you wish to revoke Swipify's access, you can navigate to your apps page and click \"Remove Access\" to remove our permissions. For more support click [here](https://support.spotify.com/us/article/spotify-on-other-apps/).")
                .multilineTextAlignment(.center)
        }
        .padding(40)
        .navigationTitle("Privacy")
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
