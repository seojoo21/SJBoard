package com.seojoo21.domain;

import lombok.Data;

@Data
public class PageDTO {
	
	// 페이지 번호는 10개씩 나온다. 
	
	private int startPage; // 화면에 출력되는 시작 페이지 번호 
	private int endPage; // 화면에 출력되는 끝 페이지 번호 
	private boolean prev, next; // 이전, 다음 
	private int total; // 전체 데이터 수 
	private Criteria cri; // 페이지 처리에 필요한 페이지 번호(pageNum), 한 페이지당 게시물 수(amount)를 불러옴 
	

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)Math.ceil(cri.getPageNum()/10.0)*10;
		this.startPage = this.endPage - 9;
		
		// 실제 마지막 페이지 번호 = realEnd.
		int realEnd = (int)Math.ceil(total*1.0/cri.getAmount());
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
}
