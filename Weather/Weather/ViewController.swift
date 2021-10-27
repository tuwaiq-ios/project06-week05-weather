//
//  ViewController.swift
//  Weather
//
//  Created by Hassan Yahya on 20/03/1443 AH.
//

import UIKit

struct WeatherData : Codable{
	let wind: Wind
	let name: String
	let main: Main
	let weather: Array<weatherDis>
	let clouds: All
	
}
struct All :Codable {
	let all: Int
}
struct weatherDis :Codable {
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


class ViewController: UIViewController {
	let label = UILabel()
	let label1 = UILabel()
	let label2 = UILabel()
	let label3 = UILabel()
	let label4 = UILabel()
	let label5 = UILabel()
	let img = UIImageView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lis()
		//labels
		let imageview = UIImageView(image: UIImage(named: "background"))
		imageview.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(imageview)
		NSLayoutConstraint.activate([
			
			imageview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
			imageview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
			imageview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
			imageview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
		])
		
		view.backgroundColor = UIColor(named: "fff")
		//view.backgroundColor = .cyan
		label.textAlignment = .center
		label.text = "HASSAN"
		label.font = UIFont.boldSystemFont(ofSize: 30)
		//		view.backgroundColor = .cyan
		
		label1.textAlignment = .center
		label1.text = "HSAN"
		label1.font = UIFont.boldSystemFont(ofSize: 30)

		
		//		view.backgroundColor = .cyan
		label2.textAlignment = .center
		label2.text = "xsdfghj"
		label2.font = UIFont.boldSystemFont(ofSize: 30)

		let stack = UIStackView(arrangedSubviews: [label, label1, label2])
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stack)
		NSLayoutConstraint.activate([
			
			stack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
			stack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
			stack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80)
			
		])
		
		
		
		//		view.backgroundColor = .cyan
		label3.textAlignment = .center
		label3.text = "12222222222"
		label3.translatesAutoresizingMaskIntoConstraints = false
		label3.font = UIFont.boldSystemFont(ofSize: 30)

		self.view.addSubview(label3)
		NSLayoutConstraint.activate([
			
			//	label3.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 16),
			label3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
			label3.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
		])
		
		//		view.backgroundColor = .cyan
		label4.textAlignment = .center
		label4.text = "7777777"
		label4.translatesAutoresizingMaskIntoConstraints = false
		label4.font = UIFont.boldSystemFont(ofSize: 22)

		self.view.addSubview(label4)
		NSLayoutConstraint.activate([
			
			label4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
			label4.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -160),
			label4.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
		])
		
		//		view.backgroundColor = .cyan
		label5.textAlignment = .center
		label5.text = "00000000"
		label5.translatesAutoresizingMaskIntoConstraints = false
		label5.font = UIFont.boldSystemFont(ofSize: 30)

		self.view.addSubview(label5)
		NSLayoutConstraint.activate([
			
			label5.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
			//label5.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -160),
			label5.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
			
			
		])
	
			img.translatesAutoresizingMaskIntoConstraints = false
			
			view.addSubview(img)
			
			NSLayoutConstraint.activate([
				
				img.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
				//label5.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -160),
				img.topAnchor.constraint(equalTo: label5.topAnchor, constant: 250),
				img.heightAnchor.constraint(equalToConstant: 150),
				img.widthAnchor.constraint(equalToConstant: 250)
			])
		
	}
	
	func lis() {
		let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=Abha&appid=90ff1b516e38b23119e8f40f83596f6a")!
		
		let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
			guard let data = data else { return }
			let post = try? JSONDecoder().decode(WeatherData.self, from: data)
			print(post)
			
			DispatchQueue.main.async { [self] in
				self.label.text = "\(post!.wind.speed)"
				self.label5.text = post!.name
				self.label4.text = "\( (post!.main.temp - 273))"
				self.label3.text = post!.weather[0].description
				self.label2.text = "\(post!.main.humidity)"
				self.label1.text = "\(post!.clouds.all)"
				
				self.img.image = img.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
				self.img.tintColor = UIColor.white

				
				var img1 : String = "nosign"
				
				if (801...804).contains(post!.weather.first!.id) {
					img1 = "cloud.fill"
				}
				
				else if 800 == post!.weather.first!.id {
					img1 = "sun.max.fill"
				}
				
				else if (701...781).contains(post!.weather.first!.id) {
					img1 = "smoke.fill"
				}
				else if (600...622) .contains(post!.weather.first!.id) {
					img1 = "cloud.snow.fill"
				}
				else if (500...531) .contains(post!.weather.first!.id) {
					img1 = "cloud.rain.fill"
				}
				else if (300...321).contains(post!.weather.first!.id) {
					
					img1 = "cloud.drizzle.fill"
				}
				
				else if (200...232).contains(post!.weather.first!.id) {
					img1 = "cloud.bolt.rain.fill"
				}
				else {
					img1 = "nosign"
				}
				
				self.img.image = UIImage (systemName: img1)
			}
		}

	task.resume()
	
}
}
