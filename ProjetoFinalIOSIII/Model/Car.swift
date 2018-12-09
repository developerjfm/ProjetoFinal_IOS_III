//
//  User.swift
//  ProjetoFinalIOSIII
//
//  Created by Josimar  Fiuza Melo on 01/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import Foundation

struct Car: Codable {
    
    var _id:String?
    var brand:String = ""
    var gasType:Int = 0
    var name:String = ""
    var price:Double = 0.0
    
    var gas:String{
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Alcool"
        default:
            return "Gasolina"
        }
    }
    
}
