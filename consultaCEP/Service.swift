import Foundation

enum ServiceError: Error {
    case invalidURL
    case network
    case unknownData
}

class Service {
    
    private let baseURL = "https://viacep.com.br/ws"
    
    func get(cep: String, callback: @escaping (Result<CEPModel, ServiceError>) -> Void) {
        let path = "/\(cep)/json"
        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.network))
                return
            }
            do {
            let json = try JSONDecoder().decode(CEPModel.self, from: data)
            callback(.success(json))
            } catch {
                callback(.failure(.unknownData))
            }
        }
        task.resume()
    }
}

