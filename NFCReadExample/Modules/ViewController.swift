//
//  ViewController.swift
//  NFCReadExample
//
//  Created by Furkan Beyhan on 6.04.2022.
//

import UIKit
import CoreNFC

class ViewController: UIViewController {

    // Reference the NFC session
    private var nfcSession: NFCNDEFReaderSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginScanning()
    }
    
    func beginScanning() {
        // Create the NFC Reader Session when the app starts
        self.nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)

        // A custom description that helps users understand how they can use NFC reader mode in your app.
        self.nfcSession.alertMessage = "You can hold you NFC-tag to the back-top of your iPhone"

        // Begin scanning
        self.nfcSession.begin()
    }


}


extension ViewController : NFCNDEFReaderSessionDelegate {
    
    // Called when the reader-session expired, you invalidated the dialog or accessed an invalidated session
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Error reading NFC: \(error.localizedDescription)")
    }
    
    // Called when a new set of NDEF messages is found
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("New NFC Tag detected:")
        for message in messages {
            for record in message.records {
                print("Type name format: \(record.typeNameFormat)")
                print("Payload: \(record.payload)")
                print("Type: \(record.type)")
                print("Identifier: \(record.identifier)")
            }
        }
    }
}
