//
//  PapagoViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit
import Alamofire

class PapagoViewController: UIViewController {
    
    @IBOutlet var sourceButton: UIButton!
    @IBOutlet var targetButton: UIButton!
    @IBOutlet var changeButton: UIButton!
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var translateButton: UIButton!
    
    var sourceLang: String = "ko"
    var targetLang: String = "en"
    
    var languageDic: [String: String] = ["ko" : "한국어",
                                         "en" : "영어",
                                         "zh-CN" : "중국어 간체",
                                         "zh-TW" : "중국어 번체",
                                         "es" : "스페인어",
                                         "fr" : "프랑스어",
                                         "vi" : "베트남어",
                                         "th" : "태국어",
                                         "id" : "인도네시아어"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceButton.addTarget(self, action: #selector(sourceButtonClicked), for: .touchUpInside)
        targetButton.addTarget(self, action: #selector(targetButtonClicked), for: .touchUpInside)
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
        
        
        for (key, value) in languageDic {
            if key == sourceLang {
                sourceButton.setTitle(value, for: .normal)
            }
            
            if key == targetLang {
                targetButton.setTitle(value, for: .normal)
            }
        }
        
        sourceButton.configureButton()
        targetButton.configureButton()
        changeButton.configureChangeButton()
        sourceTextView.configureTextView()
        targetLabel.numberOfLines = 0
        translateButton.configureTranslateButton()

    }

    @objc func sourceButtonClicked() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        vc.language = sourceLang
        present(vc, animated: true)
    }
    
    @objc func targetButtonClicked() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        vc.language = targetLang
        present(vc, animated: true)
    }
    
    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let parameters: Parameters = ["text" : sourceTextView.text!,
                                      "source" : sourceLang,
                                      "target" : targetLang]
        let headers: HTTPHeaders = ["X-Naver-Client-Id" : APIKey.clientID,
                                    "X-Naver-Client-Secret" : APIKey.clientSecret]
        AF
            .request(url,
                     method: .post,
                     parameters: parameters,
                     headers: headers)
            .responseDecodable(of: Papago.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    self.targetLabel.text = success.message.result.translatedText
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
}


