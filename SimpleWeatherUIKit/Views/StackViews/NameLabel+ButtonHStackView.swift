//
//  NameLabel+ButtonHStackView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

protocol NameLabelDelegate: AnyObject {
    func onTap()
}

class NameLabel_ButtonHStackView: UIView {

    // MARK: - Properties
    
    weak var delegate: NameLabelDelegate?
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        return stack
    }()
    
    private func createCityAndData() -> UIView {
        let view = CityAndDateView()
        return view
    }
    
    private func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Another city?", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cityLabel = createCityAndData()
        let button = createButton()
        
        stackView.addArrangedSubview(cityLabel)
        cityLabel.anchor(top: stackView.topAnchor)
        
        stackView.addArrangedSubview(button)
        button.anchor(top: stackView.topAnchor, paddingTop: -35)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor,
                         right: rightAnchor, height: 80)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameLabel_ButtonHStackView: NameLabelDelegate {
    
    // MARK: - Selector
    @objc func handleTap() {
        print("DEBUG: Button tapped")
        delegate?.onTap()
    }
    
    // MARK: - DELEGATE
    func onTap() {
    }
}
