import SwiftUI

struct UserRequest: Codable {
    let action: String
    let firstName: String?
    let lastName: String?
    let email: String
    let password: String
}

struct UserResponse: Codable {
    let status: String
    let message: String
}

enum NetworkingError: Error {
    case invalidStatusCode(Int)
    case decodingFailed(Error)
    case requestFailed(Error)
    case noDataReceived
}

struct NetworkManager {
    
    func registerUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://balloontask.store/api.php") else {
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(action: "register", firstName: firstName, lastName: lastName, email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://balloontask.store/api.php") else {
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(action: "login", firstName: nil, lastName: nil, email: email, password: password)
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func deleteUser(email: String, completion: @escaping (Result<UserResponse, NetworkingError>) -> Void) {
        guard let url = URL(string: "https://balloontask.store/api.php") else {
            completion(.failure(.requestFailed(NSError(domain: "Invalid URL", code: 0))))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = UserRequest(action: "delete", firstName: nil, lastName: nil, email: email, password: "")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidStatusCode((response as? HTTPURLResponse)?.statusCode ?? 0)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(UserResponse.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
}
