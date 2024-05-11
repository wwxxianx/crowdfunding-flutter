enum AgeGroup {
  baby,
  child,
  youngAdult,
  midAndAgedAdult,
}

extension AgeGroupExtension on AgeGroup {
  String getAgeText() {
    switch (this) {
      case AgeGroup.baby:
        return "0-2";
      case AgeGroup.child:
        return "3-16";
      case AgeGroup.youngAdult:
        return "17-30";
      case AgeGroup.midAndAgedAdult:
        return "31+";
    }
  }

  String getAgeTitle() {
    switch (this) {
      case AgeGroup.baby:
        return "Baby";
      case AgeGroup.child:
        return "Child";
      case AgeGroup.youngAdult:
        return "Young adult";
      case AgeGroup.midAndAgedAdult:
        return "Mid/old-aged adult";
    }
  }
}