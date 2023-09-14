//
//  ToDoTable.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/08.
//

import Foundation
import RealmSwift

class ToDoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId //Primary Key
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    //2. To Many Relationship(일대다) 왜래키 단방향이다.
    @Persisted var detail: List<DetailTable>
    
    //To One Relationship(일대일): EmbeddedObject(무조건 옵셔널!), 별도의 테이블이 생성되는 형태는 아님.
    @Persisted var memo: Memo?
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        
        self.title = title
        self.favorite = favorite
        
    }
}

//To Many Relationship 일대다
class DetailTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId //Primary Key
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    //역관계(양파가 어느폴더에 있는지 알고싶을 때)
    //Inverse Relationship Property (LinkingObjects)
    //originProperty: "detail" = ToDoTable안에 @Persisted var detail: List<DetailTable> 이거 이름 말하는 것! 39회차
    //컬럼이 늘어나진않음 그냥 엮기만한거라 (리스트가 있을 때 사용가능한 것)
    @Persisted(originProperty: "detail") var mainToDo: LinkingObjects<ToDoTable>
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        
        self.detail = detail
        self.deadline = deadline
        
    }
}

//To One Relationship (EmbeddedObject: 특정 컬럼에 들어가는 상태)
class Memo: EmbeddedObject { //장보기에 메모하나 넣을 수 있게(하나의 컬럼 단위)
    @Persisted var content: String //내용
    @Persisted var date: Date //메모를 작성한 날짜
}

















