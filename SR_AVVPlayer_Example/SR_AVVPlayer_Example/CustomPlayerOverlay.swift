import UIKit
import RxSwift
import GoogleCast
import AVKit
import MediaPlayer
import SRAVVPlayer

/**  if you want to provide your own player control overlay it is recommended to use AVVPlayerControlBinding to bind your custom views to AVVPlayer
    once your controls are binded, they will be updated automatically according to AVVPlayer's state and events
    you only have to setup the layout of your custom views
 
    e.g bind PlayPause Toggle Button by providing your own images
 
    self.playPauseToggleButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    self.playPauseToggleButton.setImage(UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate), forMultiState: .playing)
    self.playPauseToggleButton.setImage(UIImage(named: "play")?.withRenderingMode(.alwaysTemplate), forMultiState: .paused)
    self.playPauseToggleButton.setImage(UIImage(named: "replay")?.withRenderingMode(.alwaysTemplate), forMultiState: .videoEnded)
 
    self.controlBinding?.bind(playPauseToggle: self.playPauseToggleButton)
 
    follow this process for all controls you want to provide on your custom Player Overlay
*/

public class CustomPlayerOverlay: UIView, AVVPlayerControlLayer
{
    public var playerSizeClass: AVVSizeClass = AVVSizeClass(size: .zero)
    
    public var relatedPlayer: AVVPlayer!
    
    public var layerView: UIView!
    {
        return self
    }
    
    public var seekControlsScheme : AVVPlayerControlsScheme? {
        didSet {
            let titleTextAttributes : [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 11) as Any]
            seekBackButton.setAttributedTitle(NSAttributedString(string: "\(seekControlsScheme?.seekButtonSeconds ?? 0)", attributes: titleTextAttributes), for: .normal)
            seekForwardButton.setAttributedTitle(NSAttributedString(string: "\(seekControlsScheme?.seekButtonSeconds ?? 0)", attributes: titleTextAttributes), for: .normal)
        }
    }
    
    private var disposeBag : DisposeBag! = DisposeBag()
    private var fadingTimer : Timer?
    
    private let controlBinding: AVVPlayerControlBinding?
    
    let gestureRecognizer = UITapGestureRecognizer()
    private let contentView = UIView()
    
    private let playPauseToggleButton = AVVMultistateButton()
    private let fullscreenButton = AVVMultistateButton(type: .system)
    private let progressSlider = AVVSlider()
    private let elapsedTimeLabel = UILabel()
    private let remainingTimeLabel = UILabel()
    private let durationTimeLabel = UILabel()
    private let livestreamOffsetLabel = UILabel()
    private let seekBackButton = AVVMultistateButton(type: .system)
    private let seekForwardButton = AVVMultistateButton(type: .system)
    private let loadingView = AVVLoadingViewDefault()

    //external events stackview
    private var externalEventStackView = UIStackView()
    private var centerButtonWidthConsraint: NSLayoutConstraint?
    private var centerButtonHeightConsraint: NSLayoutConstraint?
    
    required public init(binding: AVVPlayerControlBinding) {
        self.controlBinding = binding
        super.init(frame: CGRect.zero)
        self.addSubview(contentView)
        setupFadingTimer()
        setupContentView()
        
        setupPlayPauseToggle()
        setupFullscreenButton()
        setupSlider()
        setupElapsedTimeLabel()
        setupDurationTimeLabel()
        setupLivestreamOffsetLabel()
        setupSeekBackButton()
        setupSeekForwardButton()
        setupLoadingView()

        setupExternalEventStackView()
        setupConstraints()
    }
    
    public override func layoutSubviews() {
        seekBackButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 10, right: 0)
        seekForwardButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 10, right: 0)
        
        let centerButtonSize: CGFloat = 65
     
        //centerButtonSize
        centerButtonWidthConsraint?.constant = centerButtonSize
        centerButtonHeightConsraint?.constant = centerButtonSize
    }
    
    public func reset() {
        self.disposeBag = nil
        self.fadingTimer?.invalidate()
        self.fadingTimer = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder: not implemented")
    }
    
}

// MARK: - Setup and Bind Views
extension CustomPlayerOverlay {
    
    private func setupContentView() {
        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        contentView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.rx.event.bind(onNext: { recognizer in
        
                self.fadingTimer?.invalidate()
                self.fadingTimer = nil
                self.fadeTo(alpha: self.contentView.alpha > 0 ? 0 : 1)
                self.setupFadingTimer()
        }).disposed(by: disposeBag)
    }
    
    private func setupPlayPauseToggle() {
        self.subscribeOnButtonTap(of: self.playPauseToggleButton)
        self.playPauseToggleButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.playPauseToggleButton.setImage(UIImage(named: "pause"), forMultiState: .playing)
        self.playPauseToggleButton.setImage(UIImage(named: "play"), forMultiState: .paused)
        self.playPauseToggleButton.setImage(UIImage(named: "replay"), forMultiState: .videoEnded)
        
        self.controlBinding?.bind(playPauseToggle: self.playPauseToggleButton)
        contentView.addSubview(playPauseToggleButton)
    }
    
    private func setupFullscreenButton() {
        self.subscribeOnButtonTap(of: self.fullscreenButton)
        
        self.fullscreenButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.fullscreenButton.setImage(UIImage(named: "fullscreen")?.withRenderingMode(.alwaysTemplate), forMultiState: .inline)
        self.fullscreenButton.setImage(UIImage(named: "fullscreen-back")?.withRenderingMode(.alwaysTemplate), forMultiState: .fullscreen)
        
        self.controlBinding?.bind(fullscreenToggleButton: self.fullscreenButton)
        contentView.addSubview(fullscreenButton)
    }
    
    private func setupSlider() {
        self.subscribeOnSliderEvents(of: self.progressSlider)
        
        self.controlBinding?.bind(progressSlider: progressSlider)
        contentView.addSubview(progressSlider)
    }
    
    private func setupElapsedTimeLabel() {
        self.elapsedTimeLabel.textColor = .white
        self.elapsedTimeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.controlBinding?.bind(elapsedTimeLabel: self.elapsedTimeLabel)
        contentView.addSubview(elapsedTimeLabel)
    }
    
    private func setupRemainingTimeLabel() {
        self.remainingTimeLabel.textColor = .white
        self.remainingTimeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.controlBinding?.bind(remainingTimeLabel: remainingTimeLabel)
        contentView.addSubview(remainingTimeLabel)
    }
    
    private func setupDurationTimeLabel() {
        self.durationTimeLabel.textColor = .white
        self.durationTimeLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.controlBinding?.bind(durationTimeLabel: self.durationTimeLabel)
        contentView.addSubview(durationTimeLabel)
    }
    
    private func setupLivestreamOffsetLabel() {
        self.livestreamOffsetLabel.textColor = .white
        self.livestreamOffsetLabel.font =  UIFont.boldSystemFont(ofSize:16)
        
        self.controlBinding?.bind(livestreamOffsetLabel: self.livestreamOffsetLabel)
        contentView.addSubview(self.livestreamOffsetLabel)
    }
    
    private func setupSeekBackButton() {
        self.subscribeOnButtonTap(of: self.seekBackButton)
        
        self.seekBackButton.titleLabel?.textAlignment = .center
        self.seekBackButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.seekBackButton.setImage(UIImage(named: "rewind")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.controlBinding?.bind(seekBackButton: seekBackButton)
        contentView.addSubview(seekBackButton)
    }
    
    private func setupSeekForwardButton() {
        subscribeOnButtonTap(of: self.seekForwardButton)
        
        self.seekForwardButton.titleLabel?.textAlignment = .center
        self.seekForwardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.seekForwardButton.setImage(UIImage(named: "fastforward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        self.controlBinding?.bind(seekForwardButton: seekForwardButton)
        contentView.addSubview(seekForwardButton)
    }
    
    private func setupLoadingView() {
        self.controlBinding?.bind(loadingView: self.loadingView)
        contentView.addSubview(loadingView)
    }
    
    private func setupExternalEventStackView()
    {
        self.externalEventStackView.alignment = .center
        self.externalEventStackView.distribution = .equalCentering
        self.externalEventStackView.axis = .vertical
        contentView.addSubview(externalEventStackView)
    }
}

// MARK: AVVMultistateLabelDelegate - OutputChannel
extension CustomPlayerOverlay : AVVMultistateLabelDelegate {
    public func multiState(didChangeTo state: AVVMediaSessionOutputChannel) {
        if case AVVMediaSessionOutputChannel.avPlayer = state {
            UIView.animate(withDuration: 0.33, animations: {
                self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
            self.setupFadingTimer()
        } else {
            UIView.animate(withDuration: 0.33, animations: {
                self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            })
            self.fadeTo(alpha: 1)
            self.removeTimer()
        }
    }
}

// MARK: Utility Methods
extension CustomPlayerOverlay {
    
    private func subscribeOnButtonTap(of button: UIButton) {
        button.rx.tap.subscribe(onNext: {self.resetTimer()}).disposed(by: disposeBag)
    }
    
    private func subscribeOnSliderEvents(of slider: AVVSlider) {
        slider.rx.controlEvent(.touchDown).subscribe(onNext: {
            self.fadingTimer?.invalidate()
            self.fadingTimer = nil
        }).disposed(by: disposeBag)
        slider.rx.controlEvent([.touchUpInside, .touchCancel, .touchUpOutside]).subscribe(onNext: {
            self.setupFadingTimer()
        }).disposed(by: disposeBag)
    }
    
    private func resetTimer() {
            self.fadingTimer?.invalidate()
            self.fadingTimer = nil
            self.setupFadingTimer()
    }
    
    private func setupFadingTimer() {
        self.fadingTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.fadeTo(alpha: 0)
        }
    }
    
    private func removeTimer() {
        self.fadingTimer?.invalidate()
        self.fadingTimer = nil
    }
    
    private func fadeTo(alpha: CGFloat) {
        let targetView = alpha > 0 ? self.contentView : self
        targetView.addGestureRecognizer(self.gestureRecognizer)
        UIView.animate(withDuration: 0.33) {
            self.contentView.alpha = alpha
        }
    }
}

// MARK: - Setup Constraints
extension CustomPlayerOverlay {
    
    enum DeviceTraitStatus {
        ///IPAD and others: Width: Regular, Height: Regular
        case wRhR
        ///Any IPHONE Portrait Width: Compact, Height: Regular
        case wChR
        ///IPHONE Plus/Max Landscape Width: Regular, Height: Compact
        case wRhC
        ///IPHONE landscape Width: Compact, Height: Compact
        case wChC
        
        static var current:DeviceTraitStatus{
            
            switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass){
                
            case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
                return .wRhR
            case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
                return .wChR
            case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
                return .wRhC
            case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
                return .wChC
            default:
                return .wChR
            }
        }
    }
    
    private func setupConstraints() {
        let sideOffset: CGFloat = 5
        let itemOffset: CGFloat = 8
        
        let buttonSize: CGFloat = 38
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        //centerButtons
        let centerButtonSize: CGFloat = 65
        
        playPauseToggleButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            playPauseToggleButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
            playPauseToggleButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        } else {
            playPauseToggleButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -60).isActive = true
            playPauseToggleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        
        centerButtonWidthConsraint = playPauseToggleButton.widthAnchor.constraint(equalToConstant: centerButtonSize)
        centerButtonWidthConsraint?.isActive = true
        centerButtonHeightConsraint = playPauseToggleButton.heightAnchor.constraint(equalToConstant: centerButtonSize)
        centerButtonHeightConsraint?.isActive = true
        
        seekBackButton.translatesAutoresizingMaskIntoConstraints = false
        seekBackButton.centerYAnchor.constraint(equalTo: playPauseToggleButton.centerYAnchor).isActive = true
        contentView.addConstraint(NSLayoutConstraint(item: seekBackButton, attribute: .centerX, relatedBy: .equal,
                                                     toItem: contentView, attribute: .centerX, multiplier: 0.5, constant: 0))
        seekBackButton.widthAnchor.constraint(equalTo: playPauseToggleButton.widthAnchor, multiplier: 0.75).isActive = true
        seekBackButton.heightAnchor.constraint(equalTo: playPauseToggleButton.widthAnchor, multiplier: 0.75).isActive = true
        
        seekForwardButton.translatesAutoresizingMaskIntoConstraints = false
        seekForwardButton.centerYAnchor.constraint(equalTo: playPauseToggleButton.centerYAnchor).isActive = true
        contentView.addConstraint(NSLayoutConstraint(item: seekForwardButton, attribute: .centerX, relatedBy: .equal,
                                                     toItem: contentView, attribute: .centerX, multiplier: 1.5, constant: 0))
        seekForwardButton.widthAnchor.constraint(equalTo: playPauseToggleButton.widthAnchor, multiplier: 0.75).isActive = true
        seekForwardButton.heightAnchor.constraint(equalTo: playPauseToggleButton.widthAnchor, multiplier: 0.75).isActive = true
        
        //progress items
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: sideOffset*2).isActive = true
        } else {
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideOffset*2).isActive = true
        }
        elapsedTimeLabel.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor).isActive = true
        
        livestreamOffsetLabel.translatesAutoresizingMaskIntoConstraints = false
        livestreamOffsetLabel.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor).isActive = true
        livestreamOffsetLabel.leadingAnchor.constraint(equalTo: elapsedTimeLabel.leadingAnchor).isActive = true
        
        progressSlider.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            progressSlider.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: sideOffset*2).isActive = true
        } else {
            progressSlider.topAnchor.constraint(equalTo: self.topAnchor, constant: sideOffset*2).isActive = true
        }
        progressSlider.leadingAnchor.constraint(equalTo: livestreamOffsetLabel.trailingAnchor, constant: itemOffset).isActive = true
        progressSlider.trailingAnchor.constraint(equalTo: durationTimeLabel.leadingAnchor, constant: -itemOffset).isActive = true
        
        durationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        durationTimeLabel.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor).isActive = true
        durationTimeLabel.trailingAnchor.constraint(equalTo: fullscreenButton.leadingAnchor, constant: -itemOffset/2).isActive = true
        
        fullscreenButton.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            fullscreenButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sideOffset/2).isActive = true
        } else {
            fullscreenButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideOffset/2).isActive = true
        }
        fullscreenButton.centerYAnchor.constraint(equalTo: elapsedTimeLabel.centerYAnchor).isActive = true
        fullscreenButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        fullscreenButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        //External Display Buttons
        externalEventStackView.translatesAutoresizingMaskIntoConstraints = false
        externalEventStackView.centerYAnchor.constraint(equalTo: playPauseToggleButton.centerYAnchor).isActive = true
        if #available(iOS 11.0, *) {
            externalEventStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -sideOffset).isActive = true
        } else {
            externalEventStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideOffset).isActive = true
        }
        externalEventStackView.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        //loadingView
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            loadingView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        } else {
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
}
