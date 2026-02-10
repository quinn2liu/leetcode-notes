package com.interview.weather.details;

public class PredictedWeather {

    public final float minTempCelsius;
    public final float maxTempCelsius;
    public final String shortDescription;

    public PredictedWeather(final float minTempCelsius, final float maxTempCelsius, final String shortDescription) {
        this.minTempCelsius = minTempCelsius;
        this.maxTempCelsius = maxTempCelsius;
        this.shortDescription = shortDescription;
    }
}
