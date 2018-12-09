//
//  AddEditViewController.swift
//  ProjetoFinalIOSIII
//
//  Created by Josimar  Fiuza Melo on 02/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    var car:Car! = nil
    
    // MARK: - IBOutlets
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addEdit(_ sender: Any) {
        
        if car == nil {
            car = Car()
        }
    
        car.name = tfName.text!
        car.brand = tfBrand.text!
        if tfPrice.text!.isEmpty{tfPrice.text="0"}
        car.price = Double(tfPrice.text!)!
        car.gasType = scGasType.selectedSegmentIndex //indice para dizer o tipo de gasolina
        
        Rest.save(car: car){ (sucess) in
                self.goBack()
            }
    
    }
    
    func goBack() {
        DispatchQueue.main.sync {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
