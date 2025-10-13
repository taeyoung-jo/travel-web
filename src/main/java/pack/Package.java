package pack;

public class Package {
	private int id;
	private String packageName;
	private String departure;
	private String destination;
	private String country;
	private double price;
	private double rating; // 별점 필드 추가
	private String imageUrl;

	public Package() {
	}

	public Package(int id, String packageName, String departure, String destination, String country, double price,
		double rating, String imageUrl) {
		this.id = id;
		this.packageName = packageName;
		this.departure = departure;
		this.destination = destination;
		this.country = country;
		this.price = price;
		this.rating = rating;
		this.imageUrl = imageUrl;
	}

	// getter & setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
}
