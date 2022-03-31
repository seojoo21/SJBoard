package com.seojoo21.mapper;

import java.util.List;

import com.seojoo21.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
//	1. 첨부파일을 등록한다.
	public void insert(BoardAttachVO vo);
//	2. 첨부파일을 삭제한다.
	public void delete(String uuid);
//	3. 특정 게시물의 번호로 첨부파일을 찾는다.
	public List<BoardAttachVO> findByBno (Long bno);
// 	4. 게시물을 삭제하면서 첨부파일도 삭제한다.
	public void deleteAll(Long bno); 
//	5. 전날의 모든 첨부파일 목록을 가져온다. 
	public List<BoardAttachVO> getOldFiles();
}
