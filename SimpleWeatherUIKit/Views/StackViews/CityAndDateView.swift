//
//  CityAndDateView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

class CityAndDateView: UIView {

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()
    
    private func createCityName() -> UILabel {
        let label = UILabel()
        label.text = "Sevastopol"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 40)
        label.numberOfLines = 2
        label.textColor = .white
        label.preferredMaxLayoutWidth = 210
        return label
    }
    
    private func getDate() -> UILabel {
        let date = UILabel()
        date.text = "Today, \(Date().formatted(.dateTime.month().day().hour().minute()))"
        date.font = .systemFont(ofSize: 15)
        date.textColor = .white
        return date
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cityLabel = createCityName()
        let date = getDate()
        
        stackView.addArrangedSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
