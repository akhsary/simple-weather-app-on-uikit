//
//  ContainerWeatherElenentsView.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 20.05.2024.
//

import UIKit

class ContainerWeatherElenentsView: UIView {
    
    private var weatherData = WeatherViewModel.shared
    
    private var userWeather: ResponseBody?
    
    private var rectangle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 26
        view.backgroundColor = .white
        return view
    }()
    
    func createLogo(_ logo: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: logo)
        var config = UIImage.SymbolConfiguration(paletteColors: [.black, .black])
        // Apply a configuration that scales to the system font point size of 42.
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
        imageView.preferredSymbolConfiguration = config
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 16
        return imageView
    }
    
    func createValue(_ value: String) -> UILabel {
        let label = UILabel()
        label.text = value
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }
    
    func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(rectangle)
        rectangle.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 250)
        
        let maxTempLogo = createLogo("thermometer.high")
        let maxTempDegrees = createValue("default°")
        let maxTempLabel = createLabel("Max temp")
        
        addSubview(maxTempLogo)
        maxTempLogo.anchor(top: rectangle.topAnchor, left: rectangle.leftAnchor, paddingTop: 30, paddingLeft: 30)
        addSubview(maxTempDegrees)
        maxTempDegrees.anchor(top: rectangle.topAnchor, left: maxTempLogo.rightAnchor, paddingTop: 50, paddingLeft: 10)
        addSubview(maxTempLabel)
        maxTempLabel.anchor(top: rectangle.topAnchor, left: maxTempLogo.rightAnchor, paddingTop: 32, paddingLeft: 10)
        
        let minTempLogo = createLogo("thermometer.low")
        let minTempDegrees = createValue("21°")
        let minTempLabel = createLabel("Min temp")
        
        addSubview(minTempLogo)
        minTempLogo.anchor(top: rectangle.topAnchor, right: rectangle.rightAnchor, paddingTop: 30, paddingRight: 110)
        addSubview(minTempDegrees)
        minTempDegrees.anchor(top: rectangle.topAnchor, left: minTempLogo.rightAnchor, paddingTop: 50, paddingLeft: 10)
        addSubview(minTempLabel)
        minTempLabel.anchor(top: rectangle.topAnchor, left: minTempLogo.rightAnchor, paddingTop: 32, paddingLeft: 10)
        
        let windLogo = createLogo("wind")
        let windSpeed = createValue("4m/s")
        let windLabel = createLabel("Wind")
        
        addSubview(windLogo)
        windLogo.anchor(left: rectangle.leftAnchor, bottom: rectangle.bottomAnchor, paddingLeft: 20, paddingBottom: 70)
        addSubview(windSpeed)
        windSpeed.anchor(left: maxTempLogo.rightAnchor, bottom: rectangle.bottomAnchor, paddingLeft: 10, paddingBottom: 70)
        addSubview(windLabel)
        windLabel.anchor(left: maxTempLogo.rightAnchor, bottom: rectangle.bottomAnchor, paddingLeft: 10, paddingBottom: 100)
        
        let humidityLogo = createLogo("humidity")
        let humidity = createValue("70.0%")
        let humidityLabel = createLabel("Humidity")
        addSubview(humidityLogo)
        humidityLogo.anchor(bottom: rectangle.bottomAnchor, right: rectangle.rightAnchor, paddingBottom: 70, paddingRight: 100)
        addSubview(humidity)
        humidity.anchor(left: humidityLogo.rightAnchor, bottom: rectangle.bottomAnchor, paddingLeft: 1, paddingBottom: 70)
        addSubview(humidityLabel)
        humidityLabel.anchor(left: humidityLogo.rightAnchor, bottom: rectangle.bottomAnchor, paddingLeft: 1, paddingBottom: 100)
        
        weatherData.onUserWeatherChange3 = { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.userWeather = value
                maxTempDegrees.text = (self.userWeather?.main.tempMax.roundDouble() ?? "default") + "°"
                minTempDegrees.text = (self.userWeather?.main.tempMin.roundDouble() ?? "default") + "°"
                windSpeed.text = (self.userWeather?.wind.speed.roundDouble() ?? "default") + "m/s"
                humidity.text = (self.userWeather?.main.humidity.roundDouble() ?? "default") + "%"
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
