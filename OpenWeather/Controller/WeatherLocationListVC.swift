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
        loadTableData()
        loadLocationData()
    }
    
    // MARK:- Table View Observer
    private func loadTableData() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
            // to add array here
        })
    }
    
    // MARK:- Fetch Given cities weather condition
    private func loadLocationData() {
        weatherManager.fetchBulkWeather()
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
}

//MARK: - WeatherManagerDelegate

extension WeatherLocationListVC: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherViewModel) {
//        arrayLocations.insert(weather, at: arrayLocations.value.count)
    }
    
    func didUpdateBulkWeather(_ weatherManager: WeatherManager, weather: [WeatherViewModel]) {
        for (ind, bulkWeather) in weather.enumerated() {
            arrayLocations.insert(bulkWeather, at: ind)
        }
    }
    
    func didFailWithError(error: String) {
        showAlert(error)
    }
}

//MARK:- Tableview delegate and datasource methods

extension WeatherLocationListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passvc = StoryBoardMain.detailVC.instantiate()
//        passvc.weather = arrayLocations.value[indexPath.row]
        self.present(passvc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.row == 0 { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.strDelete) { (action, view, handler) in
            self.arrayLocations.remove(at: indexPath.row)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}


