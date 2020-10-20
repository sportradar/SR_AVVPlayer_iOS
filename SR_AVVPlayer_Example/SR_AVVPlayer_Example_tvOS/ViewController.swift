//
//  ViewController.swift
//  SR_AVVPlayer_Example_tvOS
//
//  Created by Andreas Becher on 08.09.20.
//  Copyright © 2020 Sportradar. All rights reserved.
//

import UIKit
import SRAVVPlayer

class ViewController: UIViewController {
    
    var playerContainer = UIView()
    var player : AVVPlayer!
    
    var inlineButton = UIButton(type: .system)
    var presentationButton = UIButton(type: .system)
    
    
    let source = "YOUR OTT CONFIG URL"
    let source1 = AVVPlayerConfig(streamUrl:"https://wowzaec2demo.streamlock.net/vod-multitrack/_definst_/smil:ElephantsDream/elephantsdream2.smil/playlist.m3u")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerContainer.backgroundColor = .black
        
        inlineButton.setTitle("Start Inline Mode", for: .normal)
        presentationButton.setTitle("Start Presentation Mode", for: .normal)
        
        inlineButton.addTarget(self, action: #selector(actionButtonClicked), for: .primaryActionTriggered)
        presentationButton.addTarget(self, action: #selector(actionButtonClicked), for: .primaryActionTriggered)
        
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [inlineButton]
    }
    
    func setupUI() {
        self.view.addSubview(inlineButton)
        self.view.addSubview(presentationButton)
        
        self.setupConstraints()
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
    @objc func actionButtonClicked(sender : UIButton) {
        let closure = {
            if sender == self.inlineButton {
                self.startInlinePlayer(config: self.source1)
                return
            }
            
            self.startPresentationPlayer(config: self.source1)
        }
        
        if player == nil {
            closure()
            return
        }
        
        player.release {
            self.playerContainer.removeFromSuperview()
            self.player = nil
            closure()
        }
    }
    
    private func startPresentationPlayer(config : AVVPlayerConfigConvertible) {
        print("start presentation")
        player = AVVPlayerBuilder.shared.createPresentationPlayer(config: config, presenter: self)
        player.add(self)
        player.configDelegate = self
        player.start()
    }
    
    private func startInlinePlayer(config : AVVPlayerConfigConvertible) {
        print("start inline")
        
        self.setupPlayerContainer()
        
        let settings = AVVPlayer.ModeSettings.Inline(autoLandscapeFullscreen: true, containerView: playerContainer)
        player = AVVPlayerBuilder.shared.createInlinePlayer(config: config, settings: settings)
        player.configDelegate = self
        player.add(self)
        player.start()
    }

    private func setupPlayerContainer() {
        self.view.addSubview(playerContainer)
        
        self.playerContainer.translatesAutoresizingMaskIntoConstraints = false
        self.playerContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.playerContainer.topAnchor.constraint(equalTo: self.presentationButton.bottomAnchor, constant: 20).isActive = true
        self.playerContainer.widthAnchor.constraint(equalTo: self.playerContainer.heightAnchor, multiplier:16/9).isActive = true
        self.playerContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-40).isActive = true
    }
    
    private func setupConstraints() {
        
        self.inlineButton.translatesAutoresizingMaskIntoConstraints = false
        self.inlineButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.inlineButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.inlineButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.presentationButton.translatesAutoresizingMaskIntoConstraints = false
        self.presentationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.presentationButton.topAnchor.constraint(equalTo: self.inlineButton.bottomAnchor, constant: 20).isActive = true
        self.presentationButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

extension ViewController : AVVPlayerObserver
{
    func avvPlayer(didReleasePlayerMode player: AVVPlayer) {
        print("presentation did Close")
    }
}

extension ViewController : AVVPlayerConfigDelegate
{
    func avvPlayer(_ player: AVVPlayer, provideMutatedConfigFrom config: AVVPlayerConfig) -> AVVPlayerConfig {
        //Manipulate (external) config after loading/before processing
        //--> e.g. add seek buttons
        let newConfig = config
        
        //use custom overlay
        newConfig.theme = 0 //1 for custom overlay
        
        newConfig.playerControlsScheme.seekForwardButtonEnabled = true
        newConfig.playerControlsScheme.seekBehindButtonEnabled = true
        newConfig.playerControlsScheme.seekButtonSeconds = 40
        // --> set autoplay
        newConfig.playbackOptions.autoplay = true // starts video immediately after pre-processing
        newConfig.advertisement.enabled = false
        return newConfig
    }
}


