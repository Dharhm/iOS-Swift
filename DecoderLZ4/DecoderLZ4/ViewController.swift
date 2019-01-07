//
//  ViewController.swift
//  DecoderLZ4
//
//  Created by Nicson S on 21/11/18.
//  Copyright © 2018 Nicson S. All rights reserved.
//

import UIKit
import Compression


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var intArray: [Int8] =  [ -16, 1, 1, 39, 0, 19, 11, -30, 7, 10, 29, 14, 0, 0, 0, 0, 96, 9, 6, 0, 1, 2, 0, 17, 14, 6, 0, 2, 2, 0, 18, 14, 7, 0, 65, 0, 0, 0, -51, 6, 0, 0, 2, 0, 0, 43, 0, 16, 2, 9, 0, -1, 13, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 6, 0, 0, 0, 7, 0, 0, 0, 8, 0, 0, 0, 10, 4, 0, 64, 33, -105, 58, 115, 0, 12, 2, 0, 80, 0, 0, 0, 0, 0]
        
        let uintArray = intArray.map { UInt8(bitPattern: $0) }
        
        var bytesArr:[UInt8] =  [223, 3, 90, 214, 47, 169, 122, 195, 7, 243, 89, 214, 47, 186, 8, 0, 4, 19, 219, 24, 0, 0, 8, 0, 83, 226, 89, 214, 47, 235, 8, 0, 87, 252, 122, 195, 7, 210, 8, 0, 147, 13, 123, 195, 7, 193, 89, 214, 47, 30, 8, 0, 19, 46, 8, 0, 23, 63, 8, 0, 91, 176, 89, 214, 47, 79, 8, 0, 151, 96, 123, 195, 7, 160, 89, 214, 47, 113, 8, 0, 83, 143, 89, 214, 47, 130, 16, 0, 23, 146, 8, 0, 83, 176, 89, 214, 47, 163, 64, 0, 0, 8, 0, 0, 112, 0, 19, 180, 96, 0, 19, 196, 8, 0, 19, 213, 8, 0, 31, 230, 8, 0, 0, 0, 64, 0, 19, 246, 80, 0, 34, 7, 124, 120, 0, 0, 8, 0, 87, 143, 89, 214, 47, 24, 8, 0, 19, 126, 16, 0, 211, 110, 89, 214, 47, 40, 124] // uintArray// + [62,76,34,24]
      
        var encodedData = Data.init(bytes:bytesArr)
        
        let decodedCapacity = 205
        
        let decodedDestinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: decodedCapacity)
        
        let decodedData = encodedData.withUnsafeBytes {
            (encodedSourceBuffer: UnsafePointer<UInt8>) -> Data? in
            
            let decodedCharCount = compression_decode_buffer(decodedDestinationBuffer,
                                                             decodedCapacity,
                                                             encodedSourceBuffer,
                                                             encodedData.count,
                                                             nil,
                                                             COMPRESSION_LZ4_RAW)
            
            if decodedCharCount == 0 {
                fatalError("Decoding failed.")
            }
            
            
            print("Before: \(encodedSourceBuffer) | After: \(decodedCharCount)")
            
            return Data(bytesNoCopy: decodedDestinationBuffer, count: decodedCharCount, deallocator: .free)
            
        }
        
    }


}

