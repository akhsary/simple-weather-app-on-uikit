//
//  ViewController.swift
//  SimpleWeatherUIKit
//
//  Created by Юрий Чекан on 19.05.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    
    // MARK: - Properties
    
    private lazy var hStackView: UIView = {
        let stack = NameLabel_ButtonHStackView(frame: CGRect(x: CGFloat(10), y: CGFloat(50), width: view.frame.width, height: CGFloat(120)))
        stack.delegate = self
        return stack
    }()
    
    private let image: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageLiteralResourceName: "town")
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var weatherDataStack = {
        let stack = WeatherHStackView(frame: view.frame)
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = ContainerWeatherElenentsView(frame: view.frame)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubview(hStackView)
        
        view.addSubview(weatherDataStack)
        weatherDataStack.anchor(top: hStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.anchor(width: 300, height: 300)
        image.layer.cornerRadius = 300/2
        
        view.addSubview(containerView)
    }
}

extension WeatherViewController: NameLabelDelegate {
    func onTap() {
        print("DEBUG: Button tapped in the main view")
    }
}

#Preview {
    WeatherViewController()
}
