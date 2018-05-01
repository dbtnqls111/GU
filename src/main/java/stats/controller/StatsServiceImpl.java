package stats.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import stats.dao.StatsDAO;

@Service
public class StatsServiceImpl implements StatsService {

	@Autowired
	private StatsDAO statsDAO;

	@Override
	public ArrayList<HashMap<String, Object>> getStatsList(String date) {
		return (ArrayList<HashMap<String, Object>>) statsDAO.getStatsList(date);
	}

	@Override
	public ArrayList<HashMap<String, Object>> getStatsListByBranchName(String date, String branchName) {
		return (ArrayList<HashMap<String, Object>>) statsDAO.getStatsListByBranchName(date, branchName);
	}

	@Override
	public ArrayList<HashMap<String, Object>> getStatsListByItemType1(String date, String itemType1) {
		return (ArrayList<HashMap<String, Object>>) statsDAO.getStatsListByItemType1(date, itemType1);
	}

}
