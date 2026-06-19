import Foundation

class FishStorageManager {
    private static let key = "SavedFishNames"
    
    /// Ambil daftar ikan dari UserDefaults
    static func getFishNames() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    /// Simpan daftar ikan ke UserDefaults
    static func saveFishNames(_ names: [String]) {
        UserDefaults.standard.set(names, forKey: key)
    }
    
    //buat apus, nti pas review bisa diapus y ini
    static func resetFishNames() {
            UserDefaults.standard.set([], forKey: key)
        }
}
