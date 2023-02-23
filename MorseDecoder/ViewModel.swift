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
    private var morseBuffer = ""
    
    //MARK: - DisposeBag
    private let disposeBag = DisposeBag()
    
    //MARK: - Subjects
    let inDot = PublishSubject<Void>()
    let inDash = PublishSubject<Void>()
    let inSpace = PublishSubject<Void>()
    let reset = PublishSubject<Void>()
    let outDecodedText = PublishSubject<String>()

    //MARK: - Init
    init() {
        inDot
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    self.morseBuffer += "."
                    let outputText = self.decodeStringToMorse(self.morseBuffer)
                    self.outDecodedText.onNext(outputText)
                }
            )
            .disposed(by: self.disposeBag)
        
        inDash
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    self.morseBuffer += "-"
                    let outputText = self.decodeStringToMorse(self.morseBuffer)
                    self.outDecodedText.onNext(outputText)
                }
            )
            .disposed(by: self.disposeBag)
        
        inSpace
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    self.morseBuffer += "_"
                }
            )
            .disposed(by: self.disposeBag)
        
        reset
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    self.morseBuffer = ""
                    self.outDecodedText.onNext("")
                }
            )
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - Morse Decoder
    func decodeStringToMorse(_ input: String) -> String {
        let symbolsArray = input.components(separatedBy: "_")
        var returnString = ""
        
        do {
            try symbolsArray.forEach{ returnString += try convertLetterToMorse($0) }
        } catch {
            returnString = "ERROR"
        }
        
        return returnString
    }
    
    func convertLetterToMorse(_ input: String) throws -> String {
        var returnChar = ""
        
        if let key = MorseVariables.morseDictionary.first(where: { $0.value == input })?.key {
            returnChar = key
        } else {
            throw MorseErrors.wrongInput
        }
        
        return returnChar
    }
    
}
