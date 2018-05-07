package stats.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeSet;

public class StatsByBranchForGraph {

	private ArrayList<ArrayList<HashMap<String, Object>>> statsList6 = null;
	private ArrayList<String> branchNameListForGraph = new ArrayList<>();

	public StatsByBranchForGraph(ArrayList<ArrayList<HashMap<String, Object>>> statsList6) {
		this.statsList6 = statsList6;
	}

	public ArrayList<ArrayList<StatsByBranchDTO>> getStatsByBranchList6() {

		ArrayList<ArrayList<StatsByBranchDTO>> result = new ArrayList<>();

		for (int i = 0; i < statsList6.size(); i++) {
			ArrayList<StatsByBranchDTO> temp = new ArrayList<>();

			// 지점명 SET
			TreeSet<String> branchNameSet = new TreeSet<>();
			for (HashMap<String, Object> map : statsList6.get(i)) {
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

				for (HashMap<String, Object> map : statsList6.get(i)) {
					if (branchName.equals((String) map.get("branchName"))) {
						salesPrice += (int) map.get("salesPrice");
					}
				}

				statsByBranchDTO.setSalesPrice(salesPrice);
				temp.add(statsByBranchDTO);
			}

			result.add(temp);
		}

		// 여섯 달에 대한 모든 판매 정보에 포함된 지점명 SET
		TreeSet<String> branchNameSet = new TreeSet<>();
		for (ArrayList<StatsByBranchDTO> statsByBranchListForGraph : result) {
			for (StatsByBranchDTO statsByBranchDTO : statsByBranchListForGraph) {
				if (branchNameSet.isEmpty()) {
					branchNameSet.add(statsByBranchDTO.getBranchName());
				} else {
					if (!branchNameSet.contains(statsByBranchDTO.getBranchName())) {
						branchNameSet.add(statsByBranchDTO.getBranchName());
					}
				}
			}
		}

		for (String branchName : branchNameSet) {
			branchNameListForGraph.add(branchName);
		}

		for (ArrayList<StatsByBranchDTO> statsByBranchListForGraph : result) {
			int remainSize = statsByBranchListForGraph.size();
			for (int i = 0; i < branchNameListForGraph.size(); i++) {
				if (remainSize > 0) {
					if (branchNameListForGraph.get(i).equals(statsByBranchListForGraph.get(i).getBranchName())) {
						remainSize--;
					} else {
						StatsByBranchDTO statsByBranchDTO = new StatsByBranchDTO();
						statsByBranchDTO.setBranchName(branchNameListForGraph.get(i));
						statsByBranchDTO.setSalesPrice(0);
						statsByBranchListForGraph.add(i, statsByBranchDTO);
					}
				} else {
					StatsByBranchDTO statsByBranchDTO = new StatsByBranchDTO();
					statsByBranchDTO.setBranchName(branchNameListForGraph.get(i));
					statsByBranchDTO.setSalesPrice(0);
					statsByBranchListForGraph.add(statsByBranchDTO);
				}
			}
		}

		return result;
	}

	public ArrayList<String> getBranchNameListForGraph() {
		return branchNameListForGraph;
	}

}
