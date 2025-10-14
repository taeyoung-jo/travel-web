// PackageRepository.java
package pack;

import java.util.ArrayList;
import java.util.List;

public class PackageRepository {
	private static List<Package> packageList = new ArrayList<>();

	static {
		// 가까운 여행지
		packageList.add(new Package(1, "도쿄 벚꽃 여행 3일", "김포", "도쿄", "일본", 890000, 3.0, "image/package/tokyo.jpg"));
		packageList.add(new Package(2, "오사카 맛집 탐방 4일", "인천", "오사카", "일본", 950000, 4.0, "image/package/osaka.jpg"));
		packageList.add(new Package(3, "방콕 힐링 여행 5일", "김포", "방콕", "태국", 1150000, 5.0, "image/package/bangkok.jpg"));
		packageList.add(new Package(4, "다낭 가족 여행 4일", "인천", "다낭", "베트남", 1050000, 4.0, "image/package/danang.jpg"));
		packageList.add(new Package(5, "타이베이 미식 여행 3일", "김포", "타이베이", "대만", 870000, 3.0, "image/package/taipei.jpg"));
		packageList.add(new Package(6, "상하이 도심 투어 4일", "인천", "상하이", "중국", 990000, 4.0, "image/package/sanghai.jpg"));
		packageList.add(new Package(7, "싱가포르 야경 여행 5일", "인천", "싱가포르", "싱가포르", 1190000, 5.0, "image/package/singapore.jpg"));

		// 먼 여행지
		packageList.add(new Package(8, "파리 낭만 여행 7일", "김포", "파리", "프랑스", 2890000, 7.0, "image/package/paris.jpg"));
		packageList.add(new Package(9, "런던 시티 투어 6일", "인천", "런던", "영국", 2750000, 6.0, "image/package/london.jpg"));
		packageList.add(new Package(10, "로마 예술 여행 5일", "김포", "로마", "이탈리아", 2650000, 5.0, "image/package/roma.jpg"));
		packageList.add(new Package(11, "뉴욕 자유 여행 6일", "인천", "뉴욕", "미국", 3150000, 6.0, "image/package/newyork.jpg"));
		packageList.add(new Package(12, "로스앤젤레스 해변 여행 7일", "김포", "로스앤젤레스", "미국", 2980000, 7.0, "image/package/losangeles.jpg"));
		packageList.add(new Package(13, "스위스 알프스 하이킹 6일", "인천", "취리히", "스위스", 3100000, 6.0, "image/package/swiss.jpg"));
		packageList.add(new Package(14, "프라하 감성 여행 5일", "김포", "프라하", "체코", 2550000, 5.0, "image/package/praha.jpg"));

		// 일본 패키지 추가
		packageList.add(new Package(16, "오키나와 휴양 여행 4일", "김포", "오키나와", "일본", 1380000, 4.0, "image/package/bangkok.jpg"));
		packageList.add(new Package(17, "교토 문화 탐방 3일", "인천", "교토", "일본", 920000, 3.0, "image/package/danang.jpg"));
		packageList.add(new Package(18, "후쿠오카 쇼핑 여행 3일", "김포", "후쿠오카", "일본", 880000, 3.0, "image/package/taipei.jpg"));

		// 미국 패키지 추가
		packageList.add(new Package(19, "샌프란시스코 골든게이트 투어 4일", "인천", "샌프란시스코", "미국", 1420000, 4.0, "image/package/paris.jpg"));
		packageList.add(new Package(20, "라스베이거스 카지노 여행 3일", "김포", "라스베이거스", "미국", 1190000, 3.0, "image/package/london.jpg"));
		packageList.add(new Package(21, "마이애미 해변 휴양 5일", "인천", "마이애미", "미국", 1650000, 5.0, "image/package/roma.jpg"));
	}

	public List<Package> getAllPackages() {
		return packageList;
	}

	public Package getPackageById(int id) {
		for (Package p : packageList) {
			if (p.getId() == id)
				return p;
		}
		return null;
	}

	public void addPackage(Package pkg) {
		packageList.add(pkg);
	}

	public void deletePackage(int id) {
		packageList.removeIf(p -> p.getId() == id);
	}
}
