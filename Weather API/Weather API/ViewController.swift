//
//  Weather API.swift
//  Weather API
//
//  Created by Fawaz on 25/10/2021.
//

struct WeatherData: Codable {
  
  let main: MainHumidityTemp
  let wind: WindSpeed
  let clouds: CloudsAll
  let name: String //5
  let weather: Array<WeatherDescription>
}
//----------------------------------------------------------------------------
//object from struct WeatherData
//----------------------------------------------------------------------------

struct MainHumidityTemp: Codable{
  let humidity: Int //1
  let temp: Double //4
}
struct WindSpeed: Codable{
  let speed: Double //2
}
struct CloudsAll: Codable{
  let all: Int //3
}
struct WeatherDescription: Codable{
  let description: String //6
}
//**************************************************************************
import UIKit

class Weather: UIViewController {
  
  let Lhumidity = UILabel()//---------1
  let Lspeed = UILabel()//------------2
  let Lall = UILabel()//--------------3
  let Ltemp = UILabel()//-------------4
  let Lname = UILabel()//-------------5
  let Ldescription = UILabel()//------6
  
  let gradienLayer = CAGradientLayer()
  
  //**************************************************************************
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    simpleGetUrlRequset()
    
    gradienLayer.frame.size = view.frame.size
    gradienLayer.colors = [UIColor(named: "Color1")!.cgColor, UIColor(named: "Color2")!.cgColor]
    
    view.layer.addSublayer(gradienLayer)
    //------------------------------------------------------------------------
    
    let modeImage = UIImage(named: "Mode")
    let imageView = UIImageView(image: modeImage)
    
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
  self.view.addSubview(imageView)
    
  NSLayoutConstraint.activate([
    imageView.topAnchor.constraint(equalTo: view.topAnchor),
    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    //1-----------------------------------------------------------------------
    
    Lhumidity.translatesAutoresizingMaskIntoConstraints = false
    Lhumidity.textColor = .white
    Lhumidity.font = UIFont.boldSystemFont(ofSize: 22)
    
    view.addSubview(Lhumidity)
    
    NSLayoutConstraint.activate([
      Lhumidity.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40),
      Lhumidity.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
      
      Lhumidity.heightAnchor.constraint(equalToConstant: 50),
      Lhumidity.widthAnchor.constraint(equalToConstant: 100),
    ])
    //2----------------------------------------------------------------------
    
    Lspeed.translatesAutoresizingMaskIntoConstraints = false
    Lspeed.textColor = .white
    Lspeed.font = UIFont.boldSystemFont(ofSize: 22)
    
    view.addSubview(Lspeed)
    
    NSLayoutConstraint.activate([
      
      Lspeed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -140),
      Lspeed.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
      
      Lspeed.heightAnchor.constraint(equalToConstant: 50),
      Lspeed.widthAnchor.constraint(equalToConstant: 50),
    ])
    //3----------------------------------------------------------------------
    
    Lall.translatesAutoresizingMaskIntoConstraints = false
    Lall.textColor = .white
    Lall.font = UIFont.boldSystemFont(ofSize: 22)
    
    view.addSubview(Lall)
    
    NSLayoutConstraint.activate([
      Lall.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90),
      Lall.topAnchor.constraint(equalTo: view.topAnchor, constant: 105),
      
      Lall.heightAnchor.constraint(equalToConstant: 50),
      Lall.widthAnchor.constraint(equalToConstant: 100),
    ])
    //4----------------------------------------------------------------------
    
    Ltemp.translatesAutoresizingMaskIntoConstraints = false
    Ltemp.textColor = .white
    Ltemp.font = UIFont.boldSystemFont(ofSize: 80)
    Ltemp.textAlignment = NSTextAlignment.center
    
    view.addSubview(Ltemp)
    
    NSLayoutConstraint.activate([
      Ltemp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      Ltemp.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
      
      Ltemp.heightAnchor.constraint(equalToConstant: 150),
      Ltemp.widthAnchor.constraint(equalToConstant: 250),
    ])
    //5----------------------------------------------------------------------
    
    Lname.translatesAutoresizingMaskIntoConstraints = false
    Lname.textColor = .white
    Lname.font = UIFont.boldSystemFont(ofSize: 22)
    Lname.textAlignment = NSTextAlignment.center
    
    view.addSubview(Lname)
    
    NSLayoutConstraint.activate([
      Lname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      Lname.topAnchor.constraint(equalTo: view.topAnchor, constant: 340),
      
      Lname.heightAnchor.constraint(equalToConstant: 50),
      Lname.widthAnchor.constraint(equalToConstant: 200),
    ])
    //6----------------------------------------------------------------------
    
    Ldescription.translatesAutoresizingMaskIntoConstraints = false
    Ldescription.textColor = .white
    Ldescription.font = UIFont.boldSystemFont(ofSize: 22)
    Ldescription.textAlignment = NSTextAlignment.center
    
    view.addSubview(Ldescription)
    
    NSLayoutConstraint.activate([
      Ldescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      Ldescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 380),
      
      Ldescription.heightAnchor.constraint(equalToConstant: 50),
      Ldescription.widthAnchor.constraint(equalToConstant: 200),
    ])
  }
  //**************************************************************************
  
  func simpleGetUrlRequset(){
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Abha&appid=90ff1b516e38b23119e8f40f83596f6a")!
    
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      guard let data = data else {return}
      
      print(String(data: data , encoding: .utf8)!)
      
      let post = try? JSONDecoder().decode(WeatherData.self, from: data)
      guard let post = post else {return}
      
      DispatchQueue.main.async {
        
        self.Lhumidity.text = "\(String(describing: post.main.humidity))"
        self.Lspeed.text = "\(String(describing: post.wind.speed.rounded()))"
        self.Lall.text = "\(String(describing: post.clouds.all))"
        self.Ltemp.text = "\(String(describing: post.main.temp.rounded() - 273))"
        self.Lname.text = post.name
        self.Ldescription.text = post.weather.first!.description
      }
    }
    task.resume()
  }
}
//***********************************************************************
