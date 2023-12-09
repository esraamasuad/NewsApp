//
//  NetworkMonitor.swift
//  NewsApp
//
//  Created by Esraa on 08/12/2023.
//

import Foundation
import Network

//@Observable
class NetworkMonitor: ObservableObject {
    private var networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    @Published private(set) var isConnected: Bool = true
//    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
