//
//  SettingsViewController.swift
//  UICollectionViewGalleryExample
//
//  Created by Bekpayev Dias on 12.07.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private let columnSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        return slider
    }()
    
    private let spacingSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        return slider
    }()
    
    var delegate: SettingsViewControllerDelegate?
    
    init(columnCount: Int, spacing: CGFloat, delegate: SettingsViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.columnSlider.value = Float(columnCount)
        self.spacingSlider.value = Float(spacing)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSliders()
    }
    
    private func setupSliders() {
        columnSlider.addTarget(self, action: #selector(columnValue(_:)), for: .valueChanged)
        spacingSlider.addTarget(self, action: #selector(spacingValue(_:)), for: .valueChanged)
        
        view.addSubview(columnSlider)
        view.addSubview(spacingSlider)
        
        columnSlider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        spacingSlider.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(50)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    @objc private func columnValue(_ sender: UISlider) {
        let columnCount = Int(sender.value)
        delegate?.settingsViewController(self, didSelectColumnCount: columnCount)
    }
    
    @objc private func spacingValue(_ sender: UISlider) {
        let spacing = CGFloat(sender.value)
        delegate?.settingsViewController(self, didSelectSpacing: spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewController(_ controller: SettingsViewController, didSelectColumnCount columnCount: Int)
    func settingsViewController(_ controller: SettingsViewController, didSelectSpacing spacing: CGFloat)
}

extension MainViewController: SettingsViewControllerDelegate {
    func settingsViewController(_ controller: SettingsViewController, didSelectColumnCount columnCount: Int) {
        self.columnCount = columnCount
        updateCollectionViewLayout()
    }
    
    func settingsViewController(_ controller: SettingsViewController, didSelectSpacing spacing: CGFloat) {
        self.spacing = spacing
        updateCollectionViewLayout()
    }
}
