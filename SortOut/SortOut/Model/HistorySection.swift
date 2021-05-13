//
//  HistorySection.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 12/5/2564 BE.
//

struct HistorySection<SectionItem : Hashable, RowItem> {

    var sectionItem : SectionItem
    var rows : [RowItem]

    static func group(rows : [RowItem], by criteria : (RowItem) -> SectionItem) -> [HistorySection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rows, by: criteria)
        return groups.map(HistorySection.init(sectionItem:rows:))
    }

}
