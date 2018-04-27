package stats.controller;

import java.util.ArrayList;
import java.util.HashMap;

public interface StatsService {

	ArrayList<HashMap<String, Object>> getStatsByBranchList(String date);

	ArrayList<HashMap<String, Object>> getStatsByBranchList_branchName(String date, String branchName);

}
