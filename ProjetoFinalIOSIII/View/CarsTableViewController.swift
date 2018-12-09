//
//  CarsTableViewController.swift
//  ProjetoFinalIOSIII
//
//  Created by Josimar  Fiuza Melo on 02/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    let rest = Rest()
    var cars:[Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rest.loadCars(onComplete: { (cars) in
            self.cars = cars
            
            DispatchQueue.main.async { //inserir na tread principal
                self.tableView.reloadData()
            }
            
        }) { (error) in
            print(error)
//            switch error{
//                case .invalidJson
//            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cars.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let car = cars[indexPath.row]
    
            cell.textLabel?.text = car.name
            cell.detailTextLabel?.text = car.brand

        return cell
    }

}
