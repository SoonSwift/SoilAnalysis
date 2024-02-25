//
//  SoilManager.swift
//  SoilAnalysis
//
//  Created by Marcin Dytko on 18/01/2024.
//

import Foundation
import OSLog

let logger = Logger()

protocol SoilManagerPrototype {
    func saveToJSONFile()
    func loadFromJSONFile()
}

class SoilManager {
    var soilTests: [SoilTestsModel] = []

    // Funkcja zapisująca do pliku JSON
    func saveToJSONFile() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(soilTests)
            
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("soilTests.json")
                try data.write(to: fileURL)
                print("Zapisano dane do pliku: \(fileURL)")
            }
        } catch {
            print("Błąd podczas zapisywania danych: \(error.localizedDescription)")
        }
    }

    // Funkcja wczytująca z pliku JSON
    func loadFromJSONFile() {
        do {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("soilTests.json")
                let data = try Data(contentsOf: fileURL)
                
                let decoder = JSONDecoder()
                soilTests = try decoder.decode([SoilTestsModel].self, from: data)
                
                print("Wczytano dane z pliku: \(fileURL)")
            }
        } catch {
            print("Błąd podczas wczytywania danych: \(error.localizedDescription)")
        }
    }
}
