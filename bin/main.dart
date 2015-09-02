import 'dart:convert';
import 'dart:io';
import 'dart:async';

File incomingFile;
File outFile;

String delimiter;

Stream<List<int>> inputIntStream;
Stream  StringStream;
List<String> rawStringList = [];
StringBuffer toWriteToFile;
//List<Map<String, String>> finalMap = [];

void main() {
  toWriteToFile = new StringBuffer();
  delimiter = ";";
  // todo expand this to eventually take class spell lists. User will choose.

  getIncomingFilePath();
  readFile(incomingFile);
  StringStream
    .transform(new LineSplitter())
    .listen((String line) {
      writeToFile(line.split(delimiter));
    });

  stdout.write("Enter a name for the new file: ");
  String outFile = stdin.readLineSync();
  outFile += ".txt";
  print('$toWriteToFile');
  print('${toWriteToFile.toString()}');
  var myFile = new File('C:/Users/HAQ/Google Drive/DnD/${outFile}');
  myFile.writeAsString(toWriteToFile.toString())
  .then((_) => stdout.writeln("\n$outFile successfully created!") );


  //writeToFile()
//
//  // Order of data.
//  String name;
//  String sizeAndType;
//  String alignment;
//  String armorClass;
//  String hitPoints;
//  String hitDice;
//  String speedType1;
//  String speedType2;
//  String speedType3;
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
//  // Empty entry! // Can't find anything that uses this? They're all blank!
//  List<String> actions; // eg Club. Melee Weapon Attack: +2 to hit, reach 5 ft., one target.<br>Hit: 2 (1d4) bludgeoning damage.
//  List<String> legendaryActions;
//  List<String> features;

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
      //readFile(incomingFile);
      return "continue";
    } catch(e) {
      stdout.writeln("Error: file not found or path not valid.\nTry new file? (y/n) : ");
      String tryAgainAnswer = stdin.readLineSync();
      if (tryAgainAnswer == 'y') {
        done = false;
      }
      else {
        done = true;
        return "quit";
      }
    } // end on StateError
  } // end while(!done)
  return "done";
} // end getIncomingFilePath()

void readFile(File file) {
  inputIntStream = file.openRead();
  print("InputIntStream: ${inputIntStream.toString()}");
  StringStream = inputIntStream.transform(UTF8.decoder);
  print('StringStream is:\n${StringStream}');
//    .transform(new LineSplitter());
//    .listen((String line) {
//    parseCVS(line);
//  });
}

//void parseCVS(String cvsString) {
//  List<String> singleEntry = [];
//
//  singleEntry = cvsString.split(delimiter);
//  writeToFile(singleEntry);
//}

void writeToFile(List<String> li) {
  print("List to be written to file: $li");

  toWriteToFile.writeln("""
    {
      "name": "${li[0]}",
      "sizeAndType": "${li[1]}",
      "alignment": "${li[2]}",
      "armorClass": "${li[3]}",
      "hitPoints": "${li[4]}",
      "hitDice": "${li[5]}",
      "speeds": "${li[6]}",
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
//  if (i != (li.length - 1)) {
//    toWriteToFile.write(",\n");
//  }

//  print(li.length);
  //print(li.toString());
//  int idx = -1;
//  for (int i = 0; i < li.length; i++ ) {
//
//    toWriteToFile.write("""
//    {
//      "name": "${li[++idx]}",
//      "sizeAndType": "${li[++idx]}",
//      "alignment": "${li[++idx]}",
//      "armorClass": "${li[++idx]}",
//      "hitPoints": "${li[++idx]}",
//      "hitDice": "${li[++idx]}",
//      "speeds": "${li[++idx]}", // Should this just be a string?
//      "strength": "${li[++idx]}",
//      "dexterity": "${li[++idx]}",
//      "constitution": "${li[++idx]}",
//      "intelligence": "${li[++idx]}",
//      "wisdom": "${li[++idx]}",
//      "charisma": "${li[++idx]}",
//      "savingThrows": "${li[++idx]}",
//      "skills" : "${li[++idx]}",
//      "damageResistance" : "${li[++idx]}",
//      "damageImmunity" : "${li[++idx]}",
//      "conditionImmunity" : "${li[++idx]}",
//      "senses" : "${li[++idx]}",
//      "languages" : "${li[++idx]}",
//      "challengeRating" : "${li[++idx]}",
//      "experience" : "${li[++idx]}",
//      "empty" : "${li[++idx]}",
//      "actions" : "${li[++idx]}",
//      "legendaryAction" : "${li[++idx]}",
//      "features" : "${li[++idx]}"
//    }
//    """);
//      if (i != (li.length - 1)) {
//        toWriteToFile.write(",\n");
//      }
//  }

//  stdout.writeln("Enter a name for the new file: ");
//  String outFile = stdin.readLineSync();
//  outFile += ".txt";
//  new File('C:/Users/HAQ/Google Drive/DnD/${outFile}').writeAsString(toWriteToFile.toString())
//.then((_) => stdout.writeln("$outFile successfully created!") );

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