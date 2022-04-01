package com.seojoo21.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seojoo21.mapper.ChartMapper;

import lombok.Setter;

//기간별 데이터를 JSON으로 파싱 
@Service
public class ChartServiceImpl implements ChartService {
	
	@Setter(onMethod_= {@Autowired})
	private ChartMapper mapper;
	
//	 JSON 구현 형태 
//	{
//	    "cols": [
//	        {"type":"string", "label":"등록일"}
//	        {"type":"number", "label":"개수"}
//	    ], 
//	    "rows": [
//	        {"c":[{"v":"날짜"}, {"v":"개수"}]}
//	    ]
//	}
	
	// 기간별 게시글 수  
	@SuppressWarnings("unchecked")
	@Override
	public JSONObject getBnoNoByPeriod(String fromDate, String toDate) {
		
		List<Map<String,Object>> list = mapper.getBoardNoByPeriod(fromDate, toDate);
		
		// 최종적으로 cols와 rows가 담길 JSON Object
		JSONObject data = new JSONObject();
		
		// cols 생성 
		JSONArray colsArray = new JSONArray();
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		
		col1.put("type", "string");
		col1.put("label", "등록일");
		
		col2.put("type", "number");
		col2.put("label", "개수");
		
		colsArray.add(col1);
		colsArray.add(col2);
		
		// rows 생성 
		JSONArray rowsArray = new JSONArray(); // rows 
		
		for(Map<String, Object> map : list) {
			
			// {"c":[{"v":"날짜"}, {"v":"수"}]}
			JSONObject date = new JSONObject();
			date.put("v", map.get("REGDATE"));
			
			JSONObject count = new JSONObject();
			count.put("v", map.get("CNT"));
			
			JSONArray row = new JSONArray();
			row.add(date);
			row.add(count);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row); // 레코드 1행 추가 
			
			rowsArray.add(cell);
		} //end for 
		
		// 생성한 cols와 rows을 최종 JSON Object인 data에 담음 
		data.put("cols", colsArray);
		data.put("rows", rowsArray);
		
		return data;
	}

	// 기간별 댓글 수  
	@SuppressWarnings("unchecked")
	@Override
	public JSONObject getRnoNoByPeriod(String fromDate, String toDate) {
		List<Map<String,Object>> list = mapper.getReplyNoByPeriod(fromDate, toDate);
		
		// 최종적으로 cols와 rows가 담길 JSON Object
		JSONObject data = new JSONObject();
		
		// cols 생성 
		JSONArray colsArray = new JSONArray();
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		
		col1.put("type", "string");
		col1.put("label", "등록일");
		
		col2.put("type", "number");
		col2.put("label", "개수");
		
		colsArray.add(col1);
		colsArray.add(col2);
		
		// rows 생성 
		JSONArray rowsArray = new JSONArray(); // rows 
		
		for(Map<String, Object> map : list) {
			
			// {"c":[{"v":"날짜"}, {"v":"수"}]}
			JSONObject date = new JSONObject();
			date.put("v", map.get("REGDATE"));
			
			JSONObject count = new JSONObject();
			count.put("v", map.get("CNT"));
			
			JSONArray row = new JSONArray();
			row.add(date);
			row.add(count);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row); // 레코드 1행 추가 
			
			rowsArray.add(cell);
		} //end for 
		
		// 생성한 cols와 rows을 최종 JSON Object인 data에 담음 
		data.put("cols", colsArray);
		data.put("rows", rowsArray);
		
		return data;
	}
	
	// 기간별 회원 수  
	@SuppressWarnings("unchecked")
	@Override
	public JSONObject getMemberNoByPeriod(String fromDate, String toDate) {
		List<Map<String,Object>> list = mapper.getMemberNoByPeriod(fromDate, toDate);
		
		// 최종적으로 cols와 rows가 담길 JSON Object
		JSONObject data = new JSONObject();
		
		// cols 생성 
		JSONArray colsArray = new JSONArray();
		JSONObject col1 = new JSONObject();
		JSONObject col2 = new JSONObject();
		
		col1.put("type", "string");
		col1.put("label", "등록일");
		
		col2.put("type", "number");
		col2.put("label", "개수");
		
		colsArray.add(col1);
		colsArray.add(col2);
		
		// rows 생성 
		JSONArray rowsArray = new JSONArray(); // rows 
		
		for(Map<String, Object> map : list) {
			
			// {"c":[{"v":"날짜"}, {"v":"수"}]}
			JSONObject date = new JSONObject();
			date.put("v", map.get("REGDATE"));
			
			JSONObject count = new JSONObject();
			count.put("v", map.get("CNT"));
			
			JSONArray row = new JSONArray();
			row.add(date);
			row.add(count);
			
			JSONObject cell = new JSONObject();
			cell.put("c", row); // 레코드 1행 추가 
			
			rowsArray.add(cell);
		} //end for 
		
		// 생성한 cols와 rows을 최종 JSON Object인 data에 담음 
		data.put("cols", colsArray);
		data.put("rows", rowsArray);
		
		return data;
	}
}
