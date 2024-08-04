//
//  ProgressBarView.swift
//  
//
//  Created by Igor Fedorchuk on 04.08.2024.
//

import UIKit

final public class ProgressBarView: UIView {
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
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    public var endLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var value: Float {
        get {
            return progressSlider.value
        }
        set {
            progressSlider.value = newValue
        }
    }
    
    var onSliderValueChanged: ((Float) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupStartLabel()
        setupEndLabel()
        setupProgressBarSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProgressBarView {
    private func setupStartLabel() {
        addSubview(startLabel)
        startLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        startLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        startLabel.text = "00:00:00"
    }
    
    private func setupEndLabel() {
        addSubview(endLabel)
        endLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        endLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }
    
    private func setupProgressBarSlider() {
        progressSlider.addTarget(self, action: #selector(progressBarValueDidChange(_:)), for: .valueChanged)
        addSubview(progressSlider)
        progressSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        progressSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        progressSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        progressSlider.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc private func progressBarValueDidChange(_ sender: UISlider) {
        onSliderValueChanged?(sender.value)
    }
}
