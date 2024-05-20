//
//  WeatherHStackView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

class WeatherHStackView: UIView {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
    
    private func createDegrees() -> UILabel {
        let label = UILabel()
        label.text = "23°"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 100)
        label.numberOfLines = 2
        label.textColor = .white
        label.preferredMaxLayoutWidth = 210
        return label
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Rain"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let degrees = createDegrees()
        let label = createLabel()

        stackView.addArrangedSubview(degrees)
        degrees.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        stackView.anchor(left: leftAnchor, right: rightAnchor, height: 100)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
