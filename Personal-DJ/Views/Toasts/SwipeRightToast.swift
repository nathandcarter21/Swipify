//
//  SwipeRightToast.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/23/23.
//

import SwiftUI

struct SwipeRightToast: View {
    
    @Binding var showAddedToPersonalPicksToast: Bool
    
    var body: some View {
        
        ZStack {
            Image(systemName: "text.badge.checkmark")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.black.opacity(0.4))
                .offset(y: -10)
            
            Text("Swipify")
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
                    showAddedToPersonalPicksToast = false
                }
            }
        }
    }
}

struct SwipeRightToast_Previews: PreviewProvider {
    @State static var val = false
    static var previews: some View {
        SwipeRightToast(showAddedToPersonalPicksToast: $val)
    }
}
