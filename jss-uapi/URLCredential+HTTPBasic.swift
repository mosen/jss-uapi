import Foundation

extension URLCredential {
    func headerValue() -> String {
        let userPasswordString = "\(self.user ?? ""):\(self.password ?? "")"
        let userPasswordData = userPasswordString.data(using: .utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        
        return authString
    }
}
