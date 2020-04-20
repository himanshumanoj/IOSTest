//
//  TelstraModelData.swift
//  Telstra IOS Test
//
//  Created by M Himanshu on 4/20/20.
//  Copyright © 2020 com.himanshu. All rights reserved.
//

import Foundation
import UIKit

/// Telstra Data Model
struct ModelRowData : Decodable {
    var title: String?
    var description:String?
    var imageHref: String?
}
struct TelstraModelData:Decodable {
    var title : String?
    var rows: [ModelRowData]
}

