////
////  ExpandableTableView.swift
////  Hotel Booking
////
////  Created by Maxim Startsev on 01.09.2023.
////
//
//import UIKit
//
//class ExpandableTableView: UITableViewController {
//    
//    var sections = [
//        Section(courseName: "Первый турист",
//                lessons: ["Имя",
//                          "Фамилия"],
//                expanded: false),
//        Section(courseName: "Второй турист",
//                lessons: ["Имя",
//                          "Фамилия"],
//                expanded: false),
//        Section(courseName: "Третий турист",
//                lessons: ["Имя",
//                          "Фамилия"],
//                expanded: false),
//    ]
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        sections.count
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sections[section].lessons.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputTableViewCell.identifier, for: indexPath) as? InputTableViewCell else {
//            return UITableViewCell()
//        }
//        
//        cell.setCellData(text: sections[indexPath.section].lessons[indexPath.row])
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if sections[indexPath.section].expanded {
//            return 100
//        }
//        return 0
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        5
//    }
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = ExpandableHeaderView()
//        header.setup(title: sections[section].courseName, section: section, delegate: self)
//        return header
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        50
//    }
//    
//}
//
//extension ExpandableTableView: ExpandableHeaderViewDelegate {
//    func toggleSection(header: ExpandableHeaderView, section: Int) {
//        sections[section].expanded = !sections[section].expanded
//        
//        tableView.beginUpdates()
//        for row in 0..<sections[section].lessons.count {
//            tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
//        }
//        tableView.endUpdates()
//    }
//}
