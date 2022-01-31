//
//  LoginViewWebVkController.swift
//  UI_app
//
//  Created by Вячеслав on 22.09.2021.
//

import UIKit
import WebKit
import Alamofire
import Firebase



final class LoginViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationAPI()
        
    }
    
    
    
    func  authorizationAPI() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7958058"), //идентификатор
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "friends, photos, wall, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0"),
            URLQueryItem(name: "v", value: "5.68")
//            "262150", friends, wall
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    let baseUrl = "https://api.vk.com/method"
    let token = MySession.shared.token
    let userId = MySession.shared.userId
    let version = "&v=5.81"
    

    
    
    
    func getGroupSearch() {
        let url = "https://api.vk.com/method/groups.search?user_id=" + MySession.shared.userId + "q,type,country_id,count" + "&access_token=" + MySession.shared.token + "&v=5.68"
        AF.request(url).responseJSON{ response in
//            print("Поиск групп:\n", response.value)
            
        }
        
    }
    
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse:
                    WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let authService = Auth.auth()
        
        let id = params["user_id"]
        

        let email = id! + "@gmail.com"
        let password = id!
            
            
            authService.createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
//                    debugPrint("Ошибка FB")
                }
            return
                
            }
        
        

        let token = params["access_token"]
        
        MySession.shared.userId = params["user_id"]!
        MySession.shared.token = params["access_token"]!
        
        
        
        
        print("User ID = \(MySession.shared.userId)")
        print("Token = \(MySession.shared.token)")
        decisionHandler(.cancel)

        
        if token != nil {
            performSegue(withIdentifier: "go", sender: nil)
        }
        
        
        
    
}
}






