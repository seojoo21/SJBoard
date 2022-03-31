package com.seojoo21.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	
	// 1. 페이징 처리 
	private int pageNum; // 페이지 번호 
	private int amount; // 페이지당 가져올 게시물 
	
	public Criteria() {
		this(1,10); //기본값 1페이지, 페이지당 게시물 10개 
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//2. 검색 처리 
	private String type; // 검색 조건:: T:제목(title), W:작성자(writer), C:내용(content)
	private String keyword; // 검색 키워드 
	
	//검색 조건을 배열로 만들어서 한번에 처리한다.
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
	}
	
	//3. 게시물 수정, 삭제 redirect 시 필요한 페이지 처리 및 검색 조건 파라미터 (pageNum, amount, Type, Keyword) 처리 메서드
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	
	
}
