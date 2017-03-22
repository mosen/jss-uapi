import Foundation

enum UapiError : Error {
    case InvalidJSONData
}

enum AuthenticationResult {
    case Success(Token)
    case Failure(Error)
}

enum UAPIPaths: String {
    case GenerateToken = "/uapi/auth/tokens"
}

class UAPI: NSObject {
    
    let baseURL: URL
    let credential: URLCredential
    let verifySSL: Bool
    
    init(url: URL, credential: URLCredential, verifySSL: Bool = True) {
        self.baseURL = url
        self.credential = credential
        self.verifySSL = verifySSL
    }
    
    func request(path: String) -> URLRequest {
        let requestURL = self.baseURL.appendingPathComponent(path)
        let req: URLRequest = URLRequest(url: requestURL)
        return req
    }
    
    func authenticate(completionHandler: @escaping (AuthenticationResult) -> Void) {
        var req = self.request(path: UAPIPaths.GenerateToken.rawValue)
        req.httpMethod = "POST"
        req.setValue(self.credential.headerValue(), forHTTPHeaderField: "Authorization")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: req)
        
        
//        let task = session.dataTask(with: req) {
//            (data, response, error) -> Void in
//            if let httpResponse = response as? HTTPURLResponse {
//                if let contentType = httpResponse.allHeaderFields["Content-Type"] as? String, contentType != "application/json;charset=UTF-8" {
//                    print("Got the wrong content type \(contentType)")
//                }
//            }
//            
//            if let jsonData = data {
////                let jsonString: String = String(data: jsonData, encoding: .utf8)!
////                NSLog(jsonString)
//                
//                do {
//                    let jsonObject: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                    
//                    guard let jsonDictionary = jsonObject as? [String:AnyObject] else {
//                        return completionHandler(.Failure(UapiError.InvalidJSONData))
//                    }
//                    
//                    if let token = Token.fromJSONObject(json: jsonDictionary) {
//                        completionHandler(.Success(token))
//                    } else {
//                        completionHandler(.Failure(UapiError.InvalidJSONData))
//                    }
//                }
//                catch let error {
//                    completionHandler(.Failure(error))
//                }
//            } else if let requestError = error {
//                print("Error fetching devices \(requestError)")
//            }
//            else {
//                print("Unexpected error with the request")
//            }
//        }
        
        task.resume()
    }
    
}

extension UAPI: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        print("got challenge")
    }
}
