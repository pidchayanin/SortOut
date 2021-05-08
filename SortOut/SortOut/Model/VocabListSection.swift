//
//  VocabListSection.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 8/5/2564 BE.
//

struct VocabListSection<SectionItem : Hashable, RowItem> {

    var sectionItem : SectionItem
    var rows : [RowItem]

    static func group(rows : [RowItem], by criteria : (RowItem) -> SectionItem) -> [VocabListSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rows, by: criteria)
        return groups.map(VocabListSection.init(sectionItem:rows:))
    }

}
