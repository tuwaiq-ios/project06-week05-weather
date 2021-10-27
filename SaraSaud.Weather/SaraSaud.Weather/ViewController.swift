//
//  ViewController.swift
//  SaraSaud.Weather
//
//  Created by SARA SAUD on 3/20/1443 AH.
//
//
//  ViewController.swift
//  WeatherProject
//
//  Created by SARA SAUD on 3/20/1443 AH.
//

    import UIKit
    import Foundation

    struct weatherAPI: Codable {
      var name: String
      var weather: Array<weather>
      var main: main
    }
      struct weather: Codable {
      var main: String
      var description: String
    }
      struct main: Codable {
        var humidity: Double
       var feels_like: Double
      }


    class ViewController: UIViewController {
      var climate : weatherAPI?
     
      let citylabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
      }( )
      let mainlabel: UILabel = {
        let label = UILabel( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28, weight: .ultraLight)
        return label}( )
      let describtionlabel: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label } ( )
      let templabel: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        return label } ( )
      let feelLikeLabel: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 33, weight: .light)
        return label } ( )
        
        override func viewDidLoad() {
        super.viewDidLoad()
            
            let Up = UISwipeGestureRecognizer(
                target: self,
                action: #selector(backGroundColor))
            
            Up.direction = .up
            view.addGestureRecognizer(Up)
            
            
            view.isUserInteractionEnabled = true


            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(backGroundColor))
            tap.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap)

            view.isUserInteractionEnabled = true


            
          let swipelift = UISwipeGestureRecognizer(
                target: self,
                action: #selector(Riyadh))
              swipelift.direction = .left
              view.addGestureRecognizer(swipelift)
              view.isUserInteractionEnabled = true
            
        let swipelifttwo = UISwipeGestureRecognizer(
                target: self,
                action: #selector(Jeddah))
          swipelifttwo.direction = .right
              view.addGestureRecognizer(swipelifttwo)
              view.isUserInteractionEnabled = true
          
          
          
        simpleGetUrlRequest()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ImageSet")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
            
        view.addSubview(citylabel)
        NSLayoutConstraint.activate([
          citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
          citylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 190)
        ])
        view.addSubview(mainlabel)
        NSLayoutConstraint.activate([
          mainlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          mainlabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 250)
        ])
        view.addSubview(describtionlabel)
        NSLayoutConstraint.activate([
          describtionlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          describtionlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 290)
        ])
        view.addSubview(templabel)
        NSLayoutConstraint.activate([
          templabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          templabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 520)
        ])
        view.addSubview(feelLikeLabel)
        NSLayoutConstraint.activate([
          feelLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          feelLikeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
        ])
            
        let wetharimage = "sun"
        let image = UIImage(named: "sun4")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 100, y: 320, width: 195, height: 200)
        self.view.addSubview(imageView)
      }
        
        @objc func backGroundColor(){
            view.backgroundColor = UIColor(named: "background")

        }
        
      func simpleGetUrlRequest() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=b455885e4f1625cc797667685927551a&units=metric")!
          
          let task = URLSession.shared.dataTask(with: url) {
          (data, response, error) in
          guard let data = data else { return }
          let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
          print(String(data: data, encoding: .utf8)!)
          DispatchQueue.main.async {
            self.citylabel.text = country!.name
            self.templabel.text = "\(Int(round(Double(country!.main.humidity)))) C"
            self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))🌡"
            self.mainlabel.text = country?.weather[0].main
            self.describtionlabel.text = country?.weather[0].description
          }
        }
        task.resume()
          
      }
        
       
        
        @objc func Riyadh() {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Riyadh&appid=b455885e4f1625cc797667685927551a&units=metric")!
            let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in
              guard let data = data else { return }
              let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
              print(String(data: data, encoding: .utf8)!)
              DispatchQueue.main.async {
                self.citylabel.text = country!.name
                self.templabel.text = "\(Int(round(Double(country!.main.humidity)))) C"
                self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))🌡"
                self.mainlabel.text = country?.weather[0].main
                self.describtionlabel.text = country?.weather[0].description
                  
              }
            }
            task.resume()
          }
        @objc func Jeddah() {
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Jeddah&appid=b455885e4f1625cc797667685927551a&units=metric")!
            let task = URLSession.shared.dataTask(with: url) {
              (data, response, error) in
              guard let data = data else { return }
              let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
              print(String(data: data, encoding: .utf8)!)
              DispatchQueue.main.async {
                self.citylabel.text = country!.name
                self.templabel.text = "\(Int(round(Double(country!.main.humidity)))) C"
                self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))🌡"
                self.mainlabel.text = country?.weather[0].main
                self.describtionlabel.text = country?.weather[0].description
                  
              }
            }
            task.resume()
          }
        
        
    }

