package com.travelers.travelweb.domain.hotel.domain;

public class Hotel {
    private int id;
    private String name;
    private int city;
    private String country;
    private String image;
    private String price;       // "₩123,456" 형태
    private double rating;

    // 생성자
    public Hotel(int id, String name, int city, String country, String image, String price, double rating, int roomNum, String roomType) {
        this.id = id;
        this.name = name;
        this.city = city;
        this.country = country;
        this.image = image;
        this.price = price;
        this.rating = rating;
    }

    // 기본 생성자
    public Hotel() {}

    // Getter / Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getCity() { return city; }
    public void setCity(int city) { this.city = city; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getPrice() { return price; }
    public void setPrice(String price) { this.price = price; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

}
