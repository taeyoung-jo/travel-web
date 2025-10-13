package pack;

import java.util.List;

public class PackageService {
	private PackageRepository dao = new PackageRepository();

	public List<Package> getPackageList() {
		return dao.getAllPackages();
	}

	public Package getPackageDetail(int id) {
		return dao.getPackageById(id);
	}

	public void addPackage(Package pkg) {
		dao.addPackage(pkg);
	}

	public void deletePackage(int id) {
		dao.deletePackage(id);
	}
}
