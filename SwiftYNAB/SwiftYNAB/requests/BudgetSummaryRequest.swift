//
//  BudgetSummaryRequest.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 7/8/22.
//  Copyright © 2022 Andre Bocchini. All rights reserved.
//

import Foundation

struct BudgetSummaryRequest {

    let includeAccounts: Bool?

    init(includeAccounts: Bool? = nil) {
        self.includeAccounts = includeAccounts
    }
}

extension BudgetSummaryRequest: Request {
    var path: String {
        "/v1/budgets"
    }

    var query: [URLQueryItem]? {
        guard let includeAccounts else {
            return nil
        }

        return [URLQueryItem(
            name: "include_accounts",
            value: "\(includeAccounts)"
        )]
    }
}
