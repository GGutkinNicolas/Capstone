//
//  Weather.swift
//  SkydiveBook
//
//  Created by Guillaume Gutkin-Nicolas on 4/15/18.
//  Copyright © 2018 Guillaume Gutkin-Nicolas. All rights reserved.
//
import Foundation
import CoreLocation

struct Weather {

    let summary:String
    let icon:String
    let temperature:Double
    let windSpeed:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String
            else {
                throw SerializationError.missing("Missing the summary")
            }
        guard let icon = json["icon"] as? String
            else {
                throw SerializationError.missing("Missing the icon")
            }
        guard let temperature = json["temperatureHigh"] as? Double
            else {
                throw SerializationError.missing("Missing the temperature")
            }
        guard let windSpeed = json["windSpeed"] as? Double
            else {
                throw SerializationError.missing("Missing the wind speed")
        }
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.windSpeed = windSpeed
    }
    static let basePath = "https://api.darksky.net/forecast/4954ff2ee8888acb382b7edcc97f5a08/"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecast:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecast.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                completion(forecast)
            }
        }
        task.resume()
    }
}


