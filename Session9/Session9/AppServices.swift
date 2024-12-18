//
//  AppService.swift
//  Session9
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import Alamofire

class AppServices {
    static let shared = AppServices()
    
    private let baseUrl = "https://2782e730-dbaf-414a-8426-bc759689516f.mock.pstmn.io"
    
    private var getPriorities: String { "\(baseUrl)/getPriorities" }
    private var getTags: String { "\(baseUrl)/getTags" }
    private var getCategories: String { "\(baseUrl)/getAllCategories" }
    
    func getListPriorities() async throws -> [Priority] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getPriorities)
                .validate()
                .responseDecodable(of: [Priority].self) {resp in
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListTags() async throws -> [Tag] {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getTags)
                .validate()
                .responseDecodable(of: [Tag].self) {resp in
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getListCategories() async throws -> [Category] {	
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(getCategories)
                .validate()
                .responseDecodable(of: [Category].self) {resp in
                    switch resp.result {
                    case .success(let items): continuation.resume(returning: items)
                    case .failure(let error): continuation.resume(throwing: error)
                    }
                }
        }
    }
    
}
