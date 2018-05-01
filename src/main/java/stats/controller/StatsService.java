package stats.controller;

import java.util.ArrayList;
import java.util.HashMap;

public interface StatsService {

	ArrayList<HashMap<String, Object>> getStatsList(String date);

	ArrayList<HashMap<String, Object>> getStatsListByBranchName(String date, String branchName);

	ArrayList<HashMap<String, Object>> getStatsListByItemType1(String date, String itemType1);

}
