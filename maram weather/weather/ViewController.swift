//
//  ViewController.swift
//  weather
//
//  Created by Maram Al shahrani on 20/03/1443 AH.
//

import UIKit

struct WeatherApi : Codable{
    let name :String
    let wind :Wind
    let main :Main
    let weather:Array <Weathercondition>
    
}

struct Main: Codable {
    let temp :Double
    let humidity:Int
}
struct Wind :Codable {
    let speed:Double
    
}
struct Weathercondition: Codable{
    let main :String
    let description:String
}


class WeatherViewController: UIViewController {
    
    var mainView: WeatherView! { return self.view as! WeatherView }
    let presenter: WeatherPresenter!
    
    init(with presenter: WeatherPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackground()
        simpleGetUrlRequest()
    }
    
    func updateBackground() {
        self.mainView.updateGradient(presenter.backgroundColors)
    }
    
    override func loadView() {
        self.view = WeatherView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        if isLandscape {
            mainView.centerContentStack.axis = .horizontal
        } else {
            mainView.centerContentStack.axis = .vertical
        }
    }
    @objc func simpleGetUrlRequest() {
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=4064e7073b9622fbd4868594e1b18ef6&units=metric")!
        let task = URLSession.shared.dataTask(with: url) {(data,respone,error) in
            guard let data = data else {return}
            print(String(data: data, encoding: .utf8))
            let weather = try? JSONDecoder().decode( WeatherApi.self, from:data)
            print(weather)
            guard let  weather = weather else {return}
            DispatchQueue.main.async {
                self.mainView.temperatureLabel.text = "\(weather.main.temp)"
                self.mainView.cityLabel.text = weather.name
                self.mainView.conditionsLabel.text = weather.weather[0].main
            }
        }
        task.resume()
    }
}
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
    }
}

