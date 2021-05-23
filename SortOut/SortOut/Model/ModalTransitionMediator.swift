//
//  ModalTransitionMediator.swift
//  SortOut
//
//  Created by Pathompong Subtechitmanee on 23/5/2564 BE.
//

protocol ModalTransitionListener {
    func popoverDismissed()
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }

    private var listener: ModalTransitionListener?

    private init() {

    }

    func setListener(listener: ModalTransitionListener) {
        self.listener = listener
    }

    func sendPopoverDismissed(modelChanged: Bool) {
        listener?.popoverDismissed()
    }
}
