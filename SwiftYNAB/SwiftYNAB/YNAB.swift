//
//  YNAB.swift
//  SwiftYNAB
//
//  Created by Andre Bocchini on 5/4/19.
//  Copyright © 2019 Andre Bocchini. All rights reserved.
//

import Foundation

/// YNAB API client
public struct YNAB: Sendable {
    private let client: ClientType

    /// Provides access to user operations
    public let users: UserService

    /// Provides access to budget operations
    public let budgets: BudgetService

    /// Provides access to account operations
    public let accounts: AccountService

    /// Provides access to category operations
    public let categories: CategoryService

    /// Provides access to payee operations
    public let payees: PayeeService

    /// Provides access to payee location operations
    public let payeeLocations: PayeeLocationService

    /// Provides access to month operations
    public let months: MonthService

    /// Provides access to transaction operations
    public let transactions: TransactionService

    /// Provides access to scheduled transaction operations
    public let scheduledTransactions: ScheduledTransactionService

    /// Initializes the YNAB API client
    ///
    /// - Parameters:
    ///    - accessToken: Personal API access token, or token obtained via OAuth login
    ///    - urlSession: By default, it uses the default `URLSession.shared`, but allows the injection of a custom session
    public init(accessToken: String, urlSession: URLSession = .shared) {
        client = Client(
            accessToken: accessToken,
            urlSession: urlSession,
            serializer: Serializer.shared
        )
        self.users = UserService(client: client)
        self.budgets = BudgetService(client: client)
        self.accounts = AccountService(client: client)
        self.categories = CategoryService(client: client)
        self.payees = PayeeService(client: client)
        self.payeeLocations = PayeeLocationService(client: client)
        self.months = MonthService(client: client)
        self.transactions = TransactionService(client: client)
        self.scheduledTransactions = ScheduledTransactionService(client: client)
    }
}
