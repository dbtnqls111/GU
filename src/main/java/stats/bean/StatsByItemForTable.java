package stats.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.TreeSet;

public class StatsByItemForTable {

	private ArrayList<HashMap<String, Object>> statsList = null;
	private int totalSalesPrice = 0;

	public StatsByItemForTable(ArrayList<HashMap<String, Object>> statsList) {
		this.statsList = statsList;
	}

	public ArrayList<StatsByItemDTO> getStatsByItemList() {

		ArrayList<StatsByItemDTO> result = new ArrayList<>();

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

		// 품목 타입1별 판매액 합산
		for (String itemType1 : itemType1Set) {
			StatsByItemDTO statsByItemDTO = new StatsByItemDTO();
			statsByItemDTO.setItemType1(itemType1);
			int salesPrice = 0;
			// 품목 타입2 SET
			TreeSet<String> itemType2Set = new TreeSet<>();
			ArrayList<StatsByItemDetailDTO> result2 = new ArrayList<>();

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

			// 품목 타입2별 판매액 합산
			for (String itemType2 : itemType2Set) {
				StatsByItemDetailDTO statsByItemDetailDTO = new StatsByItemDetailDTO();
				statsByItemDetailDTO.setItemType2(itemType2);
				int salesPrice2 = 0;

				for (HashMap<String, Object> map : statsList) {
					if (itemType1.equals((String) map.get("itemType1"))
							&& itemType2.equals((String) map.get("itemType2"))) {
						salesPrice2 += (int) map.get("salesPrice");
					}
				}

				statsByItemDetailDTO.setSalesPrice(salesPrice2);
				result2.add(statsByItemDetailDTO);
			}

			// 품목 타입2별 판매액 순위로 정렬
			Collections.sort(result2);

			// 품목 타입2별 순위 및 점유율 입력
			for (int i = 0; i < result2.size(); i++) {
				result2.get(i).setRank(i + 1);
				double ratio = Math.round(((result2.get(i).getSalesPrice() / (double) salesPrice) * 10000d)) / 100d;
				result2.get(i).setRatio(ratio);
			}

			totalSalesPrice += salesPrice;
			statsByItemDTO.setSalesPrice(salesPrice);
			statsByItemDTO.setDetailList(result2);
			result.add(statsByItemDTO);
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
