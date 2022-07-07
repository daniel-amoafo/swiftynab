//
//  HybridTransactionsResponse.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 7/8/22.
//  Copyright © 2022 Andre Bocchini. All rights reserved.
//

import Foundation

struct HybridTransactionsResponse: Codable {
    let transactions: [HybridTransaction]
}
