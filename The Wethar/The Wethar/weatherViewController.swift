//
//  ViewController.swift
//  The Wethar
//
//  Created by sara al zhrani on 19/03/1443 AH.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
  var climate : weather!
    
  let citylabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
    return label
  }( )
    
    
    let countrylabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      label.numberOfLines = 0
      label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
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
    label.text = " "
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
    return label } ( )
  let feelLikeLabel: UILabel = {
    let label = UILabel ( )
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = " "
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 40, weight: .light)
    return label } ( )
  override func viewDidLoad() {
    super.viewDidLoad()
      
      simpleGetUrlRequest()
      
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = UIImage(named: "dark_mood")
    backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
    self.view.insertSubview(backgroundImage, at: 0)
    view.addSubview(citylabel)
    NSLayoutConstraint.activate([
      citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
      citylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 190)
    ])
      
      view.addSubview(countrylabel)
      NSLayoutConstraint.activate([
        countrylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
        countrylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 100)
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
    let image = UIImage(named: "sun")
    let imageView = UIImageView(image: image!)
    imageView.frame = CGRect(x: 100, y: 320, width: 195, height: 200)
    self.view.addSubview(imageView)
      
    
      let swipe = UISwipeGestureRecognizer(
          target: self,
          action: #selector(Jeddah))
      swipe.direction = .right
      view.addGestureRecognizer(swipe)
      view.isUserInteractionEnabled = true
      
      
      
      let swip = UISwipeGestureRecognizer(
          target: self,
          action: #selector(London))
      swipe.direction = .left
      view.addGestureRecognizer(swip)
      view.isUserInteractionEnabled = true
      
      
  }
      
    
    @objc func Jeddah() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Jeddah&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
        let task = URLSession.shared.dataTask(with: url) {
          (data, response, error) in
          guard let data = data else { return }
          let climte = try? JSONDecoder().decode(Weather.self, from: data)
          print(String(data: data, encoding: .utf8)!)
            
            
          DispatchQueue.main.async {
              self.citylabel.text = climte?.name
    //        self.templabel.text = "\(Int(round(Double(climte.main.humidity))))"
              
              self.templabel.text = "\(Int(round(Double(climte?.main.temp ?? 00))))"
            self.feelLikeLabel.text =       "\(Int(round(Double(climte!.main.humidity))))"
            self.mainlabel.text = climte?.weather[0].main
              self.describtionlabel.text = climte!.weather[0].description
    //          self.countrylabel.text = climte!.Sys.country
          }
        }
        task.resume()
      }
    
    
    @objc func London() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=dammam&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
        let task = URLSession.shared.dataTask(with: url) {
          (data, response, error) in
          guard let data = data else { return }
          let climte = try? JSONDecoder().decode(Weather.self, from: data)
          print(String(data: data, encoding: .utf8)!)
            
            
          DispatchQueue.main.async {
              self.citylabel.text = climte?.name
    //        self.templabel.text = "\(Int(round(Double(climte.main.humidity))))"
              
              self.templabel.text = "\(Int(round(Double(climte?.main.temp ?? 00))))"
            self.feelLikeLabel.text =       "\(Int(round(Double(climte!.main.humidity))))"
            self.mainlabel.text = climte?.weather[0].main
              self.describtionlabel.text = climte!.weather[0].description
    //          self.countrylabel.text = climte!.Sys.country
          }
        }
        task.resume()
      }
    
    
    
    
    

    
  func simpleGetUrlRequest() {
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric")!
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      guard let data = data else { return }
      let climte = try? JSONDecoder().decode(Weather.self, from: data)
      print(String(data: data, encoding: .utf8)!)
        
        
      DispatchQueue.main.async {
          self.citylabel.text = climte?.name
//        self.templabel.text = "\(Int(round(Double(climte.main.humidity))))"
          
          self.templabel.text = "\(Int(round(Double(climte?.main.temp ?? 00))))"
        self.feelLikeLabel.text =       "\(Int(round(Double(climte!.main.humidity))))"
        self.mainlabel.text = climte?.weather[0].main
          self.describtionlabel.text = climte!.weather[0].description
//          self.countrylabel.text = climte!.Sys.country
      }
    }
    task.resume()
  }
}

