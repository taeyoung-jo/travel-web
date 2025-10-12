package reservation;

public class Reservation {
    private String id;
    private String name;
    private String orderDate;
    private String departDate;
    private int people;
    private int totalPrice;
    private String status;


    // --- Getter & Setter ---
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }

    public String getDepartDate() { return departDate; }
    public void setDepartDate(String departDate) { this.departDate = departDate; }

    public int getPeople() { return people; }
    public void setPeople(int people) { this.people = people; }

    public int getTotalPrice() { return totalPrice; }
    public void setTotalPrice(int totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

