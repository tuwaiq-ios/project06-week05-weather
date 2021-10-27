//
//  ViewController.swift
//  WEATHER
//
//  Created by Tsnim Alqahtani on 20/03/1443 AH.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    var climate : weatherAPI?
    // var A = [weather] ()
    let citylabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.textColor = UIColor.white
        return label
    }()
        
        let mainlabel: UILabel = {
            let label = UILabel( )
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = ""
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
            label.textColor = UIColor.white
            return label}( )



    let describtionlabel: UILabel = {
        let label = UILabel ( )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        label.textColor = UIColor.white
        return label } ()
    
    let templabel: UILabel = {
        let label = UILabel ( )
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = " "
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont.systemFont (ofSize: 45, weight: .heavy)
            label.textColor = UIColor.white
        label.highlightedTextColor = UIColor.white
        return label } ()
    
    
    let feellikeLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont (ofSize: 40, weight: .light)
        label.textColor = UIColor.white
        return label } ()
    
    override func viewDidLoad () {
        super.viewDidLoad ()

        simpleGeturlRequest()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Skybackground")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        view.addSubview(citylabel)
        
        NSLayoutConstraint.activate([
            citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor ), citylabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 190)
        ])
        
        
        view.addSubview(mainlabel)
        
        NSLayoutConstraint.activate([
            mainlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), mainlabel.topAnchor.constraint(equalTo: view.topAnchor, constant:250)
            
        ])
        view.addSubview(describtionlabel)
        
        NSLayoutConstraint.activate([
         describtionlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         
         ])
         view.addSubview(describtionlabel)
         
         NSLayoutConstraint.activate([
        describtionlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          describtionlabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 290)
          
          ])
         
          view.addSubview(templabel)
         NSLayoutConstraint.activate([
          templabel.centerXAnchor.constraint(equalTo: view.centerXAnchor), templabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 520)
         
         ])
         
         view.addSubview(feellikeLabel)
        
         NSLayoutConstraint.activate([
            feellikeLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            feellikeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
                                
            ])
                                     
                                     
            let wetherimage = "sun"
        let image = UIImage(named: "sun")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 100, y: 320, width: 195, height: 200); self.view.addSubview(imageView)
        
        }
        
        
     func simpleGeturlRequest () {
         let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=abha&appid=f12e5f499a47eee845b6c9236c9c13a7&units=metric" )!
         
         let task = URLSession.shared.dataTask(with: url) {
             (data, response, error) in
             guard let data = data else { return }
             
    //   let city = try? JSONDecoder().decode(TimeZone.self, from: data)
    let country = try? JSONDecoder().decode(weatherAPI.self,  from: data)
   // let B = try? JSONDecoder( ).decode([weather].self, from: data)
        print(String(data: data, encoding: .utf8)!)
                                            
    DispatchQueue.main.async {
        self.citylabel.text = country?.name
        self.templabel.text = "\(Int(round (Double(country!.main.humidity))))"
        self.feellikeLabel.text = "\(Int(round (Double(country!.main.feels_like))))"
        self.mainlabel.text = country?.weather[0].main
        self.describtionlabel.text = country?.weather[0].description

        
        
        
        }
         }
             task.resume()
        }
                }
