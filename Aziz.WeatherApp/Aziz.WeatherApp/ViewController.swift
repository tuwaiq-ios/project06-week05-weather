//
//  ViewController.swift
//  Aziz.WeatherApp
//
//  Created by Abdulaziz on 19/03/1443 AH.
//

import UIKit
struct coord: Codable{
    let name : String
    let main : Main
    let wind: Wind
    let weather: Array<weather>
}
struct Main:Codable {
    let temp : Double
    let humidity : Int
}
struct weather:Codable {
    let main : String
    let description : String
    let id: Int
}
struct Wind: Codable{
    let speed:Double
}


class ViewController: UIViewController {
    var climate : coord?
    
    let City: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.textColor = .white
        return label
    }( )
    
    let Main: UILabel = {
        let label = UILabel( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
        return label}( )
    
    let Describtion: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        return label } ( )
    
    let ImageOfCondition = UIImageView()
    
    
    let Temp: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
        return label } ( )
    
    let speedlebel : UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
        return label } ( )
    
    var CL = UILabel ()
    var Skm = UILabel ()
    
    let Hlabel = UILabel ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        AbhaWeatherAPI()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Themes")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        view.addSubview(City)
        NSLayoutConstraint.activate([
            City.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            City.topAnchor.constraint(equalTo: view.topAnchor , constant: 160)
        ])
        view.addSubview(Main)
        NSLayoutConstraint.activate([
            Main.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Main.topAnchor.constraint(equalTo: view.topAnchor , constant: 250)
        ])
        view.addSubview(Describtion)
        NSLayoutConstraint.activate([
            Describtion.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Describtion.topAnchor.constraint(equalTo: view.topAnchor, constant: 290)
        ])
        view.addSubview(Temp)
        NSLayoutConstraint.activate([
            Temp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Temp.topAnchor.constraint(equalTo: view.topAnchor, constant: 520)
        ])
        view.addSubview(speedlebel)
        NSLayoutConstraint.activate([
            speedlebel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedlebel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600 )])
        
        ImageOfCondition.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ImageOfCondition)
        view.addSubview(ImageOfCondition)
        NSLayoutConstraint.activate([
            ImageOfCondition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ImageOfCondition.topAnchor.constraint(equalTo: City.topAnchor,constant: 110),
            ImageOfCondition.heightAnchor.constraint(equalToConstant: 280),
            ImageOfCondition.widthAnchor.constraint(equalToConstant: 250),
        ])
        CL.text = "C"
        CL.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(CL)
        NSLayoutConstraint.activate([CL.leftAnchor.constraint(equalTo:view.leftAnchor,constant: 225),
                                     CL.topAnchor.constraint(equalTo:view.topAnchor, constant: 50),
                                     CL.heightAnchor.constraint(equalToConstant: 940),
                                     CL.widthAnchor.constraint(equalToConstant: 3300)
                                     
                                    ])
        
        Skm.text = "Km/h"
        Skm.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Skm)
        NSLayoutConstraint.activate([Skm.leftAnchor.constraint(equalTo:view.leftAnchor,constant: 330),
                                     Skm.topAnchor.constraint(equalTo:view.topAnchor, constant: 50),
                                     Skm.heightAnchor.constraint(equalToConstant: 1160),
                                     Skm.widthAnchor.constraint(equalToConstant: 3300)
                                     
                                    ])
        
        Hlabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Hlabel)
        Hlabel.textColor = .white
        Hlabel.font = UIFont.boldSystemFont(ofSize: 25)
        NSLayoutConstraint.activate([Hlabel.leftAnchor.constraint(equalTo:view.leftAnchor,constant: 130),
                                     Hlabel.topAnchor.constraint(equalTo:view.topAnchor, constant: 50),
                                     Hlabel.heightAnchor.constraint(equalToConstant: 1300),
                                     Hlabel.widthAnchor.constraint(equalToConstant: 3300),
                                    ])
        
        
    }
    
    func AbhaWeatherAPI() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
            let country = try? JSONDecoder().decode(coord.self, from: data)
            
            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                self.City.text = country?.name
                self.Hlabel.text = "Humidity: \(country!.main.humidity)"
                self.Temp.text = "\(Int(round(Double(country!.main.temp))))"
                self.speedlebel.text = "Wind Speed \(Int(round(Double(country!.wind.speed))))"
                self.Main.text = country!.weather[0].main
                self.Describtion.text = country!.weather[0].description
                self.ImageOfCondition.image = UIImage(named: "100")
                
                if (801...804).contains(country!.weather.first!.id) {
                    self.ImageOfCondition.image = UIImage(named: "Pic1")
                }
                
                else if 800 == country!.weather.first!.id {
                    self.ImageOfCondition.image = UIImage(named: "Pic2")
                }
                
                else if (701...781).contains(country!.weather.first!.id) {
                    self.ImageOfCondition.image = UIImage(named: "Pic3")
                }
                else if (600...622) .contains(country!.weather.first!.id) {
                    self.ImageOfCondition.image = UIImage(named: "Pic4")
                }
                else if (500...531) .contains(country!.weather.first!.id) {
                    self.ImageOfCondition.image = UIImage(named: "Pic5")
                }
                else if (300...321).contains(country!.weather.first!.id) {
                    
                    self.ImageOfCondition.image = UIImage(named: "Pic6")
                }
                
                else if (200...232).contains(country!.weather.first!.id) {
                    self.ImageOfCondition.image = UIImage(named: "Pic7")
                }
                else {
                    self.ImageOfCondition.image = UIImage(named: "Pic2")
                }
            }
        }
        task.resume()
    }
    
}




