package com.seojoo21.service;

import org.json.simple.JSONObject;

//기간별 데이터를 JSON으로 파싱 
public interface ChartService {
	
	public JSONObject getBnoNoByPeriod(String fromDate, String toDate);
	
	public JSONObject getRnoNoByPeriod(String fromDate, String toDate);
	
	public JSONObject getMemberNoByPeriod(String fromDate, String toDate);

}
