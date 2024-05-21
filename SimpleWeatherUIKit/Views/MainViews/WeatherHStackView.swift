//
//  WeatherHStackView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

class WeatherHStackView: UIView {
    
    
    private var weatherData = WeatherViewModel.shared
    
    private var userWeather: ResponseBody?
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 1
        return stack
    }()
    
    private func createDegrees() -> UILabel {
        let label = UILabel()
        label.text = "666°"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 70)
        label.textColor = .white
        return label
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "rain"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let degrees = createDegrees()
        let label = createLabel()

        stackView.addArrangedSubview(degrees)
        degrees.widthAnchor.constraint(equalToConstant: 210).isActive = true

        stackView.addArrangedSubview(label)

        addSubview(stackView)
        stackView.anchor(left: leftAnchor, right: rightAnchor, height: 100)
        
        weatherData.onUserWeatherChange2 = { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.userWeather = value
                degrees.text = ((self.userWeather?.main.temp.roundDouble() ?? "") + "°")
                label.text = "\(self.userWeather?.weather[0].main ?? "")"
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

