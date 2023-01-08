//
//  ApiCommunicationProvider.swift
//  prueba-ios
//
//  Created by Guille on 8/1/23.
//

import Foundation
import Alamofire

final class ApiCommunicationProvider {
    
    // MARK: - Constants
    
    /// Static instance of ApiCommunicationProvider.
    static let shared = ApiCommunicationProvider()
    
    /// API Base URL.
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    /// Successful status codes.
    private let statusOk = 200...299
    
    // MARK: - Functions
    
    /// Gets the list of all characters from the API https://rickandmortyapi.com/api/ .
    /// - Parameters:
    /// - success: Function that is executed in case the response has been successful.
    /// - failure: Function that is executed in case the response has failed.
    func getAllCharacters(success: @escaping (_ characters: [CharacterStruct]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(baseUrl)character"
        
        AF.request(url, method: .get).validate(statusCode: statusOk).responseDecodable (of: CharacterResponseStruct.self) {
            response in
            
            if let characters = response.value?.results {
                success(characters)
            } else {
                failure(response.error)
            }
        }
    }
}
