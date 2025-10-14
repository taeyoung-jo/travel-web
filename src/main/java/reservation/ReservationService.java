package reservation;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReservationService")
public class ReservationService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReservationRepository repo = new ReservationRepository();

        // 파라미터 month, tab
        String tab = request.getParameter("tab");
        String monthStr = request.getParameter("months");
        int months = 1;
        if(monthStr != null && !monthStr.isEmpty()) {
            try { months = Integer.parseInt(monthStr); } catch(Exception e) {}
        }

        if("cancel".equals(tab)) {
            List<Reservation> cancelList = repo.getAllCancellations();
            request.setAttribute("cancelList", cancelList);
        } else {
            List<Reservation> reservationList = repo.getRecentReservations(months);
            request.setAttribute("reservationList", reservationList);
        }

        request.setAttribute("activeTab", tab == null ? "reservation" : tab);
        request.getRequestDispatcher("mypage_reservation.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
