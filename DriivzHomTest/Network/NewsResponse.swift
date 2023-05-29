//
//  NewsResponse.swift
//  DriivzHomTest
//
//  Created by Yadin Gamliel on 27/05/2023.
//

import Foundation

enum DTAResult<T> {
    case success(T)
    case failure(DTAError)
}

enum DTAError: Error {
    case NetworkError(Error)
    case dataNotFound
    case SerializationError(Error)
    case StatusCodeError(Int)
    case UrlComponentError
    case ClassError
}

typealias NewsCompletion = (DTAResult<[Article]>) ->()

protocol DTAServiceProtocol {
    func fetchNews(completion: @escaping NewsCompletion)
}
