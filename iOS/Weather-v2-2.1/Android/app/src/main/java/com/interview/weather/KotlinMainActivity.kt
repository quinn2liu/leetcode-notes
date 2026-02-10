package com.interview.weather

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.io.IOException

class KotlinMainActivity : AppCompatActivity() {

    private lateinit var citiesList: RecyclerView

    private val weatherNetworkClient: WeatherClient = WeatherClientBuilder.build()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        citiesList = findViewById(R.id.cities_list)
        citiesList.layoutManager = LinearLayoutManager(this)
        try {
            citiesList.adapter = CitiesAdapter(weatherNetworkClient.waitForCities()!!.cities)
        } catch (e : IOException) {
            Log.e(KotlinMainActivity::class.java.simpleName, "Error on waitForCities", e)
        }
    }

    class CitiesAdapter(private val cities: List<City>) : RecyclerView.Adapter<CitiesAdapter.ViewHolder>() {

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
            return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.city_item, parent, false))
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            holder.itemView.findViewById<TextView>(R.id.city_name).text = cities[position].name
        }

        override fun getItemCount(): Int {
            return cities.size
        }

        class ViewHolder(view : View) : RecyclerView.ViewHolder(view)
    }
}
