//
//  ViewModel.swift
//  MorseDecoder
//
//  Created by Anton Kolesnikov on 22.02.2023.
//

import Foundation
import RxSwift

final class ViewModel {
    //MARK: - Private properties
    private var elementsCollection = ["a", "B", "C"]
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Subjects
    let inSubj = PublishSubject<Void>()
    let outSubj = PublishSubject<String>()
    
    //MARK: - Init
    init() {
        inSubj
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    let stringToOut = self.elementsCollection.randomElement() ?? ""
                    self.outSubj.onNext(stringToOut)
                }
            )
            .disposed(by: self.disposeBag)
    }
}
