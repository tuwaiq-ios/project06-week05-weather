//
//  ViewController.swift
//  WeatherApp-week5-Afnan
//
//  Created by Fno Khalid on 20/03/1443 AH.
//

import UIKit
import Foundation

//let ApiKey: "e6832c3abb84f84b3356f4ff0c48a8cf"

class ViewController: UIViewController  {
    
    var climate : weatherAPI?
    
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
        label.font = UIFont.systemFont(ofSize: 38, weight: .light)
        
        return label
    }( )
    
    let timezonelabel: UILabel = {
        let label = UILabel( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label .font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return label } ( )
    
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
    
    let feelLikeLabel: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 40, weight: .light)
        return label } ( )
    
    
   
    
  let gradiantlayer = CAGradientLayer( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var date = Date( )
        var dateformatter = DateFormatter( )
        dateformatter.dateFormat = "EEE"
        self.timezonelabel.text = dateformatter.string(from: date)
        
       
        
        simpleGetUrlRequest()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "imageSet")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        view.addSubview(citylabel)
        NSLayoutConstraint.activate([
            citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            citylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 250)
        ])
        
        view.addSubview(countrylabel)
        NSLayoutConstraint.activate([
            countrylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countrylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 300)
        ])
        
        view.addSubview(timezonelabel)
        NSLayoutConstraint.activate([
            timezonelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timezonelabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 220)
        ])
        
        view.addSubview(mainlabel)
        NSLayoutConstraint.activate([
            mainlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainlabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 350)
        ])
        
        view.addSubview(describtionlabel)
        NSLayoutConstraint.activate([
            describtionlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            describtionlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 390)
        ])
        
        view.addSubview(templabel)
        NSLayoutConstraint.activate([
            templabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            templabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 620)
        ])
        
        view.addSubview(feelLikeLabel)
        NSLayoutConstraint.activate([
            feelLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelLikeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 700)
        ])
        
       
        let wetharimage = "cloud1"
        let image = UIImage(named: "cloud1")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: -20, y: 350, width: 450, height: 400)
        self.view.addSubview(imageView)
        
        
      let swipelift = UISwipeGestureRecognizer(
            target: self,
            action: #selector(Dammam))
      
        swipelift.direction = .left
        view.addGestureRecognizer(swipelift)
        view.isUserInteractionEnabled = true
        
        
        let swiperight = UISwipeGestureRecognizer(
              target: self,
              action: #selector(Riyadh))
        
        swiperight.direction = .right
          view.addGestureRecognizer(swiperight)
          view.isUserInteractionEnabled = true
    }
    
    func simpleGetUrlRequest() {
        
        let url = URL(string: "https://v1.nocodeapi.com/afnan/ow/DsXchckWaiWkbyfH/byCityName?q=ABHA")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
         
            let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                self.citylabel.text = country!.name
                self.templabel.text = "\(Int(round(Double(country!.main.humidity))))"
                self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))"
                self.mainlabel.text = country?.weather[0].main
                self.describtionlabel.text = country?.weather[0].description
                self.countrylabel.text = country?.sys.country
                self.timezonelabel.text = "\(Int(round(Double(country!.timezone))))"
            }
        }
        
        task.resume()
    }
    
    @objc  func Dammam() {
        
        let url = URL(string: "https://v1.nocodeapi.com/afnan/ow/DsXchckWaiWkbyfH/byCityName?q=Dammam")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
         
            let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                self.citylabel.text = country!.name
                self.templabel.text = "\(Int(round(Double(country!.main.humidity))))"
                self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))"
                self.mainlabel.text = country?.weather[0].main
                self.describtionlabel.text = country?.weather[0].description
                self.countrylabel.text = country?.sys.country
                self.timezonelabel.text = "\(Int(round(Double(country!.timezone))))"
            }
        }
        
        task.resume()
    }
    
    @objc  func Riyadh() {
        
        let url = URL(string: "https://v1.nocodeapi.com/afnan/ow/DsXchckWaiWkbyfH/byCityName?q=Riyadh")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
         
            let country = try? JSONDecoder().decode(weatherAPI.self, from: data)
            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                self.citylabel.text = country!.name
                self.templabel.text = "\(Int(round(Double(country!.main.humidity))))"
                self.feelLikeLabel.text = "\(Int(round(Double(country!.main.feels_like))))"
                self.mainlabel.text = country?.weather[0].main
                self.describtionlabel.text = country?.weather[0].description
                self.countrylabel.text = country?.sys.country
                self.timezonelabel.text = "\(Int(round(Double(country!.timezone))))"
            }
        }
        
        task.resume()
    }
}
