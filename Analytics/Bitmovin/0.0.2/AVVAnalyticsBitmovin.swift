//
//  AVVAnalyticsBitmovin.swift
//  AVVAnalyticsBitmovin
//
//  Created by Andreas Becher on 28.01.20.
//  Copyright © 2020 Sportradar. All rights reserved.
//

import BitmovinAnalyticsCollector
import AVKit
import SRAVVPlayer

class AVVAnalyticsBitmovin : AVVAnalytics {
    
    static var type: String = "bitmovin"
    
    private let avvConfig : AVVAnalyticsConfig
    private var bitmovinConfig : BitmovinAnalyticsConfig?
    private var bitmovinPlayerCollector : AVPlayerCollector?
    
    required init(config: AVVAnalyticsConfig) {
        self.avvConfig = config
    }
    
    func attach(player: AVPlayer) {
        setupBitmovinConfig()
        setupAnalyticsCollector(withPlayer: player)
    }
    
    func cleanup() {
        bitmovinPlayerCollector?.detachPlayer()
    }
    
    private func setupBitmovinConfig() {
        self.bitmovinConfig = BitmovinAnalyticsConfig(key:avvConfig.customData?["key"] as? String ?? "")
        self.bitmovinConfig?.customData1 = avvConfig.customData?["customData1"] as? String
        self.bitmovinConfig?.customData2 = avvConfig.customData?["customData2"] as? String
        self.bitmovinConfig?.customData3 = avvConfig.customData?["customData3"] as? String
        self.bitmovinConfig?.customData4 = avvConfig.customData?["customData4"] as? String
        self.bitmovinConfig?.customData5 = avvConfig.customData?["customData5"] as? String
        self.bitmovinConfig?.customData6 = avvConfig.customData?["customData6"] as? String
        self.bitmovinConfig?.customData7 = avvConfig.customData?["customData7"] as? String
        self.bitmovinConfig?.isLive = avvConfig.customData?["isLive"] as? Bool ?? false
        self.bitmovinConfig?.cdnProvider = avvConfig.customData?["cdnProvider"] as? String
        self.bitmovinConfig?.customerUserId = avvConfig.customData?["userId"] as? String
        self.bitmovinConfig?.playerKey = avvConfig.customData?["player"] as? String ?? ""
        self.bitmovinConfig?.videoId = avvConfig.customData?["videoId"] as? String
        self.bitmovinConfig?.title = avvConfig.customData?["title"] as? String
    }
    
    private func setupAnalyticsCollector(withPlayer player: AVPlayer) {
        if let bitmovinConfig = bitmovinConfig {
            bitmovinPlayerCollector = AVPlayerCollector(config: bitmovinConfig)
            bitmovinPlayerCollector?.attachPlayer(player: player)
        }
    }
}
