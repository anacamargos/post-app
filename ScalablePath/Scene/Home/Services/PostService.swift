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
    func getPosts(then handle: @escaping (Result<[PostCompleteResponse], PostServiceError>) -> Void)
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
    
    private func getUserData(postEntities: [PostResponseEntity], then handle: @escaping (Result<[PostCompleteResponse], PostServiceError>) -> Void) {
        guard let apiURL = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        dispatch(ofType: [UserResponseEntity].self, url: apiURL) { [weak self] result in
            switch result {
            case let .success(userResponse):
                self?.handleSuccessOnServices(postEntities: postEntities, usersResponseEntity: userResponse, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
    
    private func handleSuccessOnServices(
        postEntities: [PostResponseEntity],
        usersResponseEntity: [UserResponseEntity],
        then handle: @escaping (Result<[PostCompleteResponse], PostServiceError>) -> Void
    ) {
        let postCompleteResponse = postEntities.map {
            PostCompleteResponse(authorName: getAuthorName(from: $0.userId, usersData: usersResponseEntity), postTitle: $0.title, postContent: $0.body)
        }
        handle(.success(postCompleteResponse))
    }
    
    private func getAuthorName(from userId: UInt, usersData: [UserResponseEntity]) -> String {
        let selectedUser = usersData.first(where: { $0.id == userId})
        return selectedUser?.name ?? ""
    }
    
    // MARK: - PostServiceProvider
    
    func getPosts(then handle: @escaping (Result<[PostCompleteResponse], PostServiceError>) -> Void) {
        guard let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        dispatch(ofType: [PostResponseEntity].self, url: apiURL) { [weak self] result in
            switch result {
            case let .success(response):
                self?.getUserData(postEntities: response, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
}
