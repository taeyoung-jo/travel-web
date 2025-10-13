package pack;

import java.util.ArrayList;
import java.util.List;

public class PackageRepository {
	private static List<Package> packageList = new ArrayList<>();

	static {
		// 가까운 여행지 (7개)
		packageList.add(
			new Package(1, "도쿄 벚꽃 여행 3일", "서울", "도쿄", "2025-03-28", 3, 890000, "../webapp/image/package/tokyo.jpg"));
		packageList.add(
			new Package(2, "오사카 맛집 탐방 4일", "서울", "오사카", "2025-04-15", 4, 950000, "../webapp/image/package/osaka.jpg"));
		packageList.add(
			new Package(3, "방콕 힐링 여행 5일", "서울", "방콕", "2025-02-10", 5, 1150000, "../webapp/image/package/bangkok.jpg"));
		packageList.add(
			new Package(4, "다낭 가족 여행 4일", "서울", "다낭", "2025-05-03", 4, 1050000, "../webapp/image/package/danang.jpg"));
		packageList.add(new Package(5, "타이베이 미식 여행 3일", "서울", "타이베이", "2025-04-02", 3, 870000,
			"../webapp/image/package/taipei.jpg"));
		packageList.add(new Package(6, "상하이 도심 투어 4일", "서울", "상하이", "2025-05-20", 4, 990000,
			"../webapp/image/package/sanghai.jpg"));
		packageList.add(new Package(7, "싱가포르 야경 여행 5일", "서울", "싱가포르", "2025-06-05", 5, 1190000,
			"../webapp/image/package/singapore.jpg"));

		// 먼 여행지 (7개)
		packageList.add(
			new Package(8, "파리 낭만 여행 7일", "서울", "파리", "2025-06-21", 7, 2890000, "../webapp/image/package/paris.jpg"));
		packageList.add(
			new Package(9, "런던 시티 투어 6일", "서울", "런던", "2025-07-10", 6, 2750000, "../webapp/image/package/london.jpg"));
		packageList.add(
			new Package(10, "로마 예술 여행 5일", "서울", "로마", "2025-09-12", 5, 2650000, "../webapp/image/package/roma.jpg"));
		packageList.add(new Package(11, "뉴욕 자유 여행 6일", "서울", "뉴욕", "2025-08-01", 6, 3150000,
			"../webapp/image/package/newyork.jpg"));
		packageList.add(new Package(12, "로스앤젤레스 해변 여행 7일", "서울", "로스앤젤레스", "2025-10-05", 7, 2980000,
			"../webapp/image/package/losangeles.jpg"));
		packageList.add(new Package(13, "스위스 알프스 하이킹 6일", "서울", "취리히", "2025-07-22", 6, 3100000,
			"../webapp/image/package/swiss.jpg"));
		packageList.add(new Package(14, "프라하 감성 여행 5일", "서울", "프라하", "2025-09-01", 5, 2550000,
			"../webapp/image/package/praha.jpg"));
	}

	public List<Package> getAllPackages() {
		return packageList;
	}

	public Package getPackageById(int id) {
		for (Package p : packageList) {
			if (p.getPackageId() == id) {
				return p;
			}
		}
		return null;
	}

	public void addPackage(Package pkg) {
		packageList.add(pkg);
	}

	public void deletePackage(int id) {
		packageList.removeIf(p -> p.getPackageId() == id);
	}
}
