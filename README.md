AVVPlayer-MARVIN-iOS
===================
#  Changelog
------

## v0.9.23 (@2021-04-02)

- adds resolution to AVVMediaPlaybackStreamData
- adds Track Progress feature and AVVResumeOptionsLayerDefault
- adds backroundImage to AVVPlayerConfig.MetaData

Dependencies: 
- SDWebImage v5.11.0 (from v5.10.4)
- RxSwift v6.1.0
- RxCocoa v6.1.0

[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.14.1
- google-cast-sdk v4.5.1
- SwiftyXMLParser v5.0.0
- Protobuf v3.13.0

------

## v0.9.22 (@2021-03-04)

- adds usage of device language to AVVAdvertisementProviderIMA
- considers startPositionVOD on replay selection in AVVEndscreen

- fixes sessionReachedEnd not called for mp4 videos
- fixes width of sliderSeekPositionLabel in AVVPlayerControlLayerDefault

Dependencies: 
- SDWebImage v5.10.4 (from v5.9.3)
- RxSwift v6.1.0 (from v5.1.1)
- RxCocoa v6.1.0 (from v5.1.1)

[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.14.1 (from v3.11.4)
- google-cast-sdk v4.5.1
- SwiftyXMLParser v5.0.0
- Protobuf v3.13.0

------

## v0.9.21 (@2021-03-01)

- adds backup stream functionality
- adds AVVPlayerObserver.avvPlayer(player : AVVPlayer, mediaSessionIsReadyToPlay : AVVMediaSession) --> playback channel is connected, player can receive control signals (e.g.: seek)
- adds custom fonts for default overlays (checkout guide for custom fonts in docs)
- adds error icon to default AVVDefaultErrorLayer
- adds AVVAnalytics.track(error:AVVError), AVVPlayer passes errors to AVVAnalytics implementations
- adds additional technical error descriptions
- adds AVVMediaPlaybackChannelAVPlayerControlCenter, current playback is now shown and controlable in iOS Control Center
   can be disabled in AVVPlayerControlsConfig.isRemoteControlCenterEnabled (AVVPlayerConfig.playerControlsConfig)
- adds bind(sliderSeekPositionLabel: UILabel) to AVVPlayerControlBinding
    if you are using a custom control overlay you should bind that label to show the sliders current seek position, label is visible on slider touchDown and hidden when touchDown ends
- adds startPositionVOD to AVVPlaybackOptions (when set, player starts video at configured position)

- changes UX of AVVDefaultErrorLayer
- renames AVVPlayerControlsScheme to AVVPlayerControlsConfig
- refactors seek behaviour of AVVPlayer
    video is no longer paused on touchDown of Slider, seek command to player is only sent on touchDown end, seek experience is smoother

- fixes issues when replacing player item during initialization of current player item (e.g. :  PictureInPicture, MediaSession)
- fixes chromecast media updates are only received when request is performed without error (also when chromecast is already connected) 
- fixes issue with autoLandscapeFullscreen is set to false on iPhone (enables portrait and landscape now with autoLandscapeFullscreen = false)
- fixes release of AVVMediaSession when heartbeat is active
- fixes Chromecast updates when joining existing cast session

------

## v0.9.20 (@2021-01-18)

[iOS Only]:
- adds closed captions (needs to be configured in AVVPlayer config, for OTT usage in external player config), currently no support for captions in .m3u8 playlist files
- adds selection of Audio Tracks to AVVPlayer's PUBLIC API

- fixes issue on inline player after playback is finished (transition snapshot)
- fixes loading indicator on livestreams

------

## v0.9.19 (@2020-12-18)

- increases touch area of AVVSlider in Default Control Layer
- fixes presentation of cast dialog when clicking on chromecast button while player is in fullscreen
- fixes chromecast issues for OTT customers (check Sportradar OTT implementation guide)

------

## v0.9.18 (@2020-12-09)

- fixes control layer issue in fullscreen (iOS14.2)

Dependencies: 
[iOS Only]:
- Protobuf v3.14.0  (from v3.13.0)

------
## v0.9.17 (@2020-10-19)

- adds PictureInPicture Mode to iOS (defaultEnabled = true, configure in AVVPlayerConfig.isPicturInPictureEnabled )

- changes in Chromecast Setup for iOS 14 (Check Docs, Info.plist file needs to be modified)
- changes progress slider for HLS livestream (sets liveoffset label to "00:00" if  offset <= 10)

- fixes/refactoring heartbeat (switch between channels)
- fixes "casting" overlay on tvOS (when startet on real device)
- removes restore Button ("try again") after heartbeat validation error on heartbeat type .validateOnly --> no restoring available --> reset config and restart player


Dependencies: 
- SDWebImage v5.9.3 (from v5.8.3)
- RxSwift v5.1.1
- RxCocoa v5.1.1
- Bitmovin Analytics v1.15.0 (from v1.10.1)

[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.11.4
- google-cast-sdk v4.5.1 (from v4.4.7)
- SwiftyXMLParser v5.0.0
- Protobuf v3.13.0  (from v3.12.0)

------

## v0.9.16 (@2020-09-08)

- supports tvOS

- refactors AVVMediaSession (Decouple Cast SDK)

Dependencies: 
- SDWebImage v5.8.3 (from v5.8.1)
- RxSwift v5.1.1
- RxCocoa v5.1.1
[iOS Only]:
- GoogleAds-IMA-iOS-SDK v3.11.4
- google-cast-sdk v4.4.7
- SwiftyXMLParser v5.0.0
- Protobuf v3.12.0

------

## v0.9.15 (@2020-07-16)

- refactors Chromecast process
- implements heartbeat validation error on http 200 response

------

## v0.9.14 (@2020-06-29)

- renames Framework/Module from AVVPlayer to SRAVVPlayer
- deploys SRAVVPlayer as xcframework (requires cocoapods 1.9)

------

## v0.9.13 (@2020-06-24)

- new licence validation process (adds "domain" to AVVPlayerSetup for OTT customer)
- adds countdown view to Default Preview Layer

- moves AVVMetaData to AVVPlayerConfig (AVVPlayerConfig.MetaData)
- moves AVVPlayerConfig.autoplay  to AVVPlaybackOptions.autoplay
- adds scheduledDate to AVVPlayerConfig.status
- fixes AVVMediaSession issue (crash on access of streamdata)

------

## v0.9.12 (@2020-06-05)

- adds Watermark

- renames AVVLayerTypes

- AVVChromecast improvements/fixes
- fixes release issue of AVVPlayer
- fixes inline mode rotation issue (iPad)

------

## v0.9.11 (@2020-05-29)

- AVVPlayerControlLayerDefault: hides TimeLabels, Option Buttons and ProgressSlider on AVVSizeClass.SmartType.thumb sizeClass of AVVPlayer 
- AVVPlayerControlLayerDefault: adds Promotion Button (shows up as soon as one feature has access denied flag and isPremium == true), triggers feature layer

- fixes presentation of Presentation AVVPlayer on AppDelegate Window orientation restriction

------

## v0.9.10 (@2020-05-22)

- adds custom player messages
- implements AVVFeatureLayerDefault and grant/deny access to airplay and chromecast
- fixes Settings Overlay and Control Overlay constraint issues

------

## v0.9.9

- AVVEndscreen (if configured, shown after Media Session is completed)
- AVVSizeClass with Smart Types (provide responsive layers)
- AVVPlayerConfig properties isLivestream, isLive are moved to AVVPlayerConfig.Status
- SDK is now handling isDelivered status
- Stream status is updated in previewlayer if scheduled date is expired
