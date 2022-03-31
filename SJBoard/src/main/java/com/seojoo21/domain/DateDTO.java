package com.seojoo21.domain;

import lombok.Data;

//admin 페이지에서 주간 현황을 확인하는데 필요한 값들을 저장 
@Data
public class DateDTO {
	
	// 요일 
	public String monday;
	public String tuesday;
	public String wednesday;
	public String thursday;
	public String friday;
	public String saturday;
	public String sunday;
	
	// 지난주인 경우 7, 이번주인 경우 0
	public int num; 
	
}
