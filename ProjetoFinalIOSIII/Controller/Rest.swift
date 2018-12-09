//
//  Rest.swift
//  ProjetoFinalIOSIII
//
//  Created by Josimar  Fiuza Melo on 02/12/18.
//  Copyright © 2018 Josimar Fiuza Melo. All rights reserved.
//

import Foundation

enum CarError{
    case url
    case taskError(error:Error)
    case noResponse
    case noData
    case responseStatusCode(code:Int)
    case invalidJson
}

class Rest {
    
    static let basePath = "https://carangas.herokuapp.com/cars"
    static let session = URLSession(configuration: configuration)
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
            config.allowsCellularAccess = false
            config.httpAdditionalHeaders = ["Content-Type":"application/json"]
            config.timeoutIntervalForRequest = 30.0
            config.httpMaximumConnectionsPerHost = 5
        return config
    }()    
    
    func loadCars(onComplete:@escaping ([Car])->Void,onError:@escaping (CarError)->Void) {
        
        guard let url = URL(string: Rest.basePath) else {
            onError(.url)
            return
        }
        
        let dataTask = Rest.session.dataTask(with: url) { (data, response, error) in
            if error == nil{
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200{
                    guard let data = data else {
                        onError(.noData)
                        return
                    }
                    do{
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    }catch{
                       onError(.invalidJson)
                    }
                    
                }else{
                    print("Status Invalido pelo servidor")
                    onError(.responseStatusCode(code: response.statusCode ))
                }
                
            }else{
                print(error!)
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
    class func save(car: Car, onComplete: @escaping (Bool) -> Void){
        
        guard let url = URL(string: Rest.basePath) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
        guard let json = try? JSONEncoder().encode(car) else{
            onComplete(false)
            return
        }
        
        request.httpBody = json

        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil{
                guard let response = response as? HTTPURLResponse , response.statusCode == 200, let _ = data else{
                    onComplete(false)
                    return
                }
                onComplete(true)
            }else{
                onComplete(false)
            }
        }
        dataTask.resume()
        }
}
