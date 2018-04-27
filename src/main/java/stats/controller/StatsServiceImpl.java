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
	public ArrayList<HashMap<String, Object>> getStatsByBranchList(String date) {
		return (ArrayList<HashMap<String, Object>>) statsDAO.getStatsByBranchList(date);
	}

	@Override
	public ArrayList<HashMap<String, Object>> getStatsByBranchList_branchName(String date, String branchName) {
		return (ArrayList<HashMap<String, Object>>) statsDAO.getStatsByBranchList_branchName(date, branchName);
	}

}
