//
//  ViewController.swift
//  TableViewRxSwift-practice
//
//  Created by 大西玲音 on 2021/05/18.
//

import UIKit
import RxSwift
import RxCocoa

struct Item {
    let name: String
    let color: UIColor
}

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let items: Observable<[Item]> = .just([Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
                                                   Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
                                                   Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
                                                   Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
                                                   Item(name: "AAA", color: .red),
                                                   Item(name: "BBB", color: .blue),
    ])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        tableView.register(CustomTableViewCell.nib,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    private func setupBindings() {
        let dataSource = MyDataSource()
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}

final class MyDataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {
    typealias Element = [Item]
    var items = [Item]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                 for: indexPath) as! CustomTableViewCell
        let item = items[indexPath.row]
        cell.configure(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Item]>) {
        Binder(self) { dataSource, element in
            guard let items = element.element else { return }
            dataSource.items = items
            tableView.reloadData()
        }
        .onNext(observedEvent)
    }
}

