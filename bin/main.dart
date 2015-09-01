import 'dart:convert';
import 'dart:io';
import 'dart:async';

File incomingFile;
File outFile;

String delimiter;

Stream<List<int>> inputIntStream;
List<String> rawStringList = [];

List<Map<String, String>> finalMap = [];

void main() {
  getIncomingFilePath();
  delimiter = ";";
  // todo expand this to eventually take class spell lists. User will choose.


  // Order of data.
  String name;
  String sizeAndType;
  String alignment;
  String armorClass;
  String hitPoints;
  String hitDice;
  String speedType1;
  String speedType2;
  String speedType3;
  List<String> speeds; // This will cover any existing speeds.

  String strength;
  String dexterity;
  String constitution;
  String intelligence;
  String wisdom;
  String charisma;

  List<String> savingThrows;
  List<String> skills;
  List<String> damageResistances;
  List<String> damageImmunities;
  List<String> conditionImmunities;
  List<String> senses; //Darkvision, blindsense, passive perception included here!
  List<String> languages;
  String challengeRating;
  String experience;
  // Empty entry! // Can't find anything that uses this? They're all blank!
  List<String> actions; // eg Club. Melee Weapon Attack: +2 to hit, reach 5 ft., one target.<br>Hit: 2 (1d4) bludgeoning damage.
  List<String> legendaryActions;
  List<String> features;

}

String getIncomingFilePath() {
  String csvPath;
  bool done = false;

  while(!done) {
    stdout.write("Enter absolute or relative path to *.cvs file: ");
    csvPath = stdin.readLineSync();

    try {
      incomingFile = new File(csvPath);
      done = true;
      readFile(incomingFile);
      return "continue";
    } catch(e) {
      stdout.writeln("Error: file not found or path not valid.\nTry new file? (y/n) : ");
      String tryAgainAnswer = stdin.readLineSync().toLowerCase();
      if (tryAgainAnswer == 'y') {
        done = false;
      }
      else {
        done = true;
        return "quit";
      }
    } // end on StateError
  } // end while(!done)

} // end getIncomingFilePath()

void readFile(File file) {
  inputIntStream = file.openRead();
  inputIntStream
    .transform(UTF8.decoder)
    .transform(new LineSplitter())
    .listen((String line) {
    parseCVS(line);
  });

}

void parseCVS(String cvsString) {
  List<String> singleEntry = [];

  singleEntry = cvsString.split(delimiter);
  writeToFile(singleEntry);
}

void writeToFile(List<String> li) {
  StringBuffer toWriteToFile = new StringBuffer();

  print(li.length);
  print(li.toString());
//  cvsMap["name"] = li[0];
//  cvsMap["sizeAndType"] = li[1];
//  cvsMap["alignment"] = li[2];
//  cvsMap["armorClass"] = li[3];
//  cvsMap["hitPoints"] = li[4];
//  cvsMap["hitDice"] = li[5];
//  cvsMap["speeds"] = li[6]; // Should this just be a string?
//  cvsMap["strength"] = li[7];
//  cvsMap["dexterity"] = li[8];
//  cvsMap["constitution"] = li[9];
//  cvsMap["intelligence"] = li[10];
//  cvsMap["wisdom"] = li[11];
//  cvsMap["charisma"] = li[12];
//  cvsMap["savingThrows"] =li[13];
//  cvsMap["skills"] = li[14];
//  cvsMap["damageResistance"] = li[15];
//  cvsMap["damageImmunity"] = li[16];
//  cvsMap["conditionImmunity"] = li[17];
//  cvsMap["senses"] = li[18];
//  cvsMap["languages"] = li[19];
//  cvsMap["challengeRating"] = li[20];
//  cvsMap["experience"] = li[21];
//  cvsMap["empty"] = li[22];
//  cvsMap["actions"] = li[23];
//  cvsMap["legendaryAction"] = li[24];
//  cvsMap["features"] = li[25];

//  cvsMap["name"] = li[0];
//  cvsMap["sizeAndType"] = li[1];
//  cvsMap["alignment"] = li[2];
//  cvsMap["armorClass"] = li[3];
//  cvsMap["hitPoints"] = li[4];
//  cvsMap["hitDice"] = li[5];
//
//  cvsMap["speeds"] = new List.from(li[6].split(","));
//  cvsMap["speeds"] = li[6]; // Should this just be a string?
//  cvsMap["strength"] = li[7];
//  cvsMap["dexterity"] = li[8];
//  cvsMap["constitution"] = li[9];
//  cvsMap["intelligence"] = li[10];
//  cvsMap["wisdom"] = li[11];
//  cvsMap["charisma"] = li[12];
//  cvsMap["savingThrows"] = new List.from(li[13].split(","));
//  cvsMap["skills"] = new List.from(li[14].split(","));
//  cvsMap["damageResistance"] = new List.from(li[15].split(","));
//  cvsMap["damageImmunity"] = new List.from(li[16].split(","));
//  cvsMap["conditionImmunity"] = new List.from(li[17].split(","));
//  cvsMap["senses"] = new List.from(li[18].split(","));
//  cvsMap["languages"] = new List.from(li[19].split(","));
//  cvsMap["challengeRating"] = li[20];
//  cvsMap["experience"] = li[21];
//  cvsMap["empty"] = li[22];
//  cvsMap["actions"] = new List.from(li[23].split(","));
//  cvsMap["legendaryAction"] = new List.from(li[24].split(","));
//  cvsMap["features"] = new List.from(li[25].split(","));

  toWriteToFile.write("""
  {
    "name": "${li[0]}",
    "sizeAndType": "${li[1]}",
    "alignment": "${li[2]}",
    "armorClass": "${li[3]}",
    "hitPoints": "${li[4]}",
    "hitDice": "${li[5]}",
    "speeds": "${li[6]}", // Should this just be a string?
    "strength": "${li[7]}",
    "dexterity": "${li[8]}",
    "constitution": "${li[9]}",
    "intelligence": "${li[10]}",
    "wisdom": "${li[11]}",
    "charisma": "${li[12]}",
    "savingThrows": "${li[13]}",
    "skills" : "${li[14]}",
    "damageResistance" : "${li[15]}",
    "damageImmunity" : "${li[16]}",
    "conditionImmunity" : "${li[17]}",
    "senses" : "${li[18]}",
    "languages" : "${li[19]}",
    "challengeRating" : "${li[20]}",
    "experience" : "${li[21]}",
    "empty" : "${li[22]}",
    "actions" : "${li[23]}",
    "legendaryAction" : "${li[24]}",
    "features" : "${li[25]}"
  }
  """);

  stdout.writeln("Enter a name for the new file: ");
  String outFile = stdin.readLineSync();

  new File('C:/Users/HAQ/Google Drive/DnD/${outFile}').writeAsString(toWriteToFile.toString())
      .then((_) => stdout.writeln("$outFile successfully created!") );

}




class Monster {
//  String name;
//  String sizeAndType;
//  String alignment;
//  String armorClass;
//  String hitPoints;
//  String hitDice;
////  String speedType1;
////  String speedType2;
////  String speedType3;
//  List<String> speeds; // This will cover any existing speeds.
//
//  String strength;
//  String dexterity;
//  String constitution;
//  String intelligence;
//  String wisdom;
//  String charisma;
//
//  List<String> savingThrows;
//  List<String> skills;
//  List<String> damageResistances;
//  List<String> damageImmunities;
//  List<String> conditionImmunities;
//  List<String> senses; //Darkvision, blindsense, passive perception included here!
//  List<String> languages;
//  String challengeRating;
//  String experience;
//  String emptyString; // Empty entry! // Can't find anything that uses this? They're all blank!
//  List<String> actions; // eg Club. Melee Weapon Attack: +2 to hit, reach 5 ft., one target.<br>Hit: 2 (1d4) bludgeoning damage.
//  List<String> legendaryActions;
//  List<String> features;

  String name;
  String sizeAndType;
  String alignment;
  int armorClass;
  int hitPoints;
  String hitDice;
//  String speedType1;
//  String speedType2;
//  String speedType3;
  List<String> speeds; // This will cover any existing speeds.

  String strength;
  String dexterity;
  String constitution;
  String intelligence;
  String wisdom;
  String charisma;

  List<String> savingThrows;
  List<String> skills;
  List<String> damageResistances;
  List<String> damageImmunities;
  List<String> conditionImmunities;
  List<String> senses; //Darkvision, blindsense, passive perception included here!
  List<String> languages;
  String challengeRating;
  String experience;
  String emptyString; // Empty entry! // Can't find anything that uses this? They're all blank!
  List<String> actions; // eg Club. Melee Weapon Attack: +2 to hit, reach 5 ft., one target.<br>Hit: 2 (1d4) bludgeoning damage.
  List<String> legendaryActions;
  List<String> features;


  Monster(this.name, this.sizeAndType, this.alignment, this.armorClass, this.hitPoints, this.hitDice, this.speeds, this.strength, this.dexterity, this.constitution, this.intelligence, this.wisdom, this.charisma, this.savingThrows, this.skills, this.damageResistances, this.damageImmunities, this.conditionImmunities, this.senses, this.languages, this.challengeRating, this.experience, this.emptyString, this.actions, this.legendaryActions, this.features);

}