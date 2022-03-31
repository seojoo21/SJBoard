package com.seojoo21.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.seojoo21.domain.AttachFileDTO;
import com.seojoo21.domain.BoardAttachVO;
import com.seojoo21.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_= {@Autowired})
	private BoardAttachMapper attachMapper;
	
	// 전날의 폴더를 구한다.  
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	// 매일 새벽 2시 서버 내 파일 삭제를 위한 checkFiles() 메서드를 실행한다. 
	@Scheduled(cron = "0 10 1 * * *") 
	public void checkFiles() throws Exception{
		log.warn("파일 체크 작업 진행 ");
		log.warn("날짜:" + new Date());
		
		// 파일 업로드 경로  
		String uploadFolder = new AttachFileDTO().uploadFolder;
//		String uploadFolder = "/Users/juyoungkang/Desktop/Back-End Project/Project1_SJBoard/board_upload/";
		
		// 데이터베이스에서 어제 날짜로 보관되는 모든 첨부파일의 목록을 가져온다. 
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		// 데이터베이스에서 가져온 파일 목록은 BoardAttachVO 타입의 객체이므로, 나중에 비교를 위해서 java.nio.Paths의 목록으로 변환한다. 
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		
		// 이때 이미지 파일의 경우에는 섬네일 파일도 목록에 필요하기 때문에 별도로 처리해서 해당 일의 예상 파일 목록을 완성한다.
		fileList.stream().filter(vo -> vo.isFileType() == true)
		.map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
		.forEach(p -> fileListPaths.add(p));
		
		log.warn("==================================");
		
		fileListPaths.forEach(p -> log.warn("path:" + p));
		
		File targetDir = Paths.get(uploadFolder, getFolderYesterDay()).toFile();
		
		// 데이터베이스에 있는 파일들의 준비가 끝나면 실제 폴더에 있는 파일들의 목록에서 데이터베이스에는 없는 파일들을 찾아서 목록으로 준비한다. 
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("-----------------------------------");
		
		
		// 최종적으로는 삭제 대상이 되는 파일들을 삭제한다. 
		for (File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
	}
	

}
