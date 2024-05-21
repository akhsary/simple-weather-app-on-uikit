//
//  CityAndDateView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

class CityAndDateView: UIView {
    
    
    private var weatherData = WeatherViewModel.shared
    
    private var userWeather: ResponseBody?
    
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()
    
    private func createCityName() -> UILabel {
        let label = UILabel()
        label.text = "Default City"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 35)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
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
        cityLabel.widthAnchor.constraint(equalToConstant: 210).isActive = true
        
        stackView.addArrangedSubview(date)

        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        weatherData.onUserWeatherChange1 = { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.userWeather = value
                print("DEBUG: City name changed to: \(String(describing: self.userWeather?.name))")
                cityLabel.text = self.userWeather?.name
            }
        }
  }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
