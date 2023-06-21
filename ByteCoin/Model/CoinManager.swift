//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinRate(_ coinManager: CoinManager, coinModel: CoinModel)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9677B3EC-41E1-419D-B88D-80AE24624ED2"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

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
            guard let coinModel = parseJSON(for: safeData) else { return }
            delegate?.didUpdateCoinRate(self, coinModel: coinModel)
        }
        
        // 4. Start the task
        task.resume()
    }
    
    func parseJSON(for coinData: Data) -> CoinModel? {
        var coinModel: CoinModel?
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            coinModel = CoinModel(rate: decodedData.rate, currency: decodedData.asset_id_quote)
        } catch {
            print(error)
        }
        
        return coinModel
    }
}
