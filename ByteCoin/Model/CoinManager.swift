//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9677B3EC-41E1-419D-B88D-80AE24624ED2"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(to: urlString)
    }
    
    func performRequest(to urlString: String) {
        // 1. Create a URL object
        guard let url = URL(string: urlString) else { return }
        
        // 2. Create a URL session
        let session = URLSession(configuration: .default)
        
        // 3. Give the session a task
        let task = session.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let safeData = data else { return }
            parseJSON(for: safeData)
        }
        
        // 4. Start the task
        task.resume()
    }
    
    func parseJSON(for coinData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let price = decodedData.rate
            print(price)
        } catch {
            print(error)
        }
    }
}
