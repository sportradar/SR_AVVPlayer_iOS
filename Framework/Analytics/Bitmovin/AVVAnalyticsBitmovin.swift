//
//  AVVAnalyticsBitmovin.swift
//  AVVAnalyticsBitmovin
//
//  Created by Andreas Becher on 28.01.20.
//  Copyright © 2020 Sportradar. All rights reserved.
//

import BitmovinPlayer
import BitmovinAnalyticsCollector
import AVVPlayer

class AVVAnalyticsBitmovin : AVVAnalytics {
    
    static var type: String = "bitmovin"
    
    private let avvConfig : AVVAnalyticsConfig
    private var bitmovinConfig : BitmovinAnalyticsConfig?
    private var bitmovinAnalytics : BitmovinAnalytics?
    
    required init(config: AVVAnalyticsConfig) {
        self.avvConfig = config
    }
    
    func setup(withPlayer player: AVPlayer) {
        setupBitmovinConfig()
        setupAnalyticsCollector(withPlayer: player)
    }
    
    func cleanup() {
        bitmovinAnalytics?.detachPlayer()
    }
    
    private func setupBitmovinConfig() {
        self.bitmovinConfig = BitmovinAnalyticsConfig(key:avvConfig.customData?["key"] as? String ?? "")
        self.bitmovinConfig?.customData1 = avvConfig.customData?["customData1"] as? String
        self.bitmovinConfig?.customData2 = avvConfig.customData?["customData2"] as? String
        self.bitmovinConfig?.customData3 = avvConfig.customData?["customData3"] as? String
        self.bitmovinConfig?.customData4 = avvConfig.customData?["customData4"] as? String
        self.bitmovinConfig?.customData5 = avvConfig.customData?["customData5"] as? String
        self.bitmovinConfig?.cdnProvider = avvConfig.customData?["cdnProvider"] as? String
        self.bitmovinConfig?.customerUserId = avvConfig.customData?["userId"] as? String
        self.bitmovinConfig?.videoId = avvConfig.customData?["videoId"] as? String
        self.bitmovinConfig?.title = avvConfig.customData?["title"] as? String
    }
    
    private func setupAnalyticsCollector(withPlayer player: AVPlayer) {
        if let bitmovinConfig = bitmovinConfig {
            bitmovinAnalytics = BitmovinAnalytics(config: bitmovinConfig)
            bitmovinAnalytics?.attachAVPlayer(player: player)
        }
    }

}
