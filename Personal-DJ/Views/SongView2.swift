////
////  Song.swift
////  Personal-DJ
////
////  Created by Nathan Carter on 5/12/23.
////
//
//import SwiftUI
//
//struct SongView2: View {
//
//    var song: Song?
//
//    @State var offset: CGSize = .zero
//    @State var showInfo = false
//
//    @ObservedObject var audio: Audio
//    @ObservedObject var songViewModel: SongViewModel
//
//    init(audio: Audio, token: String) {
//        self.audio = audio
//        self.songViewModel = SongViewModel(token: token)
//    }
//
//    init(songs: [Song]) {
//        self.audio = Audio()
////        self.songViewModel = SongViewModel(currSong: songs[0], songs: songs)
//    }
//
////    @State var songs = ["notre dame", "stick season", "better together"]
//
//    var body: some View {
//
////        ZStack {
////
////            ForEach(Array(songs.enumerated()), id: \.element){ index, song in
////                Text("\(song) \(index)")
////                    .frame(width: 300, height: 300)
////                    .background((Color.black))
////                    .foregroundColor(Color.white)
////                    .offset(index == songs.count - 1 ? offset : .zero)
////                    .gesture(DragGesture()
////                        .onChanged{ value in
////                            withAnimation(.easeInOut) {
////                                offset = value.translation
////
////                            }
////                        }
////                        .onEnded { value in
////
////                            withAnimation(.spring()) {
////                                handleSwipe()
////                            }
////
////                        }
//        //                    )
//        //            }
//        //        }
//
////        Button("PRESS"){
////            print(songViewModel.songs)
////        }
//
//        ZStack() {
//
//            ForEach(Array(self.songViewModel.songs.enumerated()), id: \.element) { index, song in
//
//
//                    VStack {
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                            HStack {
//
//                                Button {
//                                    withAnimation {
//                                        showInfo.toggle()
//                                    }
//                                } label: {
//
//                                    Image(systemName: "xmark")
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                        .offset(y: 20)
//
//                                }
//                                .buttonStyle(.plain)
//
//                            }
//                            .frame(maxWidth: 300, alignment: .trailing)
//                            .frame(height: 0)
//
//                        }
//
//                        if index == self.songViewModel.songs.count - 1 {
//
//                            Text(song.name)
//                                .frame(maxWidth: 300, alignment: .leading)
//                                .bold()
//                                .font(.system(size: 20))
//
//                        }
//
//
//                        AsyncImage(url: URL(string: song.album.getImage().url), content: { returnedImage in
//                            returnedImage
//                                .resizable()
//                                .frame(width: 300, height: 300)
//                                .opacity(index == self.songViewModel.songs.count - 1 ? 1 : 0)
//                        }, placeholder: {
//                            ProgressView()
//                                .frame(width: 300, height: 300)
//                                .background(Color("AppGray"))
//                        })
//                        .onTapGesture {
//                            withAnimation {
//                                showInfo.toggle()
//                            }
//                        }
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//                            Spacer()
//                        }
//
//
//                        HStack(spacing: 0) {
//                            if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                                Text("Artist - ")
//                                    .bold()
//                                    .font(.system(size: 20))
//                            }
//
//                            if index == self.songViewModel.songs.count - 1 {
//
//
//                                Text(song.album.getArtist().name)
//                                    .font(.system(size: 20))
//
//                            }
//
//                        }
//                        .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Album - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text(song.album.name)
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Popularity - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text("\(song.popularity)")
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Release Date - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text(song.album.release_date)
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//
//                            Button {
//
//                            } label: {
//
//                                Text("Listen On Spotify")
//                                    .frame(width: 300, height: 60)
//                                    .background(Color("Spotify"))
//                                    .cornerRadius(10)
//                                    .foregroundColor(Color.white)
//                                    .font(.system(size: 20))
//
//                            }
//                            .buttonStyle(.plain)
//
//                            Spacer()
//                        }
//
//                    }
//                    .padding(.bottom, showInfo ? 0 : 50)
////                    .scaleEffect(getScaleEffect())
////                    .rotationEffect(Angle(degrees: getRotationEffect()))
//                    .offset(index == self.songViewModel.songs.count - 1 ? offset : .zero)
//                    .gesture(DragGesture()
//                        .onChanged{ value in
//
//                            if !showInfo {
//
//                                withAnimation(.easeInOut) {
//                                    offset = value.translation
//                                }
//
//                            }
//                        }
//                        .onEnded { value in
//
//                            if !showInfo {
//
//                                withAnimation(.spring()) {
//                                    handleSwipe()
//                                    offset = .zero
//                                }
//
//                            }
//                        }
//                    )
//                    .onAppear {
//                        //                audio.playSong(url: song.preview_url)
//                    }
//
//            }
//        }
//    }
//
//    func handleSwipe() {
//        if offset.width < -150 {
////            let newURL = songViewModel.skipSong()
//            withAnimation {
////                offset.width = -500
//                self.songViewModel.songs.removeLast()
//                offset = .zero
//            }
//
////            audio.playSong(url: newURL)
//        } else if offset.width > 150 {
////            offset.width = 500
//        }else{
//            offset = .zero
//        }
//    }
//
//    func getScaleEffect() -> CGFloat {
//        let max = UIScreen.main.bounds.width / 2
//        let curr = abs(offset.width)
//        let percentage = curr / max
//
//        return 1.0 - (percentage * 0.2)
//    }
//
//    func getRotationEffect() -> Double {
//        let max = UIScreen.main.bounds.width / 2
//        let curr = offset.width
//        let percentage: Double = curr / max
//        let maxAngle: Double = 10
//
//        return percentage * maxAngle
//    }
//}
//
//struct Song2_Previews: PreviewProvider {
//    static var previews: some View {
//
//        SongView2(
//            songs: [
//                Song(id: "12345", href: "www.google.com", name: "notre dame", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "stick season", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "better together", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")]))
//                   ]
//        )
//
//    }
//}
//
////  Song.swift
////  Personal-DJ
////
////  Created by Nathan Carter on 5/12/23.
////
//
//import SwiftUI
//
//struct SongView2: View {
//
//    var song: Song?
//
//    @State var offset: CGSize = .zero
//    @State var showInfo = false
//
//    @ObservedObject var audio: Audio
//    @ObservedObject var songViewModel: SongViewModel
//
//    init(audio: Audio, token: String) {
//        self.audio = audio
//        self.songViewModel = SongViewModel(token: token)
//    }
//
//    init(songs: [Song]) {
//        self.audio = Audio()
////        self.songViewModel = SongViewModel(currSong: songs[0], songs: songs)
//    }
//
////    @State var songs = ["notre dame", "stick season", "better together"]
//
//    var body: some View {
//
////        ZStack {
////
////            ForEach(Array(songs.enumerated()), id: \.element){ index, song in
////                Text("\(song) \(index)")
////                    .frame(width: 300, height: 300)
////                    .background((Color.black))
////                    .foregroundColor(Color.white)
////                    .offset(index == songs.count - 1 ? offset : .zero)
////                    .gesture(DragGesture()
////                        .onChanged{ value in
////                            withAnimation(.easeInOut) {
////                                offset = value.translation
////
////                            }
////                        }
////                        .onEnded { value in
////
////                            withAnimation(.spring()) {
////                                handleSwipe()
////                            }
////
////                        }
//        //                    )
//        //            }
//        //        }
//
////        Button("PRESS"){
////            print(songViewModel.songs)
////        }
//
//        ZStack() {
//
//            ForEach(Array(self.songViewModel.songs.enumerated()), id: \.element) { index, song in
//
//
//                    VStack {
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                            HStack {
//
//                                Button {
//                                    withAnimation {
//                                        showInfo.toggle()
//                                    }
//                                } label: {
//
//                                    Image(systemName: "xmark")
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                        .offset(y: 20)
//
//                                }
//                                .buttonStyle(.plain)
//
//                            }
//                            .frame(maxWidth: 300, alignment: .trailing)
//                            .frame(height: 0)
//
//                        }
//
//                        if index == self.songViewModel.songs.count - 1 {
//
//                            Text(song.name)
//                                .frame(maxWidth: 300, alignment: .leading)
//                                .bold()
//                                .font(.system(size: 20))
//
//                        }
//
//
//                        AsyncImage(url: URL(string: song.album.getImage().url), content: { returnedImage in
//                            returnedImage
//                                .resizable()
//                                .frame(width: 300, height: 300)
//                                .opacity(index == self.songViewModel.songs.count - 1 ? 1 : 0)
//                        }, placeholder: {
//                            ProgressView()
//                                .frame(width: 300, height: 300)
//                                .background(Color("AppGray"))
//                        })
//                        .onTapGesture {
//                            withAnimation {
//                                showInfo.toggle()
//                            }
//                        }
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//                            Spacer()
//                        }
//
//
//                        HStack(spacing: 0) {
//                            if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                                Text("Artist - ")
//                                    .bold()
//                                    .font(.system(size: 20))
//                            }
//
//                            if index == self.songViewModel.songs.count - 1 {
//
//
//                                Text(song.album.getArtist().name)
//                                    .font(.system(size: 20))
//
//                            }
//
//                        }
//                        .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                        if showInfo && index == self.songViewModel.songs.count - 1 {
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Album - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text(song.album.name)
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Popularity - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text("\(song.popularity)")
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//                            HStack(spacing: 0) {
//                                if showInfo {
//                                    Text("Release Date - ")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                }
//
//                                Text(song.album.release_date)
//                                    .font(.system(size: 20))
//
//                            }
//                            .frame(maxWidth: 300, alignment: showInfo ? .leading : .trailing)
//
//                            Spacer()
//
//
//                            Button {
//
//                            } label: {
//
//                                Text("Listen On Spotify")
//                                    .frame(width: 300, height: 60)
//                                    .background(Color("Spotify"))
//                                    .cornerRadius(10)
//                                    .foregroundColor(Color.white)
//                                    .font(.system(size: 20))
//
//                            }
//                            .buttonStyle(.plain)
//
//                            Spacer()
//                        }
//
//                    }
//                    .padding(.bottom, showInfo ? 0 : 50)
////                    .scaleEffect(getScaleEffect())
////                    .rotationEffect(Angle(degrees: getRotationEffect()))
//                    .offset(index == self.songViewModel.songs.count - 1 ? offset : .zero)
//                    .gesture(DragGesture()
//                        .onChanged{ value in
//
//                            if !showInfo {
//
//                                withAnimation(.easeInOut) {
//                                    offset = value.translation
//                                }
//
//                            }
//                        }
//                        .onEnded { value in
//
//                            if !showInfo {
//
//                                withAnimation(.spring()) {
//                                    handleSwipe()
//                                    offset = .zero
//                                }
//
//                            }
//                        }
//                    )
//                    .onAppear {
//                        //                audio.playSong(url: song.preview_url)
//                    }
//
//            }
//        }
//    }
//
//    func handleSwipe() {
//        if offset.width < -150 {
////            let newURL = songViewModel.skipSong()
//            withAnimation {
////                offset.width = -500
//                self.songViewModel.songs.removeLast()
//                offset = .zero
//            }
//
////            audio.playSong(url: newURL)
//        } else if offset.width > 150 {
////            offset.width = 500
//        }else{
//            offset = .zero
//        }
//    }
//
//    func getScaleEffect() -> CGFloat {
//        let max = UIScreen.main.bounds.width / 2
//        let curr = abs(offset.width)
//        let percentage = curr / max
//
//        return 1.0 - (percentage * 0.2)
//    }
//
//    func getRotationEffect() -> Double {
//        let max = UIScreen.main.bounds.width / 2
//        let curr = offset.width
//        let percentage: Double = curr / max
//        let maxAngle: Double = 10
//
//        return percentage * maxAngle
//    }
//}
//
//struct Song2_Previews: PreviewProvider {
//    static var previews: some View {
//
//        SongView2(
//            songs: [
//                Song(id: "12345", href: "www.google.com", name: "notre dame", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "stick season", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")])),
//                Song(id: "12345", href: "www.google.com", name: "better together", popularity: 61, preview_url: "https://p.scdn.co/mp3-preview/8d9301f275ffb5a4128ab7a268d0fd90bc4518a1?cid=0b297fa8a249464ba34f5861d4140e58", uri: "spotify:track:4ni2PRjuIORNFXvWB74SqX", is_local: false, album: Album(id: "12345", album_type: "SINGLE", name: "notre dame", release_date: "2023-02-17", release_date_precision: "day", images: [AlbumImage(height: 300, width: 300, url: "https://i.scdn.co/image/ab67616d0000b2735c8bb06b717da13d4c37cae4")], artists: [Artist(id: "12345", name: "Paris Paloma")]))
//                   ]
//        )
//
//    }
//}
