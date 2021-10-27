//
//  ViewController.swift
//  Weather Project
//
//  Created by Sara M on 20/03/1443 AH.
//

import UIKit

struct weatherAPI: Codable{
    let name: String
    let main: Main
    let weather: Array<weatherDis>
   
}

struct weatherDis :Codable {
    let description: String
}
struct Main : Codable {
    let temp: Double
    let humidity: Int
}




class ViewController: UIViewController {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let image = UIImageView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let imageview = UIImageView(image: UIImage(named: "background"))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        NSLayoutConstraint.activate([
            
            imageview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            imageview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            imageview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            imageview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])

        
        view.backgroundColor = UIColor(named: "weatherColour")
        
        label4.textAlignment = .center
        label4.text = "nil"
        label4.font = UIFont.boldSystemFont(ofSize: 30)
        label4.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label4)
        NSLayoutConstraint.activate([
            
            label4.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            label4.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 250),
            label4.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100)
            
        ])
        
        let image = UIImageView(image: UIImage(named: "hum"))
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        NSLayoutConstraint.activate([
            
            image.leftAnchor.constraint(equalTo: label4.leftAnchor, constant:250 ),
            image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 95),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        
    
           
        ])
        
        
        label3.textAlignment = .center
        label3.text = "nilll"
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.font = UIFont.boldSystemFont(ofSize: 40)
        
        self.view.addSubview(label3)
        NSLayoutConstraint.activate([
            
            label3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            label3.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400),
        ])
        
        
        
        
        
        
        
        label2.textAlignment = .center
        label2.text = "nill"
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.font = UIFont.boldSystemFont(ofSize: 60)
        
        self.view.addSubview(label2)
        NSLayoutConstraint.activate([
            
            label2.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 16),
            label2.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -16),
            label2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            label2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
        ])
        label1.textAlignment = .center
        label1.text = "nillll"
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = UIFont.boldSystemFont(ofSize: 70)
        
        self.view.addSubview(label1)
        NSLayoutConstraint.activate([
            
            label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            label1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 500),
            
            
        ])
        
        simpleGetUrlRequest()
    }
    
    func simpleGetUrlRequest() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Abha&appid=90ff1b516e38b23119e8f40f83596f6a")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
            let weather = try? JSONDecoder().decode(weatherAPI.self, from: data)
            
            
            DispatchQueue.main.async {
                self.label1.text = weather?.name
                self.label2.text = "\(Int(weather!.main.temp  - 273))"
                self.label3.text = weather!.weather[0].description
                self.label4.text = "\(weather!.main.humidity)"
                
                
            }
        }
        
        
        task.resume()
    }
}
