AVVPlayer-MARVIN-iOS
===================
#  Changelog
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
