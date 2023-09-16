//
//  ContactView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 6/7/23.
//

import SwiftUI

struct ContactView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Swipify was created by")
            Text("Nathan Carter")
            Text("ndc922@byu.edu")
        }
        .navigationTitle("Contact")
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
