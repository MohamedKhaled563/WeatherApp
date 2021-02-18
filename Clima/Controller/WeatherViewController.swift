

import UIKit
import CoreLocation
import AVFoundation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var reportButtonTitleLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    var searchedLongitude: Double?
    var searchedLatitide: Double?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        humidityLabel.roundCorners()
        cityLabel.roundCorners()
        reportButtonTitleLabel.roundCorners()
        
        citySearchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @IBAction func getCurrentLocationWeatherButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "doneSound", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    @IBAction func reportButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToReport", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ReportVC = segue.destination as! ReportPopUpViewController
        ReportVC.searchedLongitude = searchedLongitude
        ReportVC.searchedLatitide = searchedLatitide
    }
    
}

// MARK:- UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        citySearchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            textField.placeholder = "Search"
            return true
        } else {
            textField.placeholder = "Enter city name"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = textField.text{
            weatherManager.fetchWeather(withCityName: cityName)
        }
        textField.text = ""
    }
    
    
}

// MARK:- WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.playSound()
            self.conditionImageView.image = UIImage(systemName: weather.conditionImage, withConfiguration: nil)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.humidityLabel.text = String(format: "H:%d°", weather.humidity)
            self.descriptionLabel.text = weather.description
            self.searchedLatitide = weather.latitude
            self.searchedLongitude = weather.longitude
        }
    }
    func didFailWithError(_ weatherManager: WeatherManager, error: Error) {
        print(error)
    }
}


// MARK:- CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            searchedLatitide = location.coordinate.latitude
            searchedLongitude = location.coordinate.longitude
            if let latiude = searchedLatitide, let longitude = searchedLongitude{
                weatherManager.fetchWeather(withLatitude: latiude, andLongitude: longitude)
            }
        }
        
        //        print(locations)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension UILabel{
    func roundCorners(){
        self.layer.cornerRadius = self.frame.size.height / 3
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4235747502, green: 0.5289223559, blue: 0.6968487826, alpha: 0.4971886439)
        self.clipsToBounds = true
    }
}
