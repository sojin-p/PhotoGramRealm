//
//  ToDoViewController.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/08.
//

import UIKit
import RealmSwift
import SnapKit

class ToDoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    let tableView = UITableView()
    
//    var list: Results<ToDoTable>!
    var list: Results<DetailTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let data = ToDoTable(title: "영화보기", favorite: false)
//
//        let memo = Memo()
//        memo.content = "주말에 팝콘 먹으면서 영화 보기"
//        memo.date = Date()
//
//        try! realm.write {
//            realm.add(data)
//            data.memo = memo //이렇게 안에 넣어도 됨
//        }
        
//        let data = ToDoTable(title: "장보기", favorite: true)
//        let detail1 = DetailTable(detail: "양파", deadline: Date())
//        let detail2 = DetailTable(detail: "사과", deadline: Date())
//        let detail3 = DetailTable(detail: "간장", deadline: Date())
//
//        //트렌젝션 안에서 데이타추가후 해도되지만, 이렇게 먼저 추가하고 한번에 추가해도됨
//        data.detail.append(detail1)
//        data.detail.append(detail2)
//        data.detail.append(detail3)
//
//        try! realm.write {
//            realm.add(data)
//        }
        
        print("경로", realm.configuration.fileURL)
        print(realm.objects(ToDoTable.self))
        //print(realm.objects(DetailTable.self)) //디테일테이블 독립적 사용가능
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
//        list = realm.objects(ToDoTable.self)
        list = realm.objects(DetailTable.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        let data = list[indexPath.row]
//        cell.textLabel?.text = "\(row.title): \(row.detail.count)개 \(row.memo?.content ?? "")"
        cell.textLabel?.text = "\(data.detail) in \(data.mainToDo.first?.title ?? "")" //배열로 가져와지는데, 어차피 하나 있을거라 first로!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let data = list[indexPath.row]
//
//        try! realm.write {
//            realm.delete(data.detail) //얘를 먼저 지워야 함!!!! 안 그러면 영원히 못 지움..
//            realm.delete(data)
//        }
//
//        tableView.reloadData()
    }
    
    
    func createDetail() {
        print(realm.objects(ToDoTable.self))
//        createTodo()
        
        //1. 투두테이블을 먼저찾고, 타이틀이 장보기인 애를 필터링해라(타이틀이 PK가 아니라서 여러개면 여러개가 올 것임)
        let main = realm.objects(ToDoTable.self).where {
            $0.title == "장보기"
        }.first! //배열로 가져올 수도 있어서 그 중 첫번째 가져와!
          
        for i in 1...10 {
            let detailTodo = DetailTable(detail: "장보기 세부 할일 \(i)", deadline: Date() )
            try! realm.write {
//                realm.add(detailTodo)
                //3. 디테일을 추가
                main.detail.append(detailTodo)
            }
        }
        
    }
    
    func createTodo() {
        for i in ["장보기", "영화보기", "리캡하기", "좋아요구현하기", "잠자기"] {
            
            let data = ToDoTable(title: i, favorite: false)
            
            try! realm.write {
                realm.add(data)
            }
 
        }
    }
    
}
