package stats.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.TreeSet;

public class StatsByBranch_itemType {

	private ArrayList<HashMap<String, Object>> statsList = null;
	private int totalSalesPrice = 0;

	public StatsByBranch_itemType(ArrayList<HashMap<String, Object>> statsList) {
		this.statsList = statsList;
	}

	public ArrayList<StatsByBranch_itemType1DTO> getStatsByBranchList_itemType() {
		if (statsList == null && statsList.size() == 0) {
			return null;
		}

		ArrayList<StatsByBranch_itemType1DTO> result = new ArrayList<>();

		// 품목 타입1 SET
		TreeSet<String> itemType1Set = new TreeSet<>();

		for (HashMap<String, Object> map : statsList) {
			if (itemType1Set.isEmpty()) {
				itemType1Set.add((String) map.get("itemType1"));
			} else {
				if (!itemType1Set.contains((String) map.get("itemType1"))) {
					itemType1Set.add((String) map.get("itemType1"));
				}
			}
		}

		// System.out.println("itemType1Set : " + itemType1Set);

		// 품목 타입1별 판매액 합산
		for (String itemType1 : itemType1Set) {
			StatsByBranch_itemType1DTO statsByBranch_itemType1DTO = new StatsByBranch_itemType1DTO();
			statsByBranch_itemType1DTO.setItemType1(itemType1);
			int salesPrice = 0;
			// 품목 타입2 SET
			TreeSet<String> itemType2Set = new TreeSet<>();
			ArrayList<StatsByBranch_itemType2DTO> result2 = new ArrayList<>();

			for (HashMap<String, Object> map : statsList) {
				if (itemType1.equals((String) map.get("itemType1"))) {
					salesPrice += (int) map.get("salesPrice");

					if (itemType2Set.isEmpty()) {
						itemType2Set.add((String) map.get("itemType2"));
					} else {
						if (!itemType2Set.contains((String) map.get("itemType2"))) {
							itemType2Set.add((String) map.get("itemType2"));
						}
					}
				}
			}
			// System.out.println("itemType2Set : " + itemType2Set);
			// 품목 타입2별 판매액 합산
			for (String itemType2 : itemType2Set) {
				StatsByBranch_itemType2DTO statsByBranch_itemType2DTO = new StatsByBranch_itemType2DTO();
				statsByBranch_itemType2DTO.setItemType2(itemType2);
				int salesPrice2 = 0;

				for (HashMap<String, Object> map : statsList) {
					if (itemType1.equals((String) map.get("itemType1"))
							&& itemType2.equals((String) map.get("itemType2"))) {
						salesPrice2 += (int) map.get("salesPrice");
					}
				}

				statsByBranch_itemType2DTO.setSalesPrice(salesPrice2);
				result2.add(statsByBranch_itemType2DTO);
			}

			// 품목 타입2별 판매액 순위로 정렬
			Collections.sort(result2);

			// 품목 타입2별 순위 및 점유율 입력
			for (int i = 0; i < result2.size(); i++) {
				result2.get(i).setRank(i + 1);
				// 타입2별 점유율을 전체 기준? 혹은 타입1 기준? 정해야됨 salesPrice <-> totalSalesPrice
				// 전체 기준으로 정해서 totalSalesPrice를 쓸 경우 해당 for문 위치 totalSalesPrice += salesPrice; 아래로 바꿔야됨
				double ratio = Math.round(((result2.get(i).getSalesPrice() / (double) salesPrice) * 10000d)) / 100d;
				result2.get(i).setRatio(ratio);
			}

			totalSalesPrice += salesPrice;
			statsByBranch_itemType1DTO.setSalesPrice(salesPrice);
			statsByBranch_itemType1DTO.setDetailList(result2);
			result.add(statsByBranch_itemType1DTO);
		}

		// 품목 타입1별 판매액 순위로 정렬
		Collections.sort(result);

		// 품목 타입1별 순위 및 점유율 입력
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
