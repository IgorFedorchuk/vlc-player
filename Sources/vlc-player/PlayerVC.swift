//
//  PlayerVC.swift
//  m3u8player
//
//  Created by Igor Fedorchuk on 27.03.2024.
//

import AVFoundation
import AVKit
import Foundation
import MediaPlayer
import VLCKitSPM

open class PlayerVC: UIViewController {
    open var controlStackView: UIStackView = {
        let view = UIStackView(frame: CGRect.zero)
        view.backgroundColor = .clear
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect.zero)
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var backVideoView: UIView = {
        let view = UIView(frame: CGRect.zero)
        return view
    }()

    open var playControlView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var closeButtonTopConstraint: NSLayoutConstraint?
    open var volumeTrailingConstraint: NSLayoutConstraint?
    open var brightnessLeadingConstraint: NSLayoutConstraint?
    open var nameLabelTopConstraint: NSLayoutConstraint?

    open var volumeStackView: UIStackView = {
        let view = UIStackView(frame: CGRect.zero)
        view.backgroundColor = .clear
        view.spacing = 10
        view.transform = CGAffineTransform(rotationAngle: .pi / -2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var volumeSlider: UISlider = {
        let slider = UISlider(frame: CGRect.zero)
        slider.tintColor = UIColor.white
        slider.backgroundColor = .clear
        slider.minimumTrackTintColor = UIColor.white
        slider.maximumTrackTintColor = UIColor.color(r: 0, g: 0, b: 0, a: 0.4)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = AVAudioSession.sharedInstance().outputVolume
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.thumbTintColor = .white
        return slider
    }()

    open var brightnessStackView: UIStackView = {
        let view = UIStackView(frame: CGRect.zero)
        view.backgroundColor = .clear
        view.spacing = 10
        view.transform = CGAffineTransform(rotationAngle: .pi / -2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    open var brightnessSlider: UISlider = {
        let slider = UISlider(frame: CGRect.zero)
        slider.tintColor = UIColor.white
        slider.backgroundColor = .clear
        slider.minimumTrackTintColor = UIColor.white
        slider.maximumTrackTintColor = UIColor.color(r: 0, g: 0, b: 0, a: 0.4)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.thumbTintColor = .white
        slider.value = Float(UIScreen.main.brightness)
        return slider
    }()

    open var closeButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.setImage(UIImage(imageName: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var playForwardButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "play-forward")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var playBackButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "play-back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var soundButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        return button
    }()
    
    open var epgButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setTitle("EPG", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitleColor(.gray, for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var playPauseButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var airplayButton: AVRoutePickerView = {
        let button = AVRoutePickerView(frame: CGRect.zero)
        button.tintColor = UIColor.white
        if #available(iOS 13.0, *) {
            button.prioritizesVideoDevices = true
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var pauseTimerButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "timer")?.withRenderingMode(.alwaysTemplate), for: .normal)
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var shareButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "share")?.withRenderingMode(.alwaysTemplate), for: .normal)
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var favoriteButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "favorite")?.withRenderingMode(.alwaysTemplate), for: .normal)
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var lockOrientationButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "lock-orientation")?.withRenderingMode(.alwaysTemplate), for: .normal)
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var pipButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "picture-in-picture")?.withRenderingMode(.alwaysTemplate), for: .normal)
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: inset, bottom: inset, right: inset)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    open var fullScreenButton: UIButton = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = .clear
        button.tintColor = .white
        button.setImage(UIImage(imageName: "full-screen")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(8)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: inset, bottom: 6, right: inset)
        return button
    }()

    open var errorLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    open var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    public var progressBarView: ProgressBarView = {
        let progressBarView = ProgressBarView()
        progressBarView.backgroundColor = .clear
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        return progressBarView
    }()

    open var needCloseOnPipPressed = false
    open var needShowFavoriteButton = false
    open var needShowShareButton = false
    open var needShowEpgButton = false
    open var needShowLockOrientationButton = true
    open var isRotationLocked = false
    open var lockedOrientations = UIInterfaceOrientationMask.allButUpsideDown

    public var constant = Constant()
    public var onFavoritePressed: ((Stream) -> Bool)?
    public var onViewDidLoad: (() -> Void)?
    public var onError: ((Stream, Error?) -> Void)?
    public var onNextStream: ((Stream) -> Void)?
    public var onPreviousStream: ((Stream) -> Void)?
    public var onShareStream: ((Stream) -> String)?
    public var onEpgTapped: ((Stream) -> Void)?
    public var onEpgChanged: ((Stream) -> Void)?

    public var onPipStarted: ((PipModel, [PlayerVC.Stream], Int) -> Void)?

    private var isFullScreenMode = false
    private var isPlayControlHidden = false
    private var isAvPlayerStoppedWithError = false
    private var wasVLCStopped = false
    private var wasVLCFirstStopSkiped = false

    private static var _vlcPlayer = VLCMediaPlayer()
    private var vlcPlayer = _vlcPlayer

    private var playerItem: AVPlayerItem?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var pipController: AVPictureInPictureController?
    private var pipModel: PipModel?
    private var pauseTimer: Timer?
    private var timeObserver: Timer?

    private var hideControlsTimer: Timer?
    private var streams: [PlayerVC.Stream]
    private var currentIndex: Int
    private var isObservingPlayer = false

    private var isPlaying: Bool {
        if isAvPlayerStoppedWithError {
            return vlcPlayer.isPlaying
        }
        return player?.rate != 0
    }

    open var windowInterfaceOrientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }

    public init(streams: [PlayerVC.Stream], currentIndex: Int, pipModel: PipModel?) {
        self.streams = streams
        self.currentIndex = currentIndex
        self.pipModel = pipModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        invalidatePauseTimer()
        invalidateHideControlsTimer()
        removePeriodicTimeObserver()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupControls()
        subscribeToNotifications()
        if let windowInterfaceOrientation = windowInterfaceOrientation {
            updateIndents(isLandscape: windowInterfaceOrientation.isLandscape)
        }
        if let pauseTimeInterval = pipModel?.pauseTimeInterval {
            schedulePauseTimer(timeInterval: pauseTimeInterval)
        }
        onViewDidLoad?()
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayer()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removePlayerObservers()
        removePeriodicTimeObserver()
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return lockedOrientations
    }

    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        switch lockedOrientations {
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        default:
            return .portrait
        }
    }

    override open var shouldAutorotate: Bool {
        return !isRotationLocked
    }

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self, let windowInterfaceOrientation = self.windowInterfaceOrientation else {
                return
            }
            updateIndents(isLandscape: windowInterfaceOrientation.isLandscape)
            setupVideoGravity()
        })
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context _: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayer.timeControlStatus), let change = change,
           let newValue = change[NSKeyValueChangeKey.newKey] as? Int
        {
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)

            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if newStatus == .playing || newStatus == .paused {
                    loader.stopAnimating()
                    if newStatus == .playing && playerLayer?.videoRect == CGRectZero {
                        isAvPlayerStoppedWithError = true
                        setupPlayer()
                    }
                } else {
                    loader.startAnimating()
                }
            }
        } else if let playerItem = object as? AVPlayerItem, keyPath == #keyPath(AVPlayerItem.status), playerItem.status == .failed {
            isAvPlayerStoppedWithError = true
            setupPlayer()
        } else if keyPath == #keyPath(AVAudioSession.outputVolume) {
            updateBrighnessAndVolume()
        }
    }

    open func startPlayer() {
        setupPlayer()
    }
}

extension PlayerVC {
    private func addPlayerObservers() {
        guard !isObservingPlayer else { return }
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: nil)
        player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options: [.old, .new], context: nil)
        AVAudioSession.sharedInstance().addObserver(self, forKeyPath: #keyPath(AVAudioSession.outputVolume), options: NSKeyValueObservingOptions.new, context: nil)
        isObservingPlayer = true
    }

    private func removePlayerObservers() {
        guard isObservingPlayer else { return }
        player?.removeObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus))
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: #keyPath(AVAudioSession.outputVolume))
        isObservingPlayer = false
    }

    private func proccessError() {
        errorLabel.text = constant.errorText
        errorLabel.isHidden = false
        playPauseButton.setImage(UIImage(imageName: constant.playImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        onError?(streams[currentIndex], player?.currentItem?.error)
    }

    private func setupCloseButton() {
        playControlView.addSubview(closeButton)
        closeButton.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        closeButton.leftAnchor.constraint(equalTo: playControlView.leftAnchor, constant: 16).isActive = true
        closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: playControlView.topAnchor, constant: constant.buttonsTopIndentPortrait)
        closeButtonTopConstraint?.isActive = true
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }

    @objc private func closeButtonPressed() {
        player?.pause()
        vlcPlayer.stop()
        dismiss(animated: true)
    }

    private func setupPlayPauseButton() {
        setupPlayPauseImage(false)
        playControlView.addSubview(playPauseButton)
        playPauseButton.widthAnchor.constraint(equalToConstant: constant.playButtonWidth).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: constant.playButtonWidth).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: playControlView.centerXAnchor, constant: 0).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 0).isActive = true
        playPauseButton.addTarget(self, action: #selector(playPauseButtonPressed), for: .touchUpInside)
    }

    @objc private func playPauseButtonPressed() {
        startHideControlsTimer()
        guard errorLabel.isHidden else {
            errorLabel.isHidden = true
            setupPlayer()
            return
        }

        if isAvPlayerStoppedWithError {
            setupPlayPauseImage(isPlaying)
            if isPlaying {
                vlcPlayer.pause()
            } else if wasVLCStopped {
                setupPlayer()
            } else {
                vlcPlayer.play()
                addPeriodicTimeObserver()
            }
        } else {
            setupPlayPauseImage(isPlaying)
            if player?.rate == 0 {
                player?.play()
                addPeriodicTimeObserver()
            } else {
                player?.pause()
            }
        }
    }

    private func setupPlayPauseImage(_ isPlaying: Bool) {
        let imageName: String
        if isPlaying {
            imageName = constant.playImageName
        } else {
            imageName = constant.pauseImageName
        }
        playPauseButton.setImage(UIImage(imageName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    private func setupPauseTimerButton() {
        pauseTimerButton.addTarget(self, action: #selector(pauseTimerButtonPressed), for: .touchUpInside)
        controlStackView.addArrangedSubview(pauseTimerButton)
        pauseTimerButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    @objc private func pauseTimerButtonPressed() {
        if let pauseTimer {
            let remainingTimeInterval = pauseTimer.fireDate.timeIntervalSince(Date())
            showPauseTimer(Int(remainingTimeInterval))
        } else {
            showPauseTimer()
        }
    }

    private func showPauseTimer(_ seconds: Int) {
        var remainingSeconds = seconds

        let alert = UIAlertController(title: countDownPauseTimerTitle(seconds: remainingSeconds), message: nil, preferredStyle: .alert)
        alert.view.tintColor = .black
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            remainingSeconds -= 1
            alert.title = self?.countDownPauseTimerTitle(seconds: remainingSeconds)
            if remainingSeconds <= 0 {
                timer.invalidate()
                alert.dismiss(animated: true, completion: {})
            }
        }
        alert.addAction(UIAlertAction(title: constant.timerCancelButtonText, style: .cancel, handler: { _ in
            timer.invalidate()
        }))
        alert.addAction(UIAlertAction(title: constant.timerStopButtonText, style: .destructive, handler: { [weak self] _ in
            timer.invalidate()
            self?.invalidatePauseTimer()
        }))

        present(alert, animated: true, completion: nil)
    }

    private func countDownPauseTimerTitle(seconds: Int) -> String {
        return "\(constant.timerTitle)\n\(formatTime(seconds: seconds))"
    }

    private func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }

    private func schedulePauseTimer(timeInterval: TimeInterval) {
        invalidatePauseTimer()
        pauseTimerButton.tintColor = constant.buttonActiveTintColor
        pauseTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            self?.vlcPlayer.pause()
            self?.player?.pause()
            self?.setupPlayPauseImage(true)
            self?.invalidatePauseTimer()
        }
    }

    private func showPauseTimer() {
        let alert = UIAlertController(title: constant.timerTitle, message: nil, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.countDownDuration = TimeInterval(constant.defaultCountDownDuration)
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        let containerView = UIView()
        containerView.addSubview(datePicker)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let width: CGFloat = 270
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: width),
        ])

        let containerHeight: CGFloat = 150
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: width).isActive = true

        alert.view.addSubview(containerView)
        alert.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50),
            containerView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50),
        ])

        alert.addAction(UIAlertAction(title: constant.timerCancelButtonText, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: constant.timerOkButtonText, style: .default, handler: { [weak self] _ in
            self?.schedulePauseTimer(timeInterval: datePicker.countDownDuration)
        }))

        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: containerHeight + 150)
        alert.view.addConstraint(height)
        present(alert, animated: true, completion: nil)
    }

    private func invalidatePauseTimer() {
        pauseTimer?.invalidate()
        pauseTimer = nil
        pauseTimerButton.tintColor = .white
    }

    private func setupPlayAirplayButton() {
        controlStackView.addArrangedSubview(airplayButton)
        airplayButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    private func setupShareButton() {
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        if needShowShareButton {
            controlStackView.addArrangedSubview(shareButton)
        }
        shareButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    @objc private func shareButtonPressed() {
        let stream = streams[currentIndex]
        let sharedText = onShareStream?(stream) ?? stream.url.absoluteString
        let activityViewController = UIActivityViewController(activityItems: [sharedText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = shareButton
        present(activityViewController, animated: true, completion: nil)
    }

    private func setupFavoriteButton() {
        setFavoriteButtonColor(streams[currentIndex].isFavorite)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        if needShowFavoriteButton {
            controlStackView.addArrangedSubview(favoriteButton)
        }
        favoriteButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    @objc private func favoriteButtonPressed() {
        let isFavorite = onFavoritePressed?(streams[currentIndex]) == true
        streams[currentIndex].isFavorite = isFavorite
        setFavoriteButtonColor(isFavorite)
    }

    private func setFavoriteButtonColor(_ isFavorite: Bool) {
        favoriteButton.tintColor = isFavorite ? constant.buttonActiveTintColor : .white
    }

    private func setupLockOrientationButton() {
        if needShowLockOrientationButton {
            lockOrientationButton.tintColor = isRotationLocked ? constant.buttonActiveTintColor : .white
            lockOrientationButton.addTarget(self, action: #selector(lockOrientationButtonPressed), for: .touchUpInside)
            controlStackView.addArrangedSubview(lockOrientationButton)
            lockOrientationButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        }
    }

    @objc private func lockOrientationButtonPressed() {
        isRotationLocked = !isRotationLocked
        lockOrientationButton.tintColor = isRotationLocked ? constant.buttonActiveTintColor : .white
        if isRotationLocked {
            var currentOrientation = UIApplication.shared.statusBarOrientation
            if #available(iOS 13.0, *) {
                if let windowScene = view.window?.windowScene {
                    currentOrientation = windowScene.interfaceOrientation
                }
            }
            switch currentOrientation {
            case .portrait:
                lockedOrientations = UIInterfaceOrientationMask.portrait
            case .landscapeLeft:
                lockedOrientations = UIInterfaceOrientationMask.landscapeLeft
            case .landscapeRight:
                lockedOrientations = UIInterfaceOrientationMask.landscapeRight
            default:
                lockedOrientations = UIInterfaceOrientationMask.portrait
            }
        } else {
            lockedOrientations = UIInterfaceOrientationMask.allButUpsideDown
        }

        if #available(iOS 16.0, *) {
            setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }

    private func setupPlayPipButton() {
        pipButton.addTarget(self, action: #selector(playPipButtonPressed), for: .touchUpInside)
        if AVPictureInPictureController.isPictureInPictureSupported() {
            controlStackView.addArrangedSubview(pipButton)
        }

        pipButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    @objc private func playPipButtonPressed() {
        guard let pipController = pipController, let player = player, pipController.isPictureInPicturePossible else { return }
        if pipController.isPictureInPictureActive {
            pipController.stopPictureInPicture()
        } else {
            onPipStarted?(PipModel(pipController: pipController, player: player, pauseTimeInterval: pauseTimer?.fireDate.timeIntervalSince(Date())), streams, currentIndex)
            pipController.startPictureInPicture()
            if needCloseOnPipPressed {
                dismiss(animated: true)
            }
        }
    }

    private func setupFullScreenButton() {
        fullScreenButton.addTarget(self, action: #selector(fullScreenButtonPressed), for: .touchUpInside)
        controlStackView.addArrangedSubview(fullScreenButton)
        fullScreenButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
    }

    @objc private func fullScreenButtonPressed() {
        isFullScreenMode = !isFullScreenMode
        setupVideoGravity()
        startHideControlsTimer()
    }

    private func setupSoundButtonImage() {
        if isAvPlayerStoppedWithError {
            guard let auduo = vlcPlayer.audio else { return }
            let imageName = auduo.isMuted ? constant.soundOffImageName : constant.soundOnImageName
            soundButton.setImage(UIImage(imageName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            let player = player ?? pipModel?.player
            guard let player = player else { return }
            let imageName = player.volume == 0 ? constant.soundOffImageName : constant.soundOnImageName
            soundButton.setImage(UIImage(imageName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    private func setupSoundButton() {
        soundButton.setImage(UIImage(imageName: constant.soundOnImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        soundButton.addTarget(self, action: #selector(soundButtonPressed), for: .touchUpInside)
        playControlView.addSubview(soundButton)
        soundButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        soundButton.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        soundButton.rightAnchor.constraint(equalTo: playControlView.rightAnchor, constant: -16).isActive = true
        soundButton.topAnchor.constraint(equalTo: closeButton.topAnchor, constant: 0).isActive = true
    }
    
    @objc private func soundButtonPressed() {
        startHideControlsTimer()
        player?.volume = player?.volume == 0 ? 1 : 0
        if let auduo = vlcPlayer.audio {
            auduo.isMuted = !auduo.isMuted
        }
        setupSoundButtonImage()
    }
    
    private func setupEpgButton() {
        guard needShowEpgButton else {
            return
        }
        setupEpgButtonVisibility()
        epgButton.addTarget(self, action: #selector(epgButtonPressed), for: .touchUpInside)
        playControlView.addSubview(epgButton)
        epgButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        epgButton.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        epgButton.rightAnchor.constraint(equalTo: playControlView.rightAnchor, constant: -16).isActive = true
        epgButton.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 2).isActive = true
    }
    
    @objc private func epgButtonPressed() {
        onEpgTapped?(streams[currentIndex])
    }
    

    private func setupPlayControlViewColor() {
        playControlView.backgroundColor = isPlayControlHidden ? UIColor.clear : constant.backColor
    }

    private func setupPlayControlView() {
        view.addSubview(playControlView)
        playControlView.fillSuperview()
        setupPlayControlViewColor()
        let tapGesture = UITapGestureRecognizer()
        playControlView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(playControlViewPressed))
        startHideControlsTimer()
    }

    @objc private func playControlViewPressed() {
        isPlayControlHidden = !isPlayControlHidden
        setupPlayControlViewColor()
        updateBrighnessAndVolume()
        manageControls()
        invalidateHideControlsTimer()
        if !isPlayControlHidden {
            startHideControlsTimer()
        }
    }

    private func startHideControlsTimer() {
        invalidateHideControlsTimer()
        hideControlsTimer = Timer.scheduledTimer(withTimeInterval: constant.hideControlsTimeInterval, repeats: false) { [weak self] _ in
            self?.isPlayControlHidden = true
            self?.manageControls()
            self?.invalidateHideControlsTimer()
        }
    }

    private func manageControls() {
        for subview in playControlView.subviews where subview != errorLabel {
            subview.isHidden = isPlayControlHidden
        }
    }

    private func invalidateHideControlsTimer() {
        hideControlsTimer?.invalidate()
        hideControlsTimer = nil
    }

    private func setupControlStackView() {
        playControlView.addSubview(controlStackView)
        controlStackView.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        controlStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        controlStackView.centerXAnchor.constraint(equalTo: playControlView.centerXAnchor, constant: 0).isActive = true
    }

    private func setupErrorLabel() {
        playControlView.addSubview(errorLabel)
        errorLabel.centerXAnchor.constraint(equalTo: playControlView.centerXAnchor, constant: 0).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 80).isActive = true
    }

    @objc private func playForwardButtonPressed() {
        startHideControlsTimer()
        let nextIndex = currentIndex + 1
        if nextIndex < streams.count {
            currentIndex = nextIndex
            isAvPlayerStoppedWithError = false
            setupPlayer()
            setFavoriteButtonColor(streams[currentIndex].isFavorite)
        }
        setupPlayBackForwardButtonColor()
        onNextStream?(streams[currentIndex])
    }

    @objc private func playBackButtonPressed() {
        startHideControlsTimer()
        let nextIndex = currentIndex - 1
        if nextIndex >= 0, nextIndex < streams.count {
            currentIndex = nextIndex
            isAvPlayerStoppedWithError = false
            setupPlayer()
            setFavoriteButtonColor(streams[currentIndex].isFavorite)
        }
        setupPlayBackForwardButtonColor()
        onPreviousStream?(streams[currentIndex])
    }

    private func setupPlayBackForwardButtonColor() {
        playForwardButton.tintColor = currentIndex == streams.count - 1 ? UIColor.gray : UIColor.white
        playBackButton.tintColor = currentIndex == 0 ? UIColor.gray : UIColor.white
    }

    private func setupPlayForwardButton() {
        setupPlayBackForwardButtonColor()
        playControlView.addSubview(playForwardButton)
        playForwardButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        playForwardButton.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        playForwardButton.centerXAnchor.constraint(equalTo: playControlView.centerXAnchor, constant: constant.playButtonIndent).isActive = true
        playForwardButton.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 0).isActive = true
        playForwardButton.addTarget(self, action: #selector(playForwardButtonPressed), for: .touchUpInside)
    }

    private func setupPlayBackButton() {
        setupPlayBackForwardButtonColor()
        playControlView.addSubview(playBackButton)
        playBackButton.widthAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        playBackButton.heightAnchor.constraint(equalToConstant: constant.buttonWidth).isActive = true
        playBackButton.centerXAnchor.constraint(equalTo: playControlView.centerXAnchor, constant: -constant.playButtonIndent).isActive = true
        playBackButton.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 0).isActive = true
        playBackButton.addTarget(self, action: #selector(playBackButtonPressed), for: .touchUpInside)
    }

    private func setupNameLabel() {
        nameLabel.text = streams[currentIndex].name
        playControlView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: soundButton.leadingAnchor, constant: -8).isActive = true
        nameLabelTopConstraint = nameLabel.topAnchor.constraint(equalTo: playControlView.topAnchor, constant: constant.nameLabelTopIndentPortrait)
        nameLabelTopConstraint?.isActive = true
    }

    private func setupLoader() {
        loader.color = .white
        view.addSubview(loader)
        loader.startAnimating()
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loader.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
    }

    private func recreateBackVideoView() {
        backVideoView.removeFromSuperview()
        backVideoView = UIView(frame: CGRect.zero)
        backVideoView.backgroundColor = .clear
        backVideoView.isUserInteractionEnabled = false
        backVideoView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backVideoView, at: 0)
        backVideoView.fillSuperview()
    }

    private func setupControls() {
        recreateBackVideoView()
        setupLoader()
        setupPlayControlView()
        setupCloseButton()
        setupControlStackView()
        setupPlayPauseButton()
        setupPlayAirplayButton()
        setupPlayPipButton()
        setupFullScreenButton()
        setupPauseTimerButton()
        setupFavoriteButton()
        setupLockOrientationButton()
        setupShareButton()
        setupSoundButton()
        setupEpgButton()
        setupErrorLabel()
        setupPlayForwardButton()
        setupPlayBackButton()
        setupNameLabel()
        setupProgressBar()
        setupBrightnessSlider()
        setupVolumeSlider()
    }

    private func setupProgressBar() {
        progressBarView.onStartDragging = { [weak self] _ in
            self?.removePeriodicTimeObserver()
            self?.invalidateHideControlsTimer()
        }
        progressBarView.onEndDragging = { [weak self] _ in
            self?.startHideControlsTimer()
            if self?.isPlaying == true {
                self?.addPeriodicTimeObserver()
            }
        }
        progressBarView.onChangeValue = { [weak self] value in
            self?.progressBarValueDidChange(value)
        }

        playControlView.addSubview(progressBarView)
        progressBarView.leadingAnchor.constraint(equalTo: playControlView.leadingAnchor, constant: 8).isActive = true
        progressBarView.trailingAnchor.constraint(equalTo: playControlView.trailingAnchor, constant: -8).isActive = true
        progressBarView.bottomAnchor.constraint(equalTo: controlStackView.topAnchor, constant: -8).isActive = true
        progressBarView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }

    private func getBufferDuration() -> Double {
        guard let timeRange = playerItem?.seekableTimeRanges.last?.timeRangeValue else {
            return 0
        }
        let start = CMTimeGetSeconds(timeRange.start)
        let duration = CMTimeGetSeconds(timeRange.duration)
        return start + duration
    }

    @objc private func progressBarValueDidChange(_ value: Float) {
        if isAvPlayerStoppedWithError {
            let totalDuration = vlcPlayer.media?.length.intValue ?? 0
            if totalDuration > 0 {
                let newPosition = value * Float(totalDuration)
                vlcPlayer.time = VLCTime(int: Int32(newPosition))
            }
            return
        }

        let bufferDuration = getBufferDuration()
        var newTime: Double? = 0
        if let duration = playerItem?.duration.seconds, duration > 0 {
            newTime = Double(value) * duration
        } else if bufferDuration > 0 {
            newTime = Double(value) * bufferDuration
        }

        if let newTime, newTime > 0 {
            let seekTime = CMTime(seconds: newTime, preferredTimescale: constant.preferredTimescale)
            if seekTime != CMTime.invalid {
                player?.seek(to: seekTime)
            }
        }
    }

    private func setupVideoGravity() {
        if isAvPlayerStoppedWithError {
            vlcPlayer.videoAspectRatio = nil
            let screenSize = backVideoView.bounds.size
            let videoSize = vlcPlayer.videoSize
            if isFullScreenMode, screenSize.height > 0, screenSize.width > 0, videoSize.height > 0, videoSize.width > 0 {
                let ar = videoSize.width / videoSize.height
                let dar = screenSize.width / screenSize.height

                let scale: CGFloat
                if dar >= ar {
                    scale = screenSize.width / videoSize.width
                } else {
                    scale = screenSize.height / videoSize.height
                }
                vlcPlayer.scaleFactor = Float(scale * UIScreen.main.scale)
            } else {
                vlcPlayer.scaleFactor = 0
            }
        } else {
            playerLayer?.videoGravity = isFullScreenMode ? .resizeAspectFill : .resizeAspect
        }
    }

    private func addPeriodicTimeObserver() {
        removePeriodicTimeObserver()
        timeObserver = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }

    private func removePeriodicTimeObserver() {
        timeObserver?.invalidate()
        timeObserver = nil
    }

    @objc private func updateSlider() {
        if isAvPlayerStoppedWithError {
            let currentTime = Int(vlcPlayer.time.intValue) / 1000
            let duration = Int(vlcPlayer.media?.length.intValue ?? 0) / 1000
            if duration > 0 {
                let progress = Float(currentTime) / Float(duration)
                progressBarView.set(value: progress, startSecond: currentTime, endSecond: Int(max(currentTime, duration)))
            } else {
                progressBarView.set(value: 0, startSecond: 0, endSecond: 0)
            }
        } else if let duration = playerItem?.duration.seconds, duration > 0 {
            let currentTime = playerItem?.currentTime().seconds ?? 0
            let progress = currentTime / duration
            progressBarView.set(value: Float(progress), startSecond: Int(currentTime), endSecond: Int(max(currentTime, duration)))
        } else if let currentTime = playerItem?.currentTime().seconds {
            let duration = getBufferDuration()
            if duration > 0 {
                let progress = currentTime / duration
                progressBarView.set(value: Float(progress), startSecond: Int(currentTime), endSecond: Int(max(currentTime, duration)))
            } else {
                progressBarView.set(value: 0, startSecond: 0, endSecond: 0)
            }
        }
    }

    private func setupBrightnessSlider() {
        brightnessSlider.addTarget(self, action: #selector(brightnessSliderValueDidChange(_:)), for: .valueChanged)
        brightnessStackView.addArrangedSubview(brightnessSlider)
        playControlView.addSubview(brightnessStackView)
        brightnessSlider.widthAnchor.constraint(equalToConstant: 250).isActive = true
        brightnessSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        brightnessStackView.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 0).isActive = true
        brightnessLeadingConstraint = brightnessSlider.leadingAnchor.constraint(equalTo: playControlView.leadingAnchor, constant: -constant.sliderIndentPortrait)
        brightnessLeadingConstraint?.isActive = true

        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .white
        imageView.image = UIImage(imageName: "brightness")?.withRenderingMode(.alwaysTemplate)
        imageView.transform = CGAffineTransformMakeRotation(Double.pi / 2)
        brightnessStackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    @objc private func brightnessSliderValueDidChange(_ sender: UISlider) {
        UIScreen.main.brightness = CGFloat(sender.value)
    }

    private func setupVolumeSlider() {
        volumeSlider.addTarget(self, action: #selector(volumeSliderValueDidChange(_:)), for: .valueChanged)
        volumeStackView.addArrangedSubview(volumeSlider)
        playControlView.addSubview(volumeStackView)
        volumeSlider.widthAnchor.constraint(equalToConstant: 250).isActive = true
        volumeSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        volumeStackView.centerYAnchor.constraint(equalTo: playControlView.centerYAnchor, constant: 0).isActive = true
        volumeTrailingConstraint = volumeStackView.trailingAnchor.constraint(equalTo: playControlView.trailingAnchor, constant: constant.sliderIndentPortrait)
        volumeTrailingConstraint?.isActive = true

        let imageView = UIImageView(frame: .zero)
        imageView.tintColor = .white
        imageView.image = UIImage(imageName: "volume")?.withRenderingMode(.alwaysTemplate)
        imageView.transform = CGAffineTransformMakeRotation(Double.pi / 2)
        volumeStackView.addArrangedSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main, using: { [weak self] _ in
            self?.updateBrighnessAndVolume()
        })

        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main, using: { [weak self] _ in
            if let player = self?.player {
                let isPlaying = player.rate > 0
                self?.setupPlayPauseImage(!isPlaying)
            } else {
                let isPlaying = self?.vlcPlayer.isPlaying == true
                self?.setupPlayPauseImage(!isPlaying)
            }
        })
    }

    private func updateBrighnessAndVolume() {
        brightnessSlider.value = Float(UIScreen.main.brightness)
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
    }

    @objc private func volumeSliderValueDidChange(_ sender: UISlider) {
        MPVolumeView.setVolume(sender.value)
        player?.volume = 1
        if let auduo = vlcPlayer.audio {
            auduo.isMuted = false
        }
        setupSoundButtonImage()
    }

    private func setupVLCMediaPLayer(url: URL) {
        vlcPlayer.delegate = self
        vlcPlayer.drawable = backVideoView
        vlcPlayer.media = VLCMedia(url: url)
        vlcPlayer.play()
    }

    private func updateIndents(isLandscape: Bool) {
        closeButtonTopConstraint?.constant = isLandscape ? constant.buttonsTopIndentLandscape : constant.buttonsTopIndentPortrait
        brightnessLeadingConstraint?.constant = isLandscape ? -constant.sliderIndentLandscape : -constant.sliderIndentPortrait
        volumeTrailingConstraint?.constant = isLandscape ? constant.sliderIndentLandscape : constant.sliderIndentPortrait
        nameLabelTopConstraint?.constant = isLandscape ? constant.nameLabelTopIndentLandscape : constant.nameLabelTopIndentPortrait
    }

    private func setupEpgButtonVisibility() {
        onEpgChanged?(streams[currentIndex])
    }
    
    private func setupPlayer() {
        removePeriodicTimeObserver()
        removePlayerObservers()
        player?.pause()
        player = nil
        playerItem = nil
        vlcPlayer.stop()
        vlcPlayer.drawable = nil
        wasVLCStopped = false
        wasVLCFirstStopSkiped = false
        progressBarView.set(value: 0, startSecond: 0, endSecond: 0)
        playerLayer?.removeFromSuperlayer()
        recreateBackVideoView()
        setupEpgButtonVisibility()

        let urlString = streams[currentIndex].url.absoluteString.replacingSuffixIfCan(of: ".ts", with: ".m3u8")
        guard let url = URL(string: urlString) else {
            proccessError()
            return
        }

        if isAvPlayerStoppedWithError {
            pipButton.isEnabled = false
            setupVLCMediaPLayer(url: url)
        } else {
            pipButton.isEnabled = true
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: nil)
            player = pipModel?.player ?? AVPlayer(playerItem: playerItem)
            self.playerItem = pipModel?.player.currentItem ?? playerItem
            addPlayerObservers()
            let playerLayer = pipModel?.pipController.playerLayer ?? AVPlayerLayer(player: player)
            playerLayer.frame = backVideoView.bounds
            backVideoView.layer.addSublayer(playerLayer)
            self.playerLayer = playerLayer
            setupVideoGravity()
            if AVPictureInPictureController.isPictureInPictureSupported() {
                pipController = AVPictureInPictureController(playerLayer: playerLayer)
            }
            player?.play()
        }

        addPeriodicTimeObserver()
        errorLabel.isHidden = true
        playPauseButton.setImage(UIImage(imageName: constant.pauseImageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        pipModel = nil
        nameLabel.text = streams[currentIndex].name
    }
}

extension PlayerVC: VLCMediaPlayerDelegate {
    public func mediaPlayerStateChanged(_: Notification) {
        switch vlcPlayer.state {
        case .paused:
            setupPlayPauseImage(true)
            loader.stopAnimating()
        case .stopped:
            if wasVLCFirstStopSkiped { // does not need to change image, because first Notification is always stop
                setupPlayPauseImage(true)
                loader.stopAnimating()
                wasVLCStopped = true
            }
            wasVLCFirstStopSkiped = true
        case .opening:
            loader.startAnimating()
        case .buffering:
            break
        case .playing:
            wasVLCStopped = false
            loader.stopAnimating()
            if !progressBarView.isDragging {
                setupPlayPauseImage(false)
            }
        case .error:
            proccessError()
            loader.stopAnimating()
            setupPlayPauseImage(true)
        default:
            loader.stopAnimating()
        }
    }
}

public extension PlayerVC {
    struct Constant {
        public var hideControlsTimeInterval: CGFloat = 10.0
        public var playButtonWidth: CGFloat = 60
        public var buttonWidth: CGFloat = 40
        public var buttonsIndent: CGFloat = 10
        public var playButtonIndent: CGFloat = 80
        public var buttonsTopIndentPortrait: CGFloat = 50
        public var buttonsTopIndentLandscape: CGFloat = 10
        public var nameLabelTopIndentPortrait: CGFloat = 60
        public var nameLabelTopIndentLandscape: CGFloat = 20
        public var sliderIndentPortrait: CGFloat = 90
        public var sliderIndentLandscape: CGFloat = 0
        public var preferredTimescale: CMTimeScale = 600
        public var pauseImageName = "pause"
        public var playImageName = "play"
        public var soundOnImageName = "sound-on"
        public var soundOffImageName = "sound-off"
        public var outputVolume = "outputVolume"
        public var backColor = UIColor.color(r: 0, g: 0, b: 0, a: 0.2)
        public var defaultCountDownDuration = 60 * 20
        public var timerTitle = "Pause playback after"
        public var timerCancelButtonText = "Cancel"
        public var timerOkButtonText = "Start"
        public var timerStopButtonText = "Stop"
        public var errorText = NSLocalizedString("Video is unreachable", comment: "")
        public var buttonActiveTintColor = UIColor.red
    }

    struct Stream {
        public let url: URL
        public let name: String
        public let id: String
        public var isFavorite: Bool
        public let epgChannelId: String?

        public init(url: URL, name: String, id: String, isFavorite: Bool, epgChannelId: String? = nil) {
            self.url = url
            self.name = name
            self.id = id
            self.isFavorite = isFavorite
            self.epgChannelId = epgChannelId
        }
    }
}
