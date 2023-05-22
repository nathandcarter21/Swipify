//
//  ViewSwitcher.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/12/23.
//

import SwiftUI

struct ViewSwitcher: View {
    
    @StateObject var auth = Auth()
    
    var body: some View {
                
        if !auth.signedIn {
            SignInView(
                auth: auth
            )
        }
        
        else {
            HomeView(auth: auth)
                .onAppear {                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("SUCCESS")
                        } else if let error = error {
                            print(error)
                        }
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
