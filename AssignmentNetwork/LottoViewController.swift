//
//  LottoViewController.swift
//  AssignmentNetwork
//
//  Created by Jaehui Yu on 1/16/24.
//

import UIKit
import Alamofire



class LottoViewController: UIViewController {
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var numberImageView: [UIImageView]!
    @IBOutlet var bonusImageView: UIImageView!
    
    var lottoPickerView = UIPickerView()
    
    var round = 1102
    var roundList: [Int] = []
    var numberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTextField.tintColor = .clear
        dateTextField.textAlignment = .center
        dateTextField.inputView = lottoPickerView
        
        textLabel.font = .boldSystemFont(ofSize: 16)
        
        lottoPickerView.dataSource = self
        lottoPickerView.delegate = self
        
        callRequest(number: round)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF
            .request(url)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    self.dateTextField.text = "\(success.drwNo) 회차"
                    self.textLabel.text = "\(success.drwNo)회차의 당첨 번호는!"
                    self.roundList = Array(1...success.drwNo).reversed()
                    self.numberList = [success.drwtNo1, success.drwtNo2, success.drwtNo3, success.drwtNo4, success.drwtNo5, success.drwtNo6]
                    for i in 0..<self.numberImageView.count {
                        self.numberImageView[i].image = UIImage(systemName: "\(self.numberList[i]).circle.fill")
                    }
                    self.bonusImageView.image = UIImage(systemName: "\(success.bnusNo).circle.fill")
                case .failure(let failure):
                    print(failure)
                }
            }
    }

}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        roundList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        round = roundList[row]
        callRequest(number: round)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roundList[row])회차"
    }
    
}
