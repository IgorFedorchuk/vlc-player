//
//  ProgressBarView.swift
//  
//
//  Created by Igor Fedorchuk on 04.08.2024.
//

import UIKit

final class ProgressBarView: UIView {
    private var progressBarSlider: UISlider = {
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
   
    var onSliderValueChanged: ((Float) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupProgressBarSlider()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProgressBarView {
    private func setupProgressBarSlider() {
        progressBarSlider.addTarget(self, action: #selector(progressBarSliderValueDidChange(_:)), for: .valueChanged)
        addSubview(progressBarSlider)
        progressBarSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        progressBarSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        progressBarSlider.bottomAnchor.constraint(equalTo: topAnchor, constant: -8).isActive = true
        progressBarSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc private func progressBarSliderValueDidChange(_ sender: UISlider) {
        onSliderValueChanged?(sender.value)
    }
}
