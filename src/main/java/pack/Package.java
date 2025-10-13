package pack;

public class Package {
	private int packageId;
	private String packageName;
	private String departure;
	private String destination;
	private String departureDate;
	private int days;
	private double price;
	private String imageUrl; // ✅ 이미지 경로 추가

	public Package() {
	}

	public Package(int packageId, String packageName, String departure, String destination,
		String departureDate, int days, double price, String imageUrl) {
		this.packageId = packageId;
		this.packageName = packageName;
		this.departure = departure;
		this.destination = destination;
		this.departureDate = departureDate;
		this.days = days;
		this.price = price;
		this.imageUrl = imageUrl;
	}

	// Getter & Setter
	public int getPackageId() {
		return packageId;
	}

	public void setPackageId(int packageId) {
		this.packageId = packageId;
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

	public String getDepartureDate() {
		return departureDate;
	}

	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@Override
	public String toString() {
		return "PackageDTO{" +
			"packageId=" + packageId +
			", packageName='" + packageName + '\'' +
			", departure='" + departure + '\'' +
			", destination='" + destination + '\'' +
			", departureDate='" + departureDate + '\'' +
			", days=" + days +
			", price=" + price +
			", imageUrl='" + imageUrl + '\'' +
			'}';
	}
}
