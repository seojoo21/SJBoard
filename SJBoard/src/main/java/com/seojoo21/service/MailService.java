package com.seojoo21.service;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import lombok.Data;

@Service
@Data
public class MailService {
	
	private JavaMailSender mailSender;
	
	public String subject;
	public String content;
	public String from;
	public String to;
	
	public void sendMail() throws Exception {
	
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true ); 
			
			mailSender.send(mail);
			
		}catch(Exception e){
			
			e.printStackTrace();}
	}
}
