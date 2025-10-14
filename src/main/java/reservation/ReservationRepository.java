package reservation;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.text.SimpleDateFormat;
public class ReservationRepository {

        private static List<Reservation> reservationData = new ArrayList<>();
        private static List<Reservation> cancelData = new ArrayList<>();

        static {
            // ------------------ 예약 내역 ------------------
            Reservation r1 = new Reservation();
            r1.setId("R20251012001");
            r1.setName("오사카 3일 자유여행");
            r1.setOrderDate("2025-10-05");
            r1.setDepartDate("2025-11-05");
            r1.setPeople(2);
            r1.setTotalPrice(1298000);
            r1.setStatus("예약완료");

            Reservation r2 = new Reservation();
            r2.setId("R20250815001");
            r2.setName("도쿄 디즈니랜드 4일");
            r2.setOrderDate("2025-08-10");
            r2.setDepartDate("2025-09-20");
            r2.setPeople(3);
            r2.setTotalPrice(2100000);
            r2.setStatus("결제대기");

            Reservation r3 = new Reservation();
            r3.setId("R20250720002");
            r3.setName("후쿠오카 자유여행 3일");
            r3.setOrderDate("2025-07-18");
            r3.setDepartDate("2025-08-05");
            r3.setPeople(1);
            r3.setTotalPrice(980000);
            r3.setStatus("예약완료");

            Reservation r4 = new Reservation();
            r4.setId("R20250915002");
            r4.setName("교토 2일 자유여행");
            r4.setOrderDate("2025-06-15");
            r4.setDepartDate("2025-10-20");
            r4.setPeople(2);
            r4.setTotalPrice(680000);
            r4.setStatus("예약완료");

            Reservation r5 = new Reservation();
            r5.setId("R20251001003");
            r5.setName("삿포로 스키 여행 3일");
            r5.setOrderDate("2025-05-01");
            r5.setDepartDate("2025-12-05");
            r5.setPeople(4);
            r5.setTotalPrice(3200000);
            r5.setStatus("결제대기");

            reservationData.add(r1);
            reservationData.add(r2);
            reservationData.add(r3);
            reservationData.add(r4);
            reservationData.add(r5);
            // ------------------ 취소 내역 ------------------
            Reservation c1 = new Reservation();
            c1.setId("C20250910001");
            c1.setName("오키나와 3일 패키지");
            c1.setOrderDate("2025-09-05"); // 취소일
            c1.setDepartDate("2025-09-20");
            c1.setPeople(2);
            c1.setTotalPrice(450000); // 환불금액
            c1.setStatus("취소완료");

            cancelData.add(c1);
        }

        // 전체 예약내역 반환
        public List<Reservation> getAllReservations() {
            return reservationData;
        }

        // 최근 N개월 예약내역 반환
        public List<Reservation> getRecentReservations(int months) {
            return filterByMonths(reservationData, months);
        }

        // 전체 취소내역 반환
        public List<Reservation> getAllCancellations() {
            return cancelData;
        }

    // 최근 N개월 취소내역 반환 (status가 "취소완료"인 것만)
    public List<Reservation> getRecentCancellations(int months) {
        List<Reservation> allCancel = filterByMonths(cancelData, months);
        List<Reservation> result = new ArrayList<>();
        for (Reservation r : allCancel) {
            if ("취소완료".equals(r.getStatus())) {
                result.add(r);
            }
        }
        return result;
    }

        // ------------------ 공통 필터 함수 ------------------
        private List<Reservation> filterByMonths(List<Reservation> data, int months) {
            List<Reservation> result = new ArrayList<>();
            LocalDate today = LocalDate.now();
            LocalDate limit = today.minusMonths(months);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            for (Reservation r : data) {
                if (r.getOrderDate() == null) continue;
                LocalDate date = LocalDate.parse(r.getOrderDate(), formatter);
                if (!date.isBefore(limit) && !date.isAfter(today)) {
                    result.add(r);
                }
            }
            return result;
        }
    }

