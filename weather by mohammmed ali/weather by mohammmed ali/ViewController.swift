//
//  SceneDelegate.swift
//  weather by mohammmed ali
//
//  Created by mohammed al-qahtani on 20/03/1443 AH.

import UIKit
struct Weather: Codable{
  let name : String
  let main : Main
  let weather: Array<weather>
}
struct Main:Codable {
  let temp : Double
  let humidity : Int
}
struct weather:Codable {
  let main : String
  let description : String
//    let icon : String
    
  
}
var a : Weather!







class ViewController: UIViewController {
    
    
 var climate : Weather?
 let citylabel: UILabel = {
  let label = UILabel()
 
  label.translatesAutoresizingMaskIntoConstraints = false
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
  return label
 }( )
 let mainlabel: UILabel = {
  let label = UILabel( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = " "
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
  return label}( )
 let describtionlabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = " "
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
  return label } ( )
 let templabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = " "
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
  return label } ( )
 let humiditylabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = " "
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 40, weight: .light)
  return label } ( )
 override func viewDidLoad() {
  super.viewDidLoad()
  Abha()
     
     
     let tap = UISwipeGestureRecognizer(
         target: self,
         action: #selector(Jeddah)
     )
     
     tap.direction = .right
         view.addGestureRecognizer(tap)
     
     
     let tap1 = UISwipeGestureRecognizer(
         target: self,
         action: #selector(Dammam)
     )
     
     tap1.direction = .left
         view.addGestureRecognizer(tap1)
     
     
     
     let tap2 = UISwipeGestureRecognizer(
         target: self,
         action: #selector(Riyadh)
     )
     
     tap2.direction = .up
         view.addGestureRecognizer(tap2)
     
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
  view.addSubview(humiditylabel)
  NSLayoutConstraint.activate([
    humiditylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    humiditylabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
  ])
     
   let wetharimage = "100"
     
     
     
   let image1 = UIImage(named: "sun1")
   let imageView1 = UIImageView(image: image1)
   imageView1.frame = CGRect(x: 100, y: 320, width: 195, height: 200)
   self.view.addSubview(imageView1)
 }
    
 func Abha() {
  let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
   let task = URLSession.shared.dataTask(with: url) {
   (data, response, error) in
   guard let data = data else { return }
   let country = try? JSONDecoder().decode(Weather.self, from: data)
   print(String(data: data, encoding: .utf8)!)
       
       
    DispatchQueue.main.async {
    self.citylabel.text = country?.name
    self.templabel.text = "\(Int(round(Double(country!.main.temp))))"
    self.humiditylabel.text = "\(Int(round(Double(country!.main.humidity)))) "
    self.mainlabel.text = country!.weather[0].main
    self.describtionlabel.text = country!.weather[0].description
       
   }
       
  }
  task.resume()
 }
    
    
   @objc func Jeddah() {
     let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=jeddah&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
      let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      guard let data = data else { return }
      let country = try? JSONDecoder().decode(Weather.self, from: data)
      print(String(data: data, encoding: .utf8)!)
          
          
       DispatchQueue.main.async {
       self.citylabel.text = country?.name
       self.templabel.text = "\(Int(round(Double(country!.main.temp))))"
       self.humiditylabel.text = "\(Int(round(Double(country!.main.humidity)))) "
       self.mainlabel.text = country!.weather[0].main
       self.describtionlabel.text = country!.weather[0].description
          
      }
          
     }
     task.resume()
    }
    
    @objc func Dammam() {
      let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=dammam&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
       let task = URLSession.shared.dataTask(with: url) {
       (data, response, error) in
       guard let data = data else { return }
       let country = try? JSONDecoder().decode(Weather.self, from: data)
       print(String(data: data, encoding: .utf8)!)
           
           
        DispatchQueue.main.async {
        self.citylabel.text = country?.name
        self.templabel.text = "\(Int(round(Double(country!.main.temp))))"
        self.humiditylabel.text = "\(Int(round(Double(country!.main.humidity)))) "
        self.mainlabel.text = country!.weather[0].main
        self.describtionlabel.text = country!.weather[0].description
           
       }
           
      }
      task.resume()
     }
    
    
    @objc func Riyadh() {
      let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=riyadh&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
       let task = URLSession.shared.dataTask(with: url) {
       (data, response, error) in
       guard let data = data else { return }
       let country = try? JSONDecoder().decode(Weather.self, from: data)
       print(String(data: data, encoding: .utf8)!)
           
           
        DispatchQueue.main.async {
        self.citylabel.text = country?.name
        self.templabel.text = "\(Int(round(Double(country!.main.temp))))"
        self.humiditylabel.text = "\(Int(round(Double(country!.main.humidity)))) "
        self.mainlabel.text = country!.weather[0].main
        self.describtionlabel.text = country!.weather[0].description
           
       }
           
      }
      task.resume()
     }

    

}

