//
//  main.swift
//  nhcalc
//
//  Created by Khaos Tian on 8/8/21.
//

import Foundation
import Vision

func generateNeuralHash(imagePath: String) {
    let imagePathURL = URL(fileURLWithPath: imagePath)
    let requestHandler = VNImageRequestHandler(url: imagePathURL, options: [:])

    let neuralHashRequest = VN6kBnCOr2mZlSV6yV1dLwB { req, err in
        if let results = req.results {
            for result in results {
                if let observation = result as? VN3XKGTKNBvy6h4RFtpxLyW {
                    let imageHash = observation.imageSignatureHash()
                    
                    do {
                        let imageHData = try imageHash?.encodeHashDescriptorWithBase64Encoding()
                        if let imageHData = imageHData,
                           let value = String(data: imageHData, encoding: .ascii) {
                            print(imageHData.map { String(format: "%02hhx", $0) }.joined())
                            print(value)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    neuralHashRequest.imageSignatureprintType = 3
    neuralHashRequest.imageSignatureHashType = 1

    do {
        try requestHandler.perform([neuralHashRequest])
    } catch {
        print("Error: \(error)")
    }
}

guard CommandLine.arguments.count > 1, let imagePath = CommandLine.arguments.last else {
    print("Missing Image Path")
    exit(1)
}

generateNeuralHash(imagePath: imagePath)
