//
//  LanguageViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet var languageTableView: UITableView!
    
    var language: String = ""
    let languageList = ["한국어", "영어", "중국어 간체", "중국어 번체", "스페인어", "프랑스어", "베트남어", "태국어", "인도네시아어"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }
    
    func languageChanged() -> String {
        switch language {
        case "ko": return "한국어"
        case "en": return "영어"
        case "zh-CN": return "중국어 간체"
        case "zh-TW": return "중국어 번체"
        case "es": return "스페인어"
        case "fr": return "프랑스어"
        case "vi": return "베트남어"
        case "th": return "태국어"
        case "id": return "인도네시아어"
        default: return "error"
        }
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell")!
        
        cell.textLabel?.text = languageList[indexPath.row]
        
        cell.textLabel?.font = .boldSystemFont(ofSize: 18)
        
        if languageList[indexPath.row] == languageChanged() {
            cell.textLabel?.textColor = .systemGreen
        }
        
        return cell
    }
}

extension LanguageViewController {
    func configureTableView() {
        languageTableView.dataSource = self
        languageTableView.delegate = self
        
        languageTableView.rowHeight = 80
    }
}
