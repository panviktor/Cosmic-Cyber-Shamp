import SpriteKit

class AccountInfo {
    private struct Data{
        private let documentDir:NSString
        let fullPath:String
        let plist:NSMutableDictionary
        
        init(){
            documentDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
            fullPath = documentDir.appendingPathComponent("userinfo.plist")
            guard let plist = NSMutableDictionary(contentsOfFile: fullPath) else {
                fatalError("plist is nil - Check AccountInfo.swift")
            }
            self.plist = plist
        }
    }
    
    private var level:Int
    private var currentToonIndex:Int
    private var characters:[Toon]
    private var gold:Int
    private var experience:CGFloat
    private var highscore:Int
    private let data:Data
    
    init(){
        level = 0
        currentToonIndex = 0
        gold = 0
        experience = 0.0
        characters = [Toon(char: .Jupiter_2), Toon(char: .Normandy), Toon(char: .Thunderbolt)]
        highscore = 0
        data = Data()
    }
    
    func load() -> Bool{
        // Update Root
        level = data.plist.value(forKey: "Level") as! Int
        gold = data.plist.value(forKey: "Coin") as! Int
        experience = data.plist.value(forKey: "Experience") as! CGFloat
        highscore = data.plist.value(forKey: "Highscore") as! Int
        currentToonIndex = data.plist.value(forKey: "CurrentToon") as! Int
        
        let toondDict = data.plist.value(forKey: "Toons") as! NSDictionary
        characters[0].load(infoDict: toondDict.value(forKey: "Jupiter_2") as! NSDictionary)
        characters[1].load(infoDict: toondDict.value(forKey: "Normandy") as! NSDictionary)
        characters[2].load(infoDict: toondDict.value(forKey: "Thunderbolt") as! NSDictionary)
        
        return true
    }
    
    func getGoldBalance() -> Int{
        return self.gold
    }
    
    func getCurrentToon() -> Toon{
        return characters[currentToonIndex]
    }
    
    func getCurrentToonIndex() -> Int{
        return currentToonIndex
    }
    
    func selectToonIndex(index: Int){
        currentToonIndex = index
        data.plist.setValue(index, forKey: "CurrentToon")
        if !data.plist.write(toFile: data.fullPath, atomically: false){
            print("Saving Error - AccountInfo.selectToonIndex")
        }
    }
    
    func upgradeBullet() -> (Bool, String) {
        let level = characters[currentToonIndex].getBulletLevel()
        let cost = (level + 1) * 100
        
        if gold < cost {
            return (false, "Not enough gold")
        }
        
        gold -= cost
        data.plist.setValue(gold, forKey: "Coin")
        
        if !data.plist.write(toFile: data.fullPath, atomically: false) {
            return (false, "Saving error: AccountInfo.upgradeBullet[1]")
        }
        
        let toonDict = data.plist.value(forKey: "Toons") as! NSDictionary
        guard let currToonDict = toonDict.value(forKey: characters[currentToonIndex].getCharacter().rawValue) as? NSMutableDictionary else{
            return (false, "Error: AccountInfo.upgradeBullet[2]")
        }
        
        if !characters[currentToonIndex].advanceBulletLevel(){
            return (false, "Max Level Achieved")
        }
        
        currToonDict.setValue(characters[currentToonIndex].getBulletLevel(), forKey: "BulletLevel")
        
        if !data.plist.write(toFile: data.fullPath, atomically: false){
            return (false, "Saving Error")
        }
        
        
        return (true, "Success")
    }
    
    func getToonDescriptionByIndex(index: Int) -> [String]{
        return characters[index].getToonDescription()
    }
    
    func getNameOfToonByIndex(index: Int) -> String{
        return characters[index].getToonName()
    }
    
    func getTitleOfToonByIndex(index: Int) -> String{
        return characters[index].getToonTitle()
    }
    
    func getBulletLevelOfToonByIndex(index: Int) -> Int{
        return characters[index].getBulletLevel()
    }
    
    func prepareToChangeScene(){
        characters.removeAll()
    }
}
