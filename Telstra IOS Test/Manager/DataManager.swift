//
//  DatamodelManager.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import Foundation
class DataManager: NSObject {
        
    /// get data from server
    static func loadJson(completion: ([ModelRowData],String)->()) {
        if let url = URL(string: URL_STRING_TELSTRA){
            do {
                let data = try Data(contentsOf: url)
                let str = String(data: data, encoding: .windowsCP1250)
                let data1 = str!.data(using: .utf8)!
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TelstraModelData.self, from: data1)
                completion(jsonData.rows, jsonData.title ?? "")
            } catch {
                print("error:\(error)")
                completion([],"")
            }
        }
    }
}
