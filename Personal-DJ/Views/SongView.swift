import SwiftUI

struct SongView: View {
    
    var pub = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
    
    @State var offset: CGSize = .zero
    @State var showInfo = false
    @State var showEnd = false
    
    @State var isPaused = true
    @State var isEnded = false
    @State var isHearted = false
    @State var currSong: Song?
    @State var showError = false
    @State var errorMessage = ""
    @State var authError = false
    
    @ObservedObject var audio: Audio
    var auth: Auth
    
    @StateObject var songViewModel = SongViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                
                if showEnd {
                    
                    Text("That's all of your songs for today!")
                        .frame(width: 300,height: 300)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 50)
                    
                    
                }
                
                ForEach(Array(self.songViewModel.songs.enumerated()), id: \.element) { index, song in
                    
                    VStack {
                        
                        if index == songViewModel.songs.count - 1 && showInfo {
                            
                            HStack {
                                
                                Button {
                                    
                                    withAnimation {
                                        showInfo.toggle()
                                    }
                                    
                                } label: {
                                    
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                }
                                .buttonStyle(.plain)
                                .offset(x: 180, y: 23)
                                
                            }
                            .frame(height: 0)
                            
                        }
                        
                        if index == songViewModel.songs.count - 1 {
                            
                            HStack {
                                
                                Text(song.name)
                                    .frame(maxWidth: 300, alignment: .leading)
                                    .bold()
                                    .font(.system(size: 20))
                                    .onAppear {
                                        
                                        audio.playSong(url: song.preview_url)
                                        isPaused = false
                                        currSong = song
                                        
                                    }
                                
                                Spacer()
                                                                    
                                    Image("Spotify_Icon_Black_Coated")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                                                    
                            }
                            .frame(width: 300)
                                
                        }
                        
                        AsyncImage(url: URL(string: song.album.images[0].url), content: { returnedImage in
                            
                            returnedImage
                                .resizable()
                                .frame(width: 300, height: 300)
                                .opacity(index == songViewModel.songs.count - 1 ? 1 : 0)
                            
                        }, placeholder: {
                            
                            ProgressView()
                                .frame(width: 300, height: 300)
                                .background(Color("AppGray"))
                                .opacity(index == songViewModel.songs.count - 1 ? 1 : 0)
                            
                        })
                        .onTapGesture {
                            
                            withAnimation {
                                
                                showInfo.toggle()
                                
                            }
                            
                        }
                        
                        if showInfo {
                            
                            Spacer()
                            
                        }
                        
                        
                        if index == songViewModel.songs.count - 1 {
                            
                            HStack(spacing: 0) {
                                
                                if showInfo {
                                    
                                    Text("Artist - ")
                                        .bold()
                                        .font(.system(size: 20))
                                    
                                }
                                
                                Text(song.album.artists[0].name)
                                    .font(.system(size: 20))
                                
                            }
                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
                            
                        }
                        
                        if showInfo && songViewModel.songs.count - 1 == index {
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                
                                if showInfo {
                                    
                                    Text("Album - ")
                                        .bold()
                                        .font(.system(size: 20))
                                    
                                }
                                
                                Text(song.album.name)
                                    .font(.system(size: 20))
                                
                            }
                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                
                                if showInfo {
                                    
                                    Text("Popularity - ")
                                        .bold()
                                        .font(.system(size: 20))
                                    
                                }
                                
                                Text("\(song.popularity ?? 50)")
                                    .font(.system(size: 20))
                                
                            }
                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                
                                if showInfo {
                                    
                                    Text("Release Date - ")
                                        .bold()
                                        .font(.system(size: 20))
                                    
                                }
                                
                                Text(song.album.release_date ?? "never")
                                    .font(.system(size: 20))
                                
                            }
                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
                            
                            Spacer()
                            
                            Button {
                                
                                if let uri = URL(string: song.uri) {
                                    
                                    UIApplication.shared.open(uri)
                                    
                                }
                                
                            } label: {
                                
                                Text("Listen On Spotify")
                                    .frame(width: 300, height: 60)
                                    .background(Color("Spotify"))
                                    .cornerRadius(10)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                
                            }
                            .buttonStyle(.plain)
                            
                            Spacer()
                        }
                        
                    }
                    .padding(.bottom, showInfo ? 0 : 50)
                    .scaleEffect(index == self.songViewModel.songs.count - 1 ? getScaleEffect() : 1)
                    .rotationEffect(index == self.songViewModel.songs.count - 1 ? Angle(degrees: getRotationEffect()) : .zero)
                    .offset(index == self.songViewModel.songs.count - 1 ? offset : .zero)
                    .onReceive(pub) { _ in
                        isEnded = true
                    }
                    .gesture(DragGesture()
                             
                        .onChanged{ value in
                            
                            if !showInfo {
                                
                                withAnimation {
                                    
                                    offset = value.translation
                                    
                                }
                                
                            }
                        }
                        .onEnded { value in
                            
                            if !showInfo {
                                
                                withAnimation {
                                    
                                    handleSwipe()
                                    
                                }
                                
                            }
                            
                        }
                             
                    )
                    
                }
                
            }
            
            if !showEnd {
                
                ActionsView(showError: $showError, errorMessage: $errorMessage, authError: $authError, currSong: $currSong, isPaused: $isPaused, isEnded: $isEnded, isHearted: $isHearted, audio: audio, auth: auth)
                
            }
            
        }
        
        .onAppear {
            Task {
                
                guard let token = await auth.getAccessToken() else {
                    errorMessage = "Could not validate your auth token. Please log back in."
                    showError = true
                    authError = true
                    return
                }
                
                if songViewModel.songs.count == 0 {
                    songViewModel.loadSongs(token: token) { res in
                        switch res {
                            
                        case .success():
                            print("Successfully retrieved songs.")
                            
                        case .failure(let error):
                            print(error)
                            
                            switch error {
                                
                            case SpotifyError.unauthorized:
                                errorMessage = "Error authorizing your account. Please log back in."
                                showError = true
                                authError = true
                                
                            case SpotifyError.badReq:
                                errorMessage = "Invalid Request"
                                showError = true
                                
                            case SpotifyError.oathError:
                                errorMessage = "OATH2.0 Error. Please log back in."
                                showError = true
                                authError = true
                                
                            case SpotifyError.notFound:
                                errorMessage = "User not found"
                                showError = true
                                authError = true
                                
                            case SpotifyError.rateLimit:
                                errorMessage = "Servers are busy. Come back later"
                                showError = true
                                
                            default:
                                errorMessage = "Unknown error occured"
                                showError = true
                            }
                        }
                    }
                }
                if auth.user == nil {
                    auth.getUser(token: token) { res in
                        switch res {
                            
                        case .success():
                            print("Successfully retrieved user.")
                            
                        case .failure(let error):
                            print(error)
                            
                            switch error {
                                
                            case SpotifyError.unauthorized:
                                errorMessage = "Error authorizing your account. Please log back in."
                                showError = true
                                authError = true
                                
                            case SpotifyError.badReq:
                                errorMessage = "Invalid Request"
                                showError = true
                                
                            case SpotifyError.oathError:
                                errorMessage = "OATH2.0 Error. Please log back in."
                                showError = true
                                authError = true
                                
                            case SpotifyError.notFound:
                                errorMessage = "Song not found"
                                showError = true
                                authError = true
                                
                            case SpotifyError.rateLimit:
                                errorMessage = "Servers are busy. Come back later"
                                showError = true
                                
                            default:
                                errorMessage = "Unknown error occured"
                                showError = true
                            }
                        }
                    }
                }
            }
        }
        
        .alert(isPresented: $showError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(
                            Text("OK"),
                            action: {
                                if authError {
                                    audio.stopSound()
                                    auth.logOut()
                                }
                            }
                        )
            )
        }
        
    }
    
    func handleSwipe() {
        
        withAnimation {
            
            if offset.width < -150 {
                
                isPaused = true
                isHearted = false
                isEnded = false
                songViewModel.songs.removeLast()
                
                if songViewModel.songs.count == 0 {
                    showEnd = true
//                    audio.pauseSound()
                }
                
            } else if offset.width > 150 {
                
//                isHearted.toggle()
                
            }
            
            offset = .zero
        }
        
    }
    
    func getScaleEffect() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let curr = abs(offset.width)
        let percentage = curr / max
        
        return 1.0 - (percentage * 0.2)
    }
    
    func getRotationEffect() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let curr = offset.width
        let percentage: Double = curr / max
        let maxAngle: Double = 10
        
        return percentage * maxAngle
    }
}

//struct Song_Previews: PreviewProvider {
//    static var previews: some View {
//
//        SongView(
//            songs: [
//                Song(id: "12345", href: "www.google.com", name: "notre dame 1 ", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "banana pancakes 2 ", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "better 3", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")]))
//            ]
//        )
//
//    }
//}
