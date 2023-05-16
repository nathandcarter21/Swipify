import SwiftUI
import AVFoundation

class Audio: ObservableObject {
    
    var audioPlayer: AVPlayer?
    var audioSession: AVAudioSession
    
    init() {
        self.audioSession = AVAudioSession.sharedInstance()
        do {
            try self.audioSession.setCategory(.playback, mode:.default)
            try self.audioSession.setActive(true)
        } catch {
            print(error)
        }
    }
    
    func playSong(url: String?) {
        if let urlString = url, let url = URL(string: urlString) {
            let playerItem = AVPlayerItem(url: url)
            self.audioPlayer = AVPlayer(playerItem: playerItem)
                        
            self.audioPlayer?.play()
        }
    }
    
    func playSound() {
        self.audioPlayer?.play()
    }
    
    func pauseSound() {
        self.audioPlayer?.pause()
    }
    
    func stopSound() {
        self.audioPlayer = nil
    }
}
