package com.seojoo21.service;

import java.io.File;

import javax.mail.internet.MimeMessage;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MailServiceTests {
	
	@Autowired
	JavaMailSenderImpl mailSender;
	
	String subject = "test 메일";
	String content = "메일 테스트 내용" + "<img src=\"file:src/main/webapp/resources/img/attach.png\">";
	String from = "seojoo21@naver.com";
	String to = "la_estacion@naver.com";
	
	
	// 4-1. MimeMessage 객체를 직접 생성하여 메일을 발송하는 방법
	@Test
	public void sendMailTest1() throws Exception {
		
		
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");
			
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true ); 
			
			FileSystemResource file = new FileSystemResource(new File("/Users/juyoungkang/Desktop/testdoc.doc"));
			mailHelper.addAttachment("test.doc", file);
			
			mailSender.send(mail);
			
		}catch(Exception e){
			
			e.printStackTrace();
		}
	}
		
	 //4-2. MimeMessagePreparator를 사용하여 메일을 발송하는 방법
	@Test
	public void sendMailTest2() throws Exception{
		
		try {
			final MimeMessagePreparator preparator = new MimeMessagePreparator() {
				
				public void prepare(MimeMessage mimeMessage) throws Exception{
					final MimeMessageHelper mailHelper= new MimeMessageHelper(mimeMessage, true, "UTF-8");
					
					mailHelper.setFrom(from);
					mailHelper.setTo(to);
					mailHelper.setSubject(subject);
					mailHelper.setText(content, true);
				}
			};

			mailSender.send(preparator);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
		
}

