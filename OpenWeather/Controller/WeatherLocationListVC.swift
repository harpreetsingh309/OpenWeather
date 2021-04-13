//
//  WeatherLocationListVC.swift
//  OpenWeather
//
//  Created by macexpert on 13/04/21.
//

import UIKit

class WeatherLocationListVC: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    private var arrayLocations: [WeatherViewModel] = []
    private let cellID = "WeatherTableViewCell"
    private var weatherManager = WeatherManager()
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        let nib = UINib(nibName: cellID, bundle: nil)
        weatherTableView.register(nib, forCellReuseIdentifier: cellID)
        loadLocationData()
    }
    
    // MARK:- Fetch Given cities weather condition
    private func loadLocationData() {
        weatherManager.fetchBulkWeather(cityId: "\(Cities.melbourne.rawValue),\(Cities.sydney.rawValue),\(Cities.brisbane.rawValue)")
    }
    
    @IBAction func actionAddNewLocation(_ sender: UIButton) {
        UIAlertController.showAlert(Constants.strSearch, message: AlertConstant.alertMsg, buttons: [AlertConstant.alertSearch,AlertConstant.alertCancel], isText: true) { [weak self] (alert, index) in
            if index == 0 {
                let searchQuery = alert.textFields![0] as UITextField
                let text = searchQuery.text?.replacingOccurrences(of: " ", with: "%20")
                if searchQuery.text != "" {
                    self?.weatherManager.fetchWeather(cityName: text!)
                } else {
                    self?.showAlert(Errors.EmptyError)
                }
            }
        }
    }
    
    // MARK:- Alerts
    
    private func showAlert(_ msg: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            Alert.showAlert(message: msg)
        }
    }
    
    private func updateView() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherLocationListVC: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherViewModel) {
        arrayLocations.append(weather)
        updateView()
    }
    
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [WeatherViewModel]) {
        arrayLocations = weather
        updateView()
    }
    
    func didFailWithError(error: String) {
        showAlert(error)
    }
}

//MARK:- Tableview delegate and datasource methods

extension WeatherLocationListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! WeatherTableViewCell
        cell.updateCell(with: arrayLocations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passvc = StoryBoardMain.detailVC.instantiate()
        passvc.weather = arrayLocations[indexPath.row]
        self.present(passvc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.strDelete) {[weak self] (action, view, handler) in
            self?.arrayLocations.remove(at: indexPath.row)
            self?.updateView()
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}


