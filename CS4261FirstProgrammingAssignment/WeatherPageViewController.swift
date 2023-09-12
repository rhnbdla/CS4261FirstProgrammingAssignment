//
//  WeatherPageViewController.swift
//  CS4261FirstProgrammingAssignment
//
//  Created by Rohan Bodla on 9/11/23.
//

import UIKit
import FirebaseFirestore

class WeatherPageViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var zipNumber: UITextField!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let databaseVals = Firestore.firestore()
    
    let apiValue = "2148d15372c6bca829f403c4d7a8c9af"
    //get key from https://home.openweathermap.org/api_keys
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd hh:mm:ss"
        dateLabel.text = dateFormatter.string(from: Date())
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=30313,us&units=imperial&appid=\(apiValue)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    let locationName = (json["name"] as? String ?? "...")?.capitalizingFirstLetter()
                    let feelsLikeVal = Int(weatherMain["feels_like"] as? Double ?? 0)
                    let maxTempVal = Int(weatherMain["temp_max"] as? Double ?? 0)
                    let minTempVal = Int(weatherMain["temp_min"] as? Double ?? 0)
                    let humidityVal = Int(weatherMain["humidity"] as? Double ?? 0)
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, locationName: locationName, feelsLikeVal: feelsLikeVal, maxTempVal: maxTempVal, minTempVal: minTempVal, humidityVal: humidityVal)
                    }
                }
                catch{
                    print("Error in retrieving weather")
                }
            }
            
        }
        task.resume()
    }
    
    @IBAction func weatherLookUp(_ sender: UIButton) {
        if zipNumber.text?.count != 5 {
            print("error in ZIP code")
            return
        }
        let zipText = zipNumber.text ?? "30313"
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?zip=\(zipNumber.text ?? "30313"),us&units=imperial&appid=\(apiValue)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                    guard let weatherDetails = json["weather"] as? [[String : Any]], let weatherMain = json["main"] as? [String : Any] else { return }
                    let temp = Int(weatherMain["temp"] as? Double ?? 0)
                    let description = (weatherDetails.first?["description"] as? String)?.capitalizingFirstLetter()
                    let locationName = (json["name"] as? String ?? "...")?.capitalizingFirstLetter()
                    let feelsLikeVal = Int(weatherMain["feels_like"] as? Double ?? 0)
                    let maxTempVal = Int(weatherMain["temp_max"] as? Double ?? 0)
                    let minTempVal = Int(weatherMain["temp_min"] as? Double ?? 0)
                    let humidityVal = Int(weatherMain["humidity"] as? Double ?? 0)
                    DispatchQueue.main.async {
                        self.setWeather(weather: weatherDetails.first?["main"] as? String, description: description, temp: temp, locationName: locationName, feelsLikeVal: feelsLikeVal, maxTempVal: maxTempVal, minTempVal: minTempVal, humidityVal: humidityVal)
                    }
                    self.writeData(zipVal: zipText, temp: temp)
                    
                }
                catch{
                    print("Error in retrieving weather")
                }
            }
            
        }
        task.resume()
    }
    func setWeather(weather: String?, description: String?, temp: Int, locationName: String?, feelsLikeVal: Int, maxTempVal: Int, minTempVal: Int, humidityVal: Int) {
        descriptionLabel.text = description ?? "..."
        temperatureLabel.text = "\(temp)°"
        locationNameLabel.text = locationName ?? "..."
        feelsLikeLabel.text = "Feels Like: \(feelsLikeVal)°"
        maxTempLabel.text = "Max Temp: \(maxTempVal)°"
        minTempLabel.text = "Min Temp: \(minTempVal)°"
        humidityLabel.text = "Humidity: \(humidityVal)%"
        switch weather {
        case "Sunny":
            background.backgroundColor = UIColor(red: 0.97, green: 0.78, blue: 0.35, alpha: 1.0)
        default:
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
        }
        
    }
    func writeData(zipVal: String, temp: Int) {
        let docRef = databaseVals.document("history/\(zipVal)")
        docRef.setData(["temp": temp])
    }

}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
