//
//  BackgroundVideoView.swift
//  backgroundVideoView
//
//  Created by Muhammad Ali on 24/07/2019.
//

import Foundation
import UIKit
import AVFoundation

public class BackgroundVideoView1: UIView {
    
    var player: AVPlayer?
    var videoNames = ["video1","video2"]
    var videoExtension = "mp4"
    var selectedVideo: String?
    var videoIndex = 0
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        selectedVideo = videoNames[0]
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.videoToBePlayed()
        }
        initializeVideoPlayerWithVideo()
    }
    
    private func initializeVideoPlayerWithVideo() {
        
        print(selectedVideo!)
        let videoString:String? = Bundle.main.path(forResource: selectedVideo, ofType: videoExtension)
        guard let unwrappedVideoPath = videoString else {return}
        
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        self.player = AVPlayer(url: videoUrl)
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.frame = UIScreen.main.bounds
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.opacity = 0.3
        
        self.layer.addSublayer(layer)
        player?.play()
        player?.isMuted = true
    }
    
    private func videoToBePlayed(){
        if self.videoIndex >= 0 && self.videoIndex < self.videoNames.count-1 {
            self.videoIndex += 1
            self.selectedVideo = self.videoNames[self.videoIndex]
        }else{
            self.videoIndex = 0
            self.selectedVideo = self.videoNames[self.videoIndex]
        }
        self.initializeVideoPlayerWithVideo()
    }
}
