//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    let locationManager = CLLocationManager()
    var weatherInfo: WeatherInfo? {
        didSet {
            if weatherInfo != nil {
                updateUIWithWeatherData()
            }
        }
    }

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomViews()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        startLocationManager()
    }
    
    
    //MARK: - User Alerts
    func alertUser(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(parameters: [String: String]) {
        activityIndicator.startAnimating()
        ApiService.shared.getWeatherData(parameters: parameters, handler: { response in
            self.activityIndicator.stopAnimating()
            if response.result.isSuccess {
                let weatherJSON = JSON(response.result.value!)

                if let wInfo = ApiService.shared.generateWeatherFromJSON(weatherJSON) {
                    self.weatherInfo = wInfo
                } else {
                    self.handleAPIError(weatherJSON)
                }
            } else {
                self.alertUser(title: "Networking Error", message: "Could not resolve data from forecast website")
            }
        })
    }
    
    func handleAPIError(_ json: JSON){
        var errorMessage: String = ""
        if let message = json["message"].string {
            errorMessage = message
        } else {
            errorMessage = "It was not possible to generate data from API requests. Please try again later or report this error."
        }
        
        self.alertUser(title: "Ops...", message: errorMessage)
    }
    
    //MARK: - Custom Methods
    func setupCustomViews(){
        self.view.addSubview(activityIndicator)
        activityIndicator.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        activityIndicator.frame.size = CGSize(width: 75, height: 75)
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.center = self.view.center
        self.view.bringSubview(toFront: activityIndicator)
    }
    
    func startLocationManager(){
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        activityIndicator.startAnimating()
    }
    
    //MARK: - UI Updates
    func updateUIWithWeatherData() {
        guard let info = weatherInfo else { return }
        
        weatherIcon.image = UIImage(named: info.currentWeatherIcon())
        cityLabel.text = info.location.city
        temperatureLabel.text = "\(info.temperature)°"
    }
    
    //MARK: - Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, location.horizontalAccuracy > 0 else { return }
        locationManager.delegate = nil
        
        print("Longitude: \(location.coordinate.longitude), Latitude: \(location.coordinate.latitude)")
        
        let params : [String:String] = [
            "lat" : String(location.coordinate.latitude),
            "lon" : String(location.coordinate.longitude)
        ]
        
        getWeatherData(parameters: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    func changedCity(city: String) {
        let params: [String: String] = ["q": city]
        getWeatherData(parameters: params)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destination = segue.destination as! ChangeCityViewController
            destination.delegate = self
        }
    }
    
    //MARK: - User Location Options
    @IBAction func getGPSBasedWeather(_ sender: Any) {
        weatherInfo = nil
        refreshData()
    }
    
    @IBAction func refreshWeatherInfo(_ sender: Any) {
        refreshData()
    }
    
    func refreshData(){
        if weatherInfo == nil {
            startLocationManager()
        } else {
            changedCity(city: weatherInfo!.location.city)
        }
    }
    
}


