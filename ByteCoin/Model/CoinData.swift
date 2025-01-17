//
//  CoinData.swift
//  ByteCoin
//
//  Created by Ryan Henzell-Hill on 21/06/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}
