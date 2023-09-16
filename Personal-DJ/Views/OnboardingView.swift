//
//  OnboardingView.swift
//  Personal-DJ
//
//  Created by Nathan Carter on 5/30/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var showOnboarding: Bool

    private let icons: [Image] = [Image(systemName: "arrow.forward"), Image(systemName: "arrow.backward"), Image("heart-64"), Image(systemName: "text.badge.plus")]
    private let actions: [String] = ["Swipe right to add a song to your Swipify playlist", "Swipe left to skip a song", "Add songs to your liked songs", "Add songs to your playlists"]
    
    var body: some View {
        ZStack {
            Color("AppGray")
                .opacity(0.5)
                .ignoresSafeArea(.all)
            VStack {
                TabView {
                    ForEach(actions.indices, id: \.self) { i in
                        
                        ZStack {
                            
                            if i == 0 {
                                Text("Welcome to Swipify!")
                                    .offset(y: -350)
                                    .font(.headline)
                            }
                            
                            ZStack {
                                
                                icons[i]
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.black.opacity(0.4))
                                    .offset(y: -30)
                                                                
                                Text(actions[i])
                                    .offset(y: 80)
                                    .foregroundColor(Color.black.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                    .padding()

                                
                            }
                            .frame(width: 275, height: 275)
                            .background(Color.gray.opacity(0.78))
                            .cornerRadius(35)
                            .offset(y: -25)
                            
                            if i == 3 {
                                Button(action: {
                                    showOnboarding = false
                                }, label: {
                                    HStack {
                                        Text("Continue")
                                            .padding(.trailing, 20)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 20))
                                    }
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.7))
                                    .cornerRadius(10)
                                    .padding()
                                })
                                .offset(y: 300)
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        OnboardingView(showOnboarding: $show)
    }
}
