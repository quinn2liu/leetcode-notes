package com.interview.weather.details;

public class CurrentWeather {

    public final String longDescription;
    public final float feelsLikeCelsius;
    public final short rainChancePercent;
    public final short humidityPercent;
    public final String airPressureDescription;
    public final String windDirection;
    public final float windSpeed;

    public CurrentWeather(
            final String longDescription,
            final float feelsLikeCelsius,
            final short rainChancePercent,
            final short humidityPercent,
            final String airPressureDescription,
            final String windDirection,
            final float windSpeed) {
        this.longDescription = longDescription;
        this.feelsLikeCelsius = feelsLikeCelsius;
        this.rainChancePercent = rainChancePercent;
        this.humidityPercent = humidityPercent;
        this.airPressureDescription = airPressureDescription;
        this.windDirection = windDirection;
        this.windSpeed = windSpeed;
    }
}
