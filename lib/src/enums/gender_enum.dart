enum GenderEnum { male, female, others, unavailable }

class GenderType {
  static const Map<GenderEnum, String> toStringData = {
    GenderEnum.male: 'Male',
    GenderEnum.female: 'Female',
    GenderEnum.others: 'Others',
    GenderEnum.unavailable: 'Unavailable',
  };
  static const Map<String, GenderEnum> fromString = {
    'Male': GenderEnum.male,
    'Female': GenderEnum.female,
    'Others': GenderEnum.others,
    'Unavailable': GenderEnum.unavailable,
  };
  static const Map<GenderEnum, String> toDBStringData = {
    GenderEnum.male: 'MALE',
    GenderEnum.female: 'FEMALE',
    GenderEnum.others: 'OTHERS',
    GenderEnum.unavailable: 'UNAVAILABLE',
  };
  static const Map<String, GenderEnum> fromDBString = {
    'MALE': GenderEnum.male,
    'FEMALE': GenderEnum.female,
    'OTHERS': GenderEnum.others,
    'UNAVAILABLE': GenderEnum.unavailable,
  };
}
