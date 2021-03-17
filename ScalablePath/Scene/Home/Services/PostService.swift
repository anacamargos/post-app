//
//  PostService.swift
//  ScalablePath
//
//  Created by Ana Leticia Camargos on 17/03/21.
//

import Foundation

protocol URLSessionProvider {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
extension URLSession: URLSessionProvider {}

protocol PostServiceProvider {
    func getPosts(then handle: @escaping (Result<[PostResponseEntity], PostServiceError>) -> Void)
}

enum PostServiceError: Error {
    case genericError
}

struct PostResponseEntity: Codable {
    let userId: UInt
    let id: UInt
    let title: String
    let body: String
}

final class PostService: PostServiceProvider {
    
    // MARK: - Depencies
    
    private let urlSession: URLSessionProvider
    
    // MARK: - Intializer
    
    init(urlSession: URLSessionProvider) {
        self.urlSession = urlSession
    }
    
    // MARK: - Private Methods
    
    private func dispatch<T: Codable>(
        ofType: T.Type,
        url: URL,
        then handle: @escaping (Result<T, PostServiceError>) -> Void
    ) {
        let task = urlSession.dataTask(with: url) { data, response, error in
            guard let jsonData = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(T.self, from: jsonData)
                handle(.success(decoded))
            } catch {
                handle(.failure(.genericError))
            }
        }
        task.resume()
    }
    
    private func getUserData(userId: String, then handle: @escaping (Result<String, PostServiceError>) -> Void) {
        guard let apiURL = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        dispatch(ofType: String.self, url: apiURL) { result in
            <#code#>
        }
    }
    
    // MARK: - PostServiceProvider
    
    func getPosts(then handle: @escaping (Result<[PostResponseEntity], PostServiceError>) -> Void) {
        guard let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        dispatch(ofType: [PostResponseEntity], url: apiURL) { result in
            switch result {
            case let .success(response):
                getUserData(userId: response.userId, then: <#T##(Result<String, PostServiceError>) -> Void#>) {
                    handle(.success(<#T##[PostResponseEntity]#>))
                }
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
}

//{
//    "id": 1,
//    "name": "Leanne Graham",
//    "username": "Bret",
//    "email": "Sincere@april.biz",
//    "address": {
//      "street": "Kulas Light",
//      "suite": "Apt. 556",
//      "city": "Gwenborough",
//      "zipcode": "92998-3874",
//      "geo": {
//        "lat": "-37.3159",
//        "lng": "81.1496"
//      }
//    },
//    "phone": "1-770-736-8031 x56442",
//    "website": "hildegard.org",
//    "company": {
//      "name": "Romaguera-Crona",
//      "catchPhrase": "Multi-layered client-server neural-net",
//      "bs": "harness real-time e-markets"
//    }
//  },
//
