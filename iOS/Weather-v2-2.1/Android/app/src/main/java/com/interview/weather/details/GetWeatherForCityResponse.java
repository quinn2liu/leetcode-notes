package com.interview.weather.details;

import java.util.Map;

public class GetWeatherForCityResponse {

    public final CurrentWeather currentWeather;
    public final Map<String, PredictedWeather> predictedWeatherForDays;

    public GetWeatherForCityResponse(
            final CurrentWeather currentWeather,
            final Map<String, PredictedWeather> predictedWeatherForDays) {
        this.currentWeather = currentWeather;
        this.predictedWeatherForDays = predictedWeatherForDays;
    }
}
