//
//  ViewController.swift
//  weatherM
//
//  Created by PC on 21/03/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    let cityButton1 : UIButton = {
        $0.backgroundColor = UIColor(named: "buttonColor")
        $0.setTitle("Abha", for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(abhaButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let cityButton2 : UIButton = {
        $0.backgroundColor = UIColor(named: "buttonColor")
        $0.setTitle("Jeddah", for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(jeddahButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc func abhaButtonAction() {
        getWeatherData(cityName: "Abha")
    }
    
    @objc func jeddahButtonAction() {
        getWeatherData(cityName: "Jeddah")
    }
    
  
    let countryLabel : UILabel = {
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 23)
        $0.textColor = .label
        return $0
    }(UILabel())
    
    
    let conditionLabel : UILabel = {
        $0.textAlignment = .center
        $0.textColor = .label
        return $0
    }(UILabel())
    
    
    let temperatureLabel : UILabel = {
        $0.textAlignment = .center
        $0.textColor = .label
        return $0
    }(UILabel())
    
    let weatherStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
}

// setup UI
extension ViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(weatherStackView)
        weatherStackView.addArrangedSubview(cityButton1)
        weatherStackView.addArrangedSubview(cityButton2)
        weatherStackView.addArrangedSubview(countryLabel)
        weatherStackView.addArrangedSubview(conditionLabel)
        weatherStackView.addArrangedSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            weatherStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            weatherStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            weatherStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            weatherStackView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }
}

// API Request
extension ViewController {
    func getWeatherData(cityName : String) {

        let stringURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=90ff1b516e38b23119e8f40f83596f6a"
        guard let url = URL(string: stringURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                if let data = data {
                    if let json = try? JSONDecoder().decode(WeatherData.self, from: data) {
//                    print("Condition : \(json.weather![0].description)")
//                        print("temp : \(json.main?.temp)")
//                    print("City : \(json.name)")
                        
                        let temp = Int(json.main!.temp! - 273)
                        
                        DispatchQueue.main.async {
                            self.conditionLabel.text = json.weather![0].description
                            self.countryLabel.text = "\(json.sys!.country!),  \(json.name!)"
                            self.temperatureLabel.text = "\(temp) °"
                        }
                        
                        
                    }
                }
            }
        }
        task.resume()
    }
}
    

