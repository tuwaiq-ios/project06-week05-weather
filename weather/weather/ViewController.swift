//
//  ViewController.swift
//  weather
//
//  Created by alanood on 20/03/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var manager = Manager()
    
    
    let weatherBackgroundImage  = UIImageView()
    let searchButton            = UIButton(type: .system)
    let citySearchTextField     = UITextField()
    
    
    let cityLabel               = UILabel()
    let temperatureLabel        = UILabel()
    let tempDescriptionLabel    = UILabel()
    let conditionImageView      = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBGImage()
        setupButton()
        setupTextField()
        setupWeatherViews()
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        manager.delegate = self
        
    }
    


    private func setupBGImage() {
        weatherBackgroundImage.image       = UIImage(named: "morning")
        weatherBackgroundImage.contentMode = .scaleAspectFill
        
        weatherBackgroundImage.translatesAutoresizingMaskIntoConstraints                           = false
        
        view.addSubview(weatherBackgroundImage)
        
        weatherBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive              = true
        weatherBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive      = true
        weatherBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive    = true
        weatherBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive        = true
    }
    
    private func setupButton() {
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor    = .white
        searchButton.layer.cornerRadius = 15
        
        
        searchButton.translatesAutoresizingMaskIntoConstraints                                       = false
        
        view.addSubview(searchButton)
        
        
        searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -375).isActive    = true
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive    = true
        searchButton.heightAnchor.constraint(equalToConstant: 45).isActive                           = true
        
    }
    
    @objc private func searchButtonPressed(sender: UIButton!)  {
        guard let userChosenCity = citySearchTextField.text else {return}
        
        manager.fetchWeather(cityName: userChosenCity)
    }
    
    private func setupTextField() {
        citySearchTextField.placeholder         = "City name"
        citySearchTextField.layer.cornerRadius  = 15
        citySearchTextField.backgroundColor     = .white
        citySearchTextField.font                = UIFont.systemFont(ofSize: 15)
        citySearchTextField.textColor           = .black
        citySearchTextField.autocorrectionType  = .yes
        citySearchTextField.keyboardType        = .default
        citySearchTextField.returnKeyType       = .done
        citySearchTextField.translatesAutoresizingMaskIntoConstraints                                           = false
        
        
        view.addSubview(citySearchTextField)
        
        
        citySearchTextField.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -20).isActive    = true
        citySearchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive     = true
        citySearchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive        = true
        citySearchTextField.heightAnchor.constraint(equalToConstant: 45).isActive                               = true
    }
    
    private func setupWeatherViews() {
        
        
        cityLabel.textColor = .white
        cityLabel.font      = UIFont.systemFont(ofSize: 18)
        cityLabel.text      = "Enter A city Below"
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        cityLabel.bottomAnchor.constraint(equalTo: citySearchTextField.topAnchor, constant: -85).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tempDescriptionLabel.textColor = .white
        tempDescriptionLabel.font      = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        
        tempDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tempDescriptionLabel)
        tempDescriptionLabel.bottomAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -3).isActive = true
        tempDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        temperatureLabel.textColor = .white
        temperatureLabel.font      = UIFont.systemFont(ofSize: 38)
        temperatureLabel.text      = "Hello!"
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temperatureLabel)
        temperatureLabel.bottomAnchor.constraint(equalTo: tempDescriptionLabel.topAnchor, constant: -10).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        conditionImageView.tintColor = .white
        
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conditionImageView)
        conditionImageView.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -5).isActive  = true
        conditionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive                       = true
        conditionImageView.widthAnchor.constraint(equalToConstant: 100).isActive                                = true
        conditionImageView.heightAnchor.constraint(equalToConstant: 100).isActive                               = true
    }
}

extension ViewController: ManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: Manager, weather: Model) {
        DispatchQueue.main.async {
            self.temperatureLabel.text          = weather.temperatureString + "℃"
            self.conditionImageView.image       = UIImage(systemName: weather.conditionName)
            self.cityLabel.text                 = weather.cityName
            self.tempDescriptionLabel.text      = weather.description
        
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
