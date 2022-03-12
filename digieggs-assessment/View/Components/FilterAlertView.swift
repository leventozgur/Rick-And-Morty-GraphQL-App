//
//  FilterAlertView.swift
//  digieggs-assessment
//
//  Created by Levent ÖZGÜR on 11.03.22.
//

import UIKit

protocol IFilterAlertDelegate {
    func filterChanged(changedFilter: String)
}

class FilterAlertView: UIViewController {
    
    private let box: UIView = UIView()
    private let alertTitle: UILabel = UILabel()
    private let line: UIView = UIView()
    private let rowName1: UILabel = UILabel()
    private let rowButton1: UIButton = UIButton()
    private let rowName2: UILabel = UILabel()
    private let rowButton2: UIButton = UIButton()
    
    private var buttonGroup = [UIButton]()
    private var checkedImage: UIImage = UIImage(named: ImageEnum.filterCheckedImage.rawValue)!
    private var uncheckedImage: UIImage = UIImage(named: ImageEnum.filterUncheckedImage.rawValue)!
    
    var filterAlertDelegate: IFilterAlertDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfigurations()
    }
    
    func viewConfigurations() {
        view.addSubview(box)
        box.addSubview(alertTitle)
        box.addSubview(line)
        box.addSubview(rowName1)
        box.addSubview(rowName2)
        box.addSubview(rowButton1)
        box.addSubview(rowButton2)
        
        drawAlertTitle()
        drawBox()
        drawLine()
        drowRowName1()
        drowRowName2()
        drawRowButton1()
        drawRowButton2()
        
        //buttons add to buttonGroup
        buttonGroup.append(rowButton1)
        buttonGroup.append(rowButton2)
        
        //define view background color
        self.view.backgroundColor =  UIColor.black.withAlphaComponent(0.7)
        
        //define buttons first image
        rowButton1.setImage(uncheckedImage, for: .normal)
        rowButton2.setImage(uncheckedImage, for: .normal)
        
        alertTitle.textColor = .black
        alertTitle.font = .boldSystemFont(ofSize: 24)
        alertTitle.text = "Filter"
        
        setFilterFieldsFeatures(label: rowName1, button: rowButton1)
        setFilterFieldsFeatures(label: rowName2, button: rowButton2)
        rowName1.text = "Rick"
        rowName2.text = "Morty"
        
        rowButton1.tag = 0
        rowButton2.tag = 1
        
        box.backgroundColor = .white
        box.layer.cornerRadius = 10
        
        line.backgroundColor = .gray
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        self.box.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
        
    }
    
    func setFilterFieldsFeatures(label: UILabel,  button: UIButton) {
        label.textColor = .black
        label.font.withSize(24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - Snapkit View features
extension FilterAlertView {
    func drawBox() {
        box.snp.makeConstraints { make in
            make.height.equalTo(164)
            make.width.equalTo(327)
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func drawAlertTitle() {
        alertTitle.snp.makeConstraints { make in
            make.top.equalTo(box.snp.top).offset(16)
            make.left.equalTo(box.snp.left).offset(16)
        }
    }
    
    func drawLine() {
        line.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(8)
            make.left.right.equalTo(box)
            make.height.equalTo(0.5)
        }
    }
    
    func drowRowName1() {
        rowName1.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.left.equalTo(line.snp.left).offset(16)
        }
    }
    
    func drawRowButton1() {
        rowButton1.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(18)
            make.right.equalTo(line.snp.right).offset(-16)
        }
    }
    
    func drowRowName2() {
        rowName2.snp.makeConstraints { make in
            make.top.equalTo(rowName1.snp.bottom).offset(16)
            make.left.equalTo(rowName1.snp.left)
        }
    }
    
    func drawRowButton2() {
        rowButton2.snp.makeConstraints { make in
            make.top.equalTo(rowButton1.snp.bottom).offset(20)
            make.right.equalTo(rowButton1.snp.right)
        }
    }
    
}

//MARK: - Button Functions
extension FilterAlertView {
    @objc func buttonAction(sender: UIButton!){
        print(sender.isSelected)
        for button in buttonGroup {
            button.isSelected = false
            button.setImage(uncheckedImage, for: .normal)
        }
        sender.isSelected = true
        sender.setImage(checkedImage, for: .normal)
        
        switch sender.tag {
        case 0:
            filterAlertDelegate?.filterChanged(changedFilter: "Rick")
        case 1:
            filterAlertDelegate?.filterChanged(changedFilter: "Morty")
        default:
            break;
        }
    }
}
