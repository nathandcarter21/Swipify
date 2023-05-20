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
        }
    }
}

struct ViewSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ViewSwitcher()
    }
}
