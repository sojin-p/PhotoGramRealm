//
//  DetailViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class DetailViewController: BaseViewController {
    
    var data: DiaryTable?
    
    let realm = try! Realm()
    
    let titleTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let contentTextField: WriteTextField = {
        let view = WriteTextField()
        view.placeholder = "내용을 입력해주세요"
        return view
    }()

    override func configure() {
        super.configure()
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        
        guard let data = data else { return }
        
        titleTextField.text = data.diaryTitle
        contentTextField.text = data.diaryContents
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
    }
    
    @objc func editButtonClicked() {
        
        //Realm Update
        guard let data = data else { return }
        let item = DiaryTable(value: ["_id": data._id, "diaryTitle": titleTextField.text!, "diaryContents": contentTextField.text!])
         
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("") //
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(60)
        }
    }
    
}
