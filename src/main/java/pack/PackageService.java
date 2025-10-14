// PackageService.java
package pack;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class PackageService {
	private PackageRepository repo;

	public PackageService() {
		repo = new PackageRepository();
	}

	public List<Package> getPackageList() {
		return repo.getAllPackages();
	}

	public List<Package> searchPackages(String keyword, String sortBy) {
		List<Package> all = repo.getAllPackages();
		List<Package> result = new ArrayList<>();

		if (keyword != null && !keyword.trim().isEmpty()) {
			String key = keyword.toLowerCase();
			for (Package p : all) {
				if (p.getCountry().toLowerCase().contains(key) || p.getDestination().toLowerCase().contains(key)) {
					result.add(p);
				}
			}
		}

		if (sortBy != null) {
			switch (sortBy) {
				case "priceAsc":
					result.sort(Comparator.comparingDouble(Package::getPrice));
					break;
				case "priceDesc":
					result.sort(Comparator.comparingDouble(Package::getPrice).reversed());
					break;
				case "ratingDesc":
					result.sort(Comparator.comparingDouble(Package::getRating).reversed());
					break;
			}
		}

		return result;
	}

	public Package getPackageById(int id) {
		for (Package p : repo.getAllPackages()) {
			if (p.getId() == id)  // int끼리 비교
				return p;
		}
		return null;
	}

}
