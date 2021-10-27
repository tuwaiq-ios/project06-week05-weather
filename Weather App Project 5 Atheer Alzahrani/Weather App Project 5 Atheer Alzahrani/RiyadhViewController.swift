//
//  RiyadhViewController.swift
//  Weather App Project 5 Atheer Alzahrani
//
//  Created by Eth Os on 21/03/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class RiyadhViewController: UIViewController{
    
    let contentView = UIView()
    let cityLabel = UILabel()
    let dayLabel = UILabel()
    let weatherLabel = UILabel()
    let tempLabel = UILabel()
    let symbolCLabel = UILabel()
    let weatherImage = UIImageView()
    let gradientLayer = CAGradientLayer()
    
    let apiKey = "f8134f72c64cc328ea33023adae22fa5"
    var lat = 24.628496
    var lon = 46.711705
    
    var activityIndicator : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        changeCity()
        setViewDidLoadColor()
    
        let activityIndicatorSize: CGFloat = 70.0
        
        let activityIndicatorFrame = CGRect(x: (view.frame.width-activityIndicatorSize)/2 ,
                                            y: (view.frame.height-activityIndicatorSize)/2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: activityIndicatorFrame,
                                                    type: .lineScale,
                                                    color: .white ,
                                                    padding: 20.0)
        
        contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    
    
    func changeCity(){
         lat = 24.628496
         lon = 46.711705
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric").responseJSON { response in
            self.activityIndicator.stopAnimating()
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                
                self.cityLabel.text = jsonResponse["name"].stringValue
                self.weatherImage.image = UIImage(named: iconName)
                self.weatherLabel.text = jsonWeather["main"].stringValue
                self.tempLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                self.symbolCLabel.text = "C"
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                self.dayLabel.text = dateFormatter.string(from: date)
                
                let sufix = iconName.suffix(1)
                if (sufix == "n" ){
                    self.setBackgroundDark()
                }else{
                    self.setBackgroundLight()
                }
            }
        }
        
    }
    
    func setViewDidLoadColor(){
        let topColor = UIColor(red: 5.0/255.0 , green: 90/255.0, blue: 200.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 100.0/255.0, green: 190.0/255.0, blue: 190.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor,bottomColor]
    }
    
    func setBackgroundLight(){
        let topColor = UIColor(red: 244.0/255.0 , green: 232.0/255.0, blue: 104.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 100.0/255.0, green: 190.0/255.0, blue: 190.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor,bottomColor]
    }
    
    func setBackgroundDark(){
        let topColor = UIColor(red: 5.0/255.0 , green: 5.0/255.0, blue: 20.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 190.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor,bottomColor]
    }
    
    func setUI(){
        contentView.layer.addSublayer(gradientLayer)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
//        cityLabel.text = "City Name"
        cityLabel.textColor = .white
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
        
//        dayLabel.text = "Day"
        dayLabel.textColor = .white
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 40)
        ])
        
//        weatherImage.image = UIImage(named: "01n")
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 100),
            weatherImage.widthAnchor.constraint(equalToConstant: 150),
            weatherImage.heightAnchor.constraint(equalToConstant: 150)
        ])
        
//        weatherLabel.text = "Weather"
        weatherLabel.textColor = .white
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherLabel)
        NSLayoutConstraint.activate([
            weatherLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 50)
        ])
        
//        tempLabel.text = "25"
        tempLabel.font = .systemFont(ofSize: 80)
        tempLabel.textColor = .white
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 40)
        ])
        
        
        symbolCLabel.textColor = .white
        symbolCLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(symbolCLabel)
        NSLayoutConstraint.activate([
            symbolCLabel.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: -15),
            symbolCLabel.leftAnchor.constraint(equalTo: tempLabel.rightAnchor, constant: 10)
        ])
    }
}
