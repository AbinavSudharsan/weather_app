String getWeatherIcon(String condition, int isDay) {
  condition = condition.toLowerCase();

  if (condition.contains("sunny")) {
    return "assets/icons/weather/sunny.svg";
  }
  else if (condition.contains("clear")) {
    return "assets/icons/weather/clear_night.svg";
  }
  else if (condition.contains("partly cloudy")) {
    return isDay == 1 ?
    "assets/icons/weather/pcloudy.svg" :
    "assets/icons/weather/partly_cloudy_0.svg";
  }
  else if (condition.contains("cloudy")) {
    return isDay == 1 ?
    "assets/icons/weather/mcloudy.svg" :
    "assets/icons/weather/mcloudy 0.svg";
  }
  else if (condition.contains("overcast")) {
    return isDay == 1 ?
    "assets/icons/weather/mcloudy.svg" :
    "assets/icons/weather/mcloudy 0.svg";
  }
  else if  (condition.contains("mist")) {
    return isDay == 1 ?
    "assets/icons/weather/Foggy.svg" :
    "assets/icons/weather/foggy 0.svg";
  }
  else if (condition.contains("fog")){
    return isDay == 1 ?
    "assets/icons/weather/Foggy.svg" :
    "assets/icons/weather/foggy 0.svg";
  }
  else if (condition.contains("freezing fog")){
    return isDay == 1 ?
    "assets/icons/weather/Foggy.svg" :
    "assets/icons/weather/foggy 0.svg";
  }
  else if (condition.contains("patchy light drizzle")){
    return isDay == 1 ?
    "assets/icons/weather/Lrain.svg" :
    "assets/icons/weather/Lrain 0.svg";
  }
  else if (condition.contains("light drizzle")){
    return isDay == 1 ?
    "assets/icons/weather/Lrain.svg" :
    "assets/icons/weather/Lrain 0.svg";
  }
  else if (condition.contains("patchy light rain")){
    return isDay == 1 ?
    "assets/icons/weather/Lrain.svg" :
    "assets/icons/weather/Lrain 0.svg";
  }
  else if (condition.contains("light rain")){
    return isDay == 1 ?
    "assets/icons/weather/Lrain.svg" :
    "assets/icons/weather/Lrain 0.svg";
  }
  else if (condition.contains("moderate rain at times")){
    return isDay == 1 ?
    "assets/icons/weather/Lrain.svg" :
    "assets/icons/weather/Lrain 0.svg";
  }
  return "assets/icons/weather/sunny.svg";
}