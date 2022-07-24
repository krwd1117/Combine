//
//  APIService.swift
//  CombineAPI
//
//  Created by Jeongwan Kim on 2022/07/24.
//

import Foundation
import Combine

enum API {
    case fetchTodos // 할 일 가져오기
    case fetchPosts // 포스트 가져오기
    
    var url: URL {
        switch self {
        case .fetchTodos:
            return URL(string: "https://jsonplaceholder.typicode.com/todos")!
        case .fetchPosts:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}

struct APIService {
    
    static let shared = APIService()
    
    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        return URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchPosts(_ todosCount: Int = 0) -> AnyPublisher<[Post], Error> {
        print("DEBUG: todosCount \(todosCount)")
        return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    /// Todos, Posts 동시 호출
    /// - Returns:
    func fetchTodosAndPostsAtTheSameTime() -> AnyPublisher<([Todo], [Post]), Error> {
        let fetchedTodos = fetchTodos()
        let fetchedPosts = fetchPosts()
        
        return Publishers.CombineLatest(fetchedTodos, fetchedPosts)
            .eraseToAnyPublisher()
    }
    
    /// Todos 호출 후 Posts 호출
    /// - Returns: 
    func fetchTodosAndThenPosts() -> AnyPublisher<[Post], Error> {
        return fetchTodos()
            .flatMap { todos in
                return fetchPosts(todos.count).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    func fetchTodosUnder200() -> AnyPublisher<[Post], Error> {
        return fetchTodos()
                .map { $0.count }
                .filter { $0 < 200 }
                .flatMap { _ in
                    return fetchPosts().eraseToAnyPublisher()
                }.eraseToAnyPublisher()
    }
}
