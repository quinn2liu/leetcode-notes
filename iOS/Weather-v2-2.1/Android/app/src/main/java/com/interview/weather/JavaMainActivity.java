package com.interview.weather;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

public class JavaMainActivity extends AppCompatActivity {

    /*
    *************************************************************************************************************************
        NOTE: BEFORE MAKING CHANGES HERE, MAKE SURE THAT YOU CHANGE ACTIVITY TO JavaMainActivity IN AndroidManifest.xml
    *************************************************************************************************************************
    */

    private WeatherClient weatherNetworkClient;

    private RecyclerView citiesList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        weatherNetworkClient = WeatherClientBuilder.build();
        setContentView(R.layout.activity_main);

        citiesList = findViewById(R.id.cities_list);
        citiesList.setLayoutManager(new LinearLayoutManager(this));
        try {
            citiesList.setAdapter(new CitiesAdapter(weatherNetworkClient.waitForCities().cities));
        } catch (final Exception e) {
            Log.e(JavaMainActivity.class.getSimpleName(), "Error on waitForCities", e);
        }
    }

    private static class CitiesAdapter extends RecyclerView.Adapter<CitiesAdapter.ViewHolder> {

        private final List<City> cities;

        private CitiesAdapter(final List<City> cities) {
            this.cities = cities;
        }

        @NonNull
        @Override
        public ViewHolder onCreateViewHolder(@NonNull final ViewGroup parent, final int viewType) {
            return new ViewHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.city_item, parent, false));
        }

        @Override
        public void onBindViewHolder(@NonNull final ViewHolder holder, final int position) {
            TextView cityNameView = holder.itemView.findViewById(R.id.city_name);
            cityNameView.setText(cities.get(position).name);
        }

        @Override
        public int getItemCount() {
            return cities.size();
        }

        static class ViewHolder extends RecyclerView.ViewHolder {
            ViewHolder(final View itemView) {
                super(itemView);
            }
        }
    }
}
