package stats.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.TreeSet;

public class StatsByBranch {

	private ArrayList<HashMap<String, Object>> statsList = null;
	private int totalSalesPrice = 0;

	public StatsByBranch(ArrayList<HashMap<String, Object>> statsList) {
		this.statsList = statsList;
	}

	// orderBySalesPrice : true - salesPrice 오름차순 정렬
	// false - 디폴트로 branchName 오름차순 정렬
	public ArrayList<StatsByBranchDTO> getStatsByBranchList(boolean orderBySalesPrice) {
		if (statsList == null && statsList.size() == 0) {
			return null;
		}

		ArrayList<StatsByBranchDTO> result = new ArrayList<>();

		// 지점명 SET
		TreeSet<String> branchNameSet = new TreeSet<>();
		for (HashMap<String, Object> map : statsList) {
			if (branchNameSet.isEmpty()) {
				branchNameSet.add((String) map.get("branchName"));
			} else {
				if (!branchNameSet.contains((String) map.get("branchName"))) {
					branchNameSet.add((String) map.get("branchName"));
				}
			}
		}

		// 지점별 판매액 합산
		for (String branchName : branchNameSet) {
			StatsByBranchDTO statsByBranchDTO = new StatsByBranchDTO();
			statsByBranchDTO.setBranchName(branchName);
			int salesPrice = 0;

			for (HashMap<String, Object> map : statsList) {
				if (branchName.equals((String) map.get("branchName"))) {
					salesPrice += (int) map.get("salesPrice");
				}
			}

			totalSalesPrice += salesPrice;
			statsByBranchDTO.setSalesPrice(salesPrice);
			result.add(statsByBranchDTO);
		}

		if (orderBySalesPrice) {
			// 지점별 판매액 순위로 정렬
			Collections.sort(result);
		}

		// 지점별 순위 및 점유율 입력
		for (int i = 0; i < result.size(); i++) {
			result.get(i).setRank(i + 1);
			double ratio = Math.round(((result.get(i).getSalesPrice() / (double) totalSalesPrice) * 10000d)) / 100d;
			result.get(i).setRatio(ratio);
		}

		return result;
	}

	public int getTotalSalesPrice() {
		return totalSalesPrice;
	}

}
