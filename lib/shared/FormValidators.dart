class FormValidators {
  static String date(String value) {
    if (value.isEmpty) {
      return 'Please enter date.';
    }
    return null;
  }

  static String start(String value) {
    if (value.isEmpty) {
      return 'Please enter start time.';
    }
    return null;
  }

  static String end(String value) {
    if (value.isEmpty) {
      return 'Please enter end time.';
    }
    return null;
  }

  static String duration(String value) {
    if (value.isEmpty) {
      return 'Please enter duration.';
    }
    return null;
  }

  static String name(String value) {
    if (value.isEmpty) {
      return 'Please enter location name.';
    }
    return null;
  }

  static String location(String value) {
    if (value.isEmpty) {
      return 'Please enter location.';
    }
    return null;
  }

  static String visibility(String value) {
    if (value.isEmpty) {
      return 'Please enter visibility.';
    }
    return null;
  }

  static String airTemperature(String value) {
    if (value.isEmpty) {
      return 'Please enter air temperature.';
    }
    return null;
  }

  static String surfaceTemperature(String value) {
    if (value.isEmpty) {
      return 'Please enter surface temperature.';
    }
    return null;
  }

  static String bottomTemperature(String value) {
    if (value.isEmpty) {
      return 'Please enter bottom temperature.';
    }
    return null;
  }

  static String weight(String value) {
    if (value.isEmpty) {
      return 'Please enter weight.';
    }
    return null;
  }

  static String startingAir(String value) {
    if (value.isEmpty) {
      return 'Please enter starting air.';
    }
    return null;
  }

  static String endingAir(String value) {
    if (value.isEmpty) {
      return 'Please enter ending air.';
    }
    return null;
  }

  static String comments(value) {
    if (value.isEmpty) {
      return 'please enter some text';
    }
    return null;
  }

  static String title(value) {
    if (value.isEmpty) {
      return 'please enter some text';
    }
    return null;
  }
}
