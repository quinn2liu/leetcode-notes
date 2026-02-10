package com.interview.weather;

public class City {

    public final String name;
    public final String countryName;
    public final double latitude;
    public final double longitude;

    public City(final String name, final String countryName, final double latitude, final double longitude) {
        this.name = name;
        this.countryName = countryName;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}
