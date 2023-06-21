//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Ryan Henzell-Hill on 21/06/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    let currency: String
    
    var formattedRateString: String {
        return String(format: "%.2f", rate)
    }
}
