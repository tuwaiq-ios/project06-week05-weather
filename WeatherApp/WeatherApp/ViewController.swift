//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ahmed Assiri on 19/03/1443 AH.
//

import UIKit

struct Weather : Codable{
    let wind: Wind
    let name: String
    let main: Main
    let weather: Array<WeatherDesc>
    let clouds: All
    
}
struct All :Codable {
    let all: Int
}
struct WeatherDesc :Codable {
    let description: String
    let id : Int
}

struct Main : Codable {
    let temp: Double
    let humidity: Int
}
struct Wind: Codable{
    let speed: Double
}

//
// متغيرات ليبل وجعل له قيمه
//
class ViewController: UIViewController {
    let A1 = UILabel()
    let B2 = UILabel()
    let C3 = UILabel()
    let F4 = UILabel()
    let H5 = UILabel()
    let T6 = UILabel()
    let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lis()

        
        //
        //انشاء متغير للفيو وخلفية واعطائها قيود
        //
        let imageview = UIImageView(image: UIImage(named: "background"))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageview)
        NSLayoutConstraint.activate([
            
            imageview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            imageview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            imageview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            imageview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
        
        view.backgroundColor = UIColor(named: "background")
  
        A1.textAlignment = .center
        A1.text = "lable1"
        A1.font = UIFont.boldSystemFont(ofSize: 40)
    
        
        B2.textAlignment = .center
        B2.text = "lable2"
        B2.font = UIFont.boldSystemFont(ofSize: 40)


        C3.textAlignment = .center
        C3.text = "lable3"
        C3.font = UIFont.boldSystemFont(ofSize: 40)

        let stack = UIStackView(arrangedSubviews: [A1, B2, C3])
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            
            stack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            stack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80)
            
        ])
        
        
        H5.textAlignment = .center
        H5.text = "lable4"
        H5.translatesAutoresizingMaskIntoConstraints = false
        H5.font = UIFont.boldSystemFont(ofSize: 40)

        self.view.addSubview(H5)
        NSLayoutConstraint.activate([
            
            H5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            H5.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
        ])
        
        
        H5.textAlignment = .center
        H5.text = "lable5"
        H5.translatesAutoresizingMaskIntoConstraints = false
        H5.font = UIFont.boldSystemFont(ofSize: 30)

        self.view.addSubview(H5)
        NSLayoutConstraint.activate([
            
            H5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            H5.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -160),
            H5.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
        ])
        
     
        T6.textAlignment = .center
        T6.text = "lable6"
        T6.translatesAutoresizingMaskIntoConstraints = false
        T6.font = UIFont.boldSystemFont(ofSize: 40)

        self.view.addSubview(T6)
        NSLayoutConstraint.activate([
            
            T6.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
       
            T6.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            
            
        ])
    
            image.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(image)
            
            NSLayoutConstraint.activate([
                
                image.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
                image.topAnchor.constraint(equalTo: T6.topAnchor, constant: 250),
                image.heightAnchor.constraint(equalToConstant: 150),
                image.widthAnchor.constraint(equalToConstant: 250)
            ])
        
    }
    
    func lis() {
        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=Mecca&appid=90ff1b516e38b23119e8f40f83596f6a")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let post = try? JSONDecoder().decode(Weather.self, from: data)
            print(post)
            
            DispatchQueue.main.async {
                self.A1.text = "\(post!.wind.speed)"
                self.T6.text = post!.name
                self.H5.text = "\( (post!.main.temp - 273))"
                self.H5.text = post!.weather[0].description
                self.C3.text = "\(post!.main.humidity)"
                self.B2.text = "\(post!.clouds.all)"

            }
        }

    task.resume()
    
}
}
