//
//  ViewController.swift
//  SR_AVVPlayer_Example
//
//  Created by Andreas Becher on 08.08.19.
//  Copyright © 2019 Sportradar. All rights reserved.
//

import UIKit
import AVVPlayer

class ViewController: UIViewController {
    
    let playerContainer = UIView()
    var player : AVVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(playerContainer)
        
        playerContainer.translatesAutoresizingMaskIntoConstraints = false
        playerContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        playerContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        playerContainer.widthAnchor.constraint(equalTo:self.view.widthAnchor).isActive = true
        playerContainer.heightAnchor.constraint(equalTo: playerContainer.widthAnchor, multiplier:9/16).isActive = true
    }
    
    func setupVideoPlayer()
    {
        let config = AVVPlayerConfig(streamUrl: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        //register your own costum control overlay
        AVVPlayerBuilder.shared.add(controlOverlay: CustomPlayerOverlay.self, for: 1)
        //use custom overlay
        config.theme = 0 //1 for custom overlay
        
        // --> force error
        //let config = AVVPlayerConfig(streamUrl: "https://clips.vorwaerts-gmbh.de/big_buck_p4")
        
        //inline Player settings --> autoLandscapeFullscreen forces the player to change to fullscreen if device is rotated to landscape
        // we have some issues on autoLandscapeFullscreen on tablet, this is not working properly in this version
        //autoLandscapeFullscreen should be set to false if the App supports portait and landscape orientation
        let settings = AVVPlayer.ModeSettings.Inline(autoLandscapeFullscreen: UIDevice.current.userInterfaceIdiom == .phone)
        player = AVVPlayerBuilder.shared.createInlinePlayer(config:config , appWindow: UIApplication.shared.keyWindow ?? UIWindow(), containerView: playerContainer, settings:settings )
            _ = player?.add(self) // for observing player events
        
            // if you want to provide your own error/preview overlay implement AVVPlayerCustomLayerDelegate
            //player?.customLayerDelegate = self
        
            player?.configDelegate = self //if external config is used, you can manipulate it bevor AVVPlayer is processing the config
        
            //starts processing current player config
            self.player?.start()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
       return .portrait
    }
}


//MARK: - Player Config Delegate --> Manipulate external config after loading
extension ViewController : AVVPlayerConfigDelegate
{
    func avvPlayer(_ player: AVVPlayer, provideMutatedConfigFrom config: AVVPlayerConfig) -> AVVPlayerConfig {
        //Manipulate (external) config after loading/before processing
        //--> e.g. add seek buttons
        let newConfig = config
        newConfig.seekControlsScheme = AVVPlayerSeekControlsScheme()
        newConfig.seekControlsScheme?.seekForwardButtonEnabled = true
        newConfig.seekControlsScheme?.seekBehindButtonEnabled = true
        newConfig.seekControlsScheme?.seekButtonSeconds = 20
        // --> set autoplay
        newConfig.autoplay = true // starts video immediately after pre-processing
        return newConfig
    }
}



//MARK: - Player Observer -> Observe Player Events
extension ViewController : AVVPlayerObserver
{
    func avvPlayer(_ player: AVVPlayer, initializesMediaSession session: AVVMediaSession) {
        //information when media session is created --> recommended method to add Media Session Observer
        _ = session.add(self)
    }
    
    func avvPlayer(_ player: AVVPlayer, didFailWith error: AVVError) {
        //error callback
    }
}

extension ViewController : AVVMediaSessionObserver
{
    func willPlay(_ mediaSession: AVVMediaSession) {
        //called when Player Starts playback and resumes from paused state
    }
    
    func willClose(_ mediaSession: AVVMediaSession) {
        //called when media Session will be closed
    }
}

