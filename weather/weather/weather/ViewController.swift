//
//  ViewController.swift
//  weather
//
//  Created by sally asiri on 20/03/1443 AH.
//

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
  label.text = ""
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
  return label}( )
 let describtionlabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = ""
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
  return label } ( )
 let templabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = ""
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
  return label } ( )
 let humiditylabel: UILabel = {
  let label = UILabel ( )
  label.translatesAutoresizingMaskIntoConstraints = false
  label.text = ""
  label.textAlignment = .center
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 40, weight: .light)
  return label } ( )
 override func viewDidLoad() {
  super.viewDidLoad()
  simpleGetUrlRequest()
  let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
  backgroundImage.image = UIImage(named: "ImageSet")
  backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
  self.view.insertSubview(backgroundImage, at: 0)
  view.addSubview(citylabel)
  NSLayoutConstraint.activate([
   citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
   citylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 180)
  ])
  view.addSubview(mainlabel)
  NSLayoutConstraint.activate([
   mainlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
   mainlabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 240)
  ])
  view.addSubview(describtionlabel)
  NSLayoutConstraint.activate([
   describtionlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
   describtionlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 280)
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
   let image = UIImage(named:"100")
   let imageView = UIImageView(image: image)
   imageView.frame = CGRect(x: 100, y: 320, width: 250, height: 168)
   self.view.addSubview(imageView)
 }
 func simpleGetUrlRequest() {
  let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
   let task = URLSession.shared.dataTask(with: url) {
   (data, response, error) in
   guard let data = data else { return }
   let country = try? JSONDecoder().decode(Weather.self, from: data)
   print(String(data: data, encoding: .utf8)!)
    DispatchQueue.main.async {
    self.citylabel.text = country?.name
    self.templabel.text = "\(Int(round(Double(country!.main.temp))))"
    self.humiditylabel.text = "\(Int(round(Double(country!.main.humidity))))"
    self.mainlabel.text = country!.weather[0].main
    self.describtionlabel.text = country!.weather[0].description
   }
  }
  task.resume()
 }
}

