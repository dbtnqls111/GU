package stats.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeSet;

public class StatsByItemForGraph {

	private ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = null;
	private ArrayList<String> itemType1ListForGraph = new ArrayList<>();

	public StatsByItemForGraph(ArrayList<ArrayList<HashMap<String, Object>>> statsList6) {
		this.statsList6 = statsList6;
	}

	public ArrayList<ArrayList<StatsByItemDTO>> getStatsByItemList6() {

		ArrayList<ArrayList<StatsByItemDTO>> result = new ArrayList<>();

		for (int i = 0; i < statsList6.size(); i++) {
			ArrayList<StatsByItemDTO> temp = new ArrayList<>();

			// 품목 타입1 SET
			TreeSet<String> itemType1Set = new TreeSet<>();
			for (HashMap<String, Object> map : statsList6.get(i)) {
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

				for (HashMap<String, Object> map : statsList6.get(i)) {
					if (itemType1.equals((String) map.get("itemType1"))) {
						salesPrice += (int) map.get("salesPrice");
					}
				}

				statsByItemDTO.setSalesPrice(salesPrice);
				temp.add(statsByItemDTO);
			}

			result.add(temp);
		}

		// 여섯 달에 대한 모든 판매 정보에 포함된 품목 타입1 SET
		TreeSet<String> itemType1Set = new TreeSet<>();
		for (ArrayList<StatsByItemDTO> statsByItemListForGraph : result) {
			for (StatsByItemDTO statsByItemDTO : statsByItemListForGraph) {
				if (itemType1Set.isEmpty()) {
					itemType1Set.add(statsByItemDTO.getItemType1());
				} else {
					if (!itemType1Set.contains(statsByItemDTO.getItemType1())) {
						itemType1Set.add(statsByItemDTO.getItemType1());
					}
				}
			}
		}

		for (String itemType1 : itemType1Set) {
			itemType1ListForGraph.add(itemType1);
		}

		for (ArrayList<StatsByItemDTO> statsByItemListForGraph : result) {
			int remainSize = statsByItemListForGraph.size();
			for (int i = 0; i < itemType1ListForGraph.size(); i++) {
				if (remainSize > 0) {
					if (itemType1ListForGraph.get(i).equals(statsByItemListForGraph.get(i).getItemType1())) {
						remainSize--;
					} else {
						StatsByItemDTO statsByItemDTO = new StatsByItemDTO();
						statsByItemDTO.setItemType1(itemType1ListForGraph.get(i));
						statsByItemDTO.setSalesPrice(0);
						statsByItemListForGraph.add(i, statsByItemDTO);
					}
				} else {
					StatsByItemDTO statsByItemDTO = new StatsByItemDTO();
					statsByItemDTO.setItemType1(itemType1ListForGraph.get(i));
					statsByItemDTO.setSalesPrice(0);
					statsByItemListForGraph.add(statsByItemDTO);
				}
			}
		}

		return result;
	}

	public ArrayList<String> getItemType1ListForGraph() {
		return itemType1ListForGraph;
	}

}
