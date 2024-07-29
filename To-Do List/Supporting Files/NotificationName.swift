//
//  NotificationName.swift
//  To-Do List
//
//  Created by Owais on 02/07/24.
//

import Foundation

extension Notification.Name {
    static let reloadFetchData = Notification.Name("reloadFetchData")
    static let refreshDeleteLabel = Notification.Name("reloadDeleteLbl")
    static let updateDeleteLblNumber = Notification.Name("increaseDeleteLbl")
    static let reloadCellHeight = Notification.Name("reloadCellHeight")
    static let clearBtnRefresh = Notification.Name("clearBtnRefresh")
    static let updateRefresh = Notification.Name("updateRefresh")
}
