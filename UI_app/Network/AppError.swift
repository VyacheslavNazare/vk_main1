//
//  AppError.swift
//  UI_app
//
//  Created by Вячеслав on 25.01.2022.
//

import Foundation

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectUrl
}
