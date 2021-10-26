//
//  ViewController.swift
//  weather11
//
//  Created by Macbook on 20/03/1443 AH.
//

import UIKit


struct WeatherData: Codable {
    let name: String
    let main : Main
    let wind : Wind
    let weather : Array <WeatherCon>
}

struct Main: Codable {
    let temp: Double
    let humidity : Int
    
}
struct Wind : Codable{
    let speed : Double
}
struct WeatherCon : Codable {
    let description : String
}


var aa : Array<WeatherData> = []

class ViewController: UIViewController {
    
    
    
    let speedlabel = UILabel()
    var cityLable = UILabel()
    var temperatureLable = UILabel()
    let humlabel = UILabel()
    let deslabel = UILabel()
    
    let img = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lis()
        view.backgroundColor = UIColor(named: "Bacground")
        
        
        
        cityLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLable)
        cityLable.textColor = .darkGray
        cityLable.font = UIFont.boldSystemFont(ofSize: 40)
        
        
        NSLayoutConstraint.activate([cityLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     cityLable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                    ])
        
        
        speedlabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(speedlabel)
        speedlabel.textColor = .purple
        speedlabel.font = UIFont.boldSystemFont(ofSize: 25)
        NSLayoutConstraint.activate([speedlabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
                                     speedlabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
                                    ])
        
        humlabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(humlabel)
        humlabel.textColor = .purple
        humlabel.font = UIFont.boldSystemFont(ofSize: 25)
        NSLayoutConstraint.activate([humlabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
                                     humlabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 270),
                                    ])
        
        temperatureLable.textColor = .black
        temperatureLable.font = UIFont.boldSystemFont(ofSize: 170)
        temperatureLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temperatureLable)
        
        NSLayoutConstraint.activate([
            temperatureLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLable.topAnchor.constraint(equalTo: cityLable.topAnchor,constant: -200),
        ])
        
        
        deslabel.textColor = .black
        deslabel.font = UIFont.boldSystemFont(ofSize: 20)
        deslabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deslabel)
        
        NSLayoutConstraint.activate([
            deslabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deslabel.topAnchor.constraint(equalTo: cityLable.topAnchor,constant: 280),
        ])
        
        
        
        img.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(img)
        
        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.topAnchor.constraint(equalTo: cityLable.topAnchor,constant: 110),
            img.heightAnchor.constraint(equalToConstant: 150),
            img.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    
    @objc func lis() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Taif&appid=90ff1b516e38b23119e8f40f83596f6a")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let da = try? JSONDecoder().decode(WeatherData.self, from: data)
            print(String(data: data , encoding: .utf8)!)
            
            
            
            DispatchQueue.main.async {
                self.cityLable.text = da!.name
                self.temperatureLable.text = String(format: "%.0f", da!.main.temp - 273.15)
                self.speedlabel.text = "Speed: \(da!.wind.speed)"
                self.humlabel.text = "Humidity: \(da!.main.humidity)"
                self.deslabel.text = da?.weather.first!.description
                self.img.image = UIImage(systemName: "cloud.fill")
            }
        }
        task.resume()
    }
}
