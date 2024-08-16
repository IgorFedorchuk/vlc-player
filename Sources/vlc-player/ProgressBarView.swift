//
//  ProgressBarView.swift
//
//
//  Created by Igor Fedorchuk on 04.08.2024.
//

import UIKit

public final class ProgressBarView: UIView {
    public var progressSlider: UISlider = {
        let slider = UISlider(frame: CGRect.zero)
        slider.tintColor = UIColor.white
        slider.backgroundColor = .clear
        slider.minimumTrackTintColor = UIColor.white
        slider.maximumTrackTintColor = UIColor.color(r: 255, g: 255, b: 255, a: 0.4)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0
        slider.setThumbImage(UIImage(imageName: "vertical-line")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        return slider
    }()

    public var startLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    public var endLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    public var value: Float {
        get {
            return progressSlider.value
        }
        set {
            if !isDragging {
                progressSlider.value = newValue
            }
        }
    }

    private var startSecond = 0
    private var endSecond = 0

    private(set) var isDragging = false {
        didSet {
            if isDragging {
                onStartDragging?(progressSlider.value)
            } else {
                onEndDragging?(progressSlider.value)
            }
        }
    }

    var onStartDragging: ((Float) -> Void)?
    var onEndDragging: ((Float) -> Void)?
    var onChangeValue: ((Float) -> Void)?

    init() {
        super.init(frame: .zero)
        setupStartLabel()
        setupEndLabel()
        setupProgressBarSlider()
        isUserInteractionEnabled = false
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(value: Float, startSecond: Int, endSecond: Int) {
        progressSlider.value = value
        set(startSecond: startSecond)
        set(endSecond: endSecond)
    }
}

extension ProgressBarView {
    private func setupStartLabel() {
        addSubview(startLabel)
        startLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        startLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }

    private func setupEndLabel() {
        addSubview(endLabel)
        endLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        endLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }

    private func setupProgressBarSlider() {
        progressSlider.addTarget(self, action: #selector(progressBarValueDidChange(_:)), for: .valueChanged)
        progressSlider.addTarget(self, action: #selector(progressBarTouchDown(_:)), for: .touchDown)
        progressSlider.addTarget(self, action: #selector(progressBarTouchUp(_:)), for: .touchUpInside)
        progressSlider.addTarget(self, action: #selector(progressBarTouchUp(_:)), for: .touchUpOutside)
        progressSlider.addTarget(self, action: #selector(progressBarTouchUp(_:)), for: .touchCancel)
        addSubview(progressSlider)
        progressSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        progressSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        progressSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        progressSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    @objc private func progressBarTouchUp(_: UISlider) {
        isDragging = false
    }

    @objc private func progressBarTouchDown(_: UISlider) {
        isDragging = true
    }

    @objc private func progressBarValueDidChange(_: UISlider) {
        let currentTime = Int(progressSlider.value * Float(endSecond))
        startLabel.text = currentTime.secondToTimeString(currentTime)
        onChangeValue?(progressSlider.value)
    }

    private func set(startSecond: Int) {
        if !isDragging {
            self.startSecond = startSecond
            startLabel.text = startSecond.secondToTimeString(startSecond)
        }
    }

    private func set(endSecond: Int) {
        isUserInteractionEnabled = endSecond > 0
        self.endSecond = endSecond
        endLabel.text = endSecond.secondToTimeString(endSecond)
    }
}
