//
//  TripListRequestBodyData.swift
//  Emberoute
//
//  Created by Syed Muhammad Aaqib Hussain on 10.02.25.
//

import UIKit

struct TripListRequestBodyData {
    let dateFrom: String
    let dateTo: String
    
    init(
        dateFrom: String =  DateFormatHelper.startOfTodayISO(),
        dateTo: String = DateFormatHelper.endOfTodayISO()
    ) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}
