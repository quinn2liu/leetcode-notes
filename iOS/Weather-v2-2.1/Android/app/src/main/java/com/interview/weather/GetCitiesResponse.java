package com.interview.weather;

import java.util.List;

public class GetCitiesResponse {

    public final List<City> cities;

    public GetCitiesResponse(final List<City> cities) {
        this.cities = cities;
    }
}
