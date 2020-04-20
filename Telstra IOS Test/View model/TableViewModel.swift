//
//  TableViewModel.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import UIKit

protocol Responder {
    func updateRowData(_ data: [ModelRowData])
    func updateTitle(_ title: String)
}

/// View Model for the Telstra Table view
class TableViewModel {
    let responder: Responder
    init(responder: Responder) {
        self.responder = responder
    }
    
    func loadTelstraData() {
        DispatchQueue.global(qos: .userInitiated).async {
            DataManager.loadJson(completion: { (dataSet, title) in
                      print("loadTelstraData inside ***")
                 DispatchQueue.main.async {
                    self.responder.updateRowData(dataSet.filter( { $0.title != nil }))
                    self.responder.updateTitle(title)
                }
            })
            print("loadTelstraData ***")
        }
    }
}
