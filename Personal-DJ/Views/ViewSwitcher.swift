//
//  ViewSwitcher.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct ViewSwitcher: View {
    
    @StateObject var auth = Auth()
    @State var showOnboarding = true
    @AppStorage("onboarded") var onboarded = false
    
    var body: some View {
                
        if !auth.signedIn {
            SignInView(
                auth: auth
            )
            .onAppear {
                onboarded = false
                showOnboarding = true
            }
        }
        
        else {
            if showOnboarding && !onboarded {
                OnboardingView(showOnboarding: $showOnboarding)
            }
            else {
                HomeView(auth: auth)
                    .onAppear {
                        onboarded = true
                    }
            }
        }
    }
}

struct ViewSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ViewSwitcher()
    }
}
