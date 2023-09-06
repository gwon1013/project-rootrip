package com.rootrip.rootripteam.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

public class FTPConnect {
	static FTPClient client;
	
	private FTPConnect() {
	}
	
	static public void connect() throws Exception {
		client = new FTPClient();
		client.setControlEncoding("UTF-8");
		client.connect("192.168.0.159", 908);
		
		int resultCode = client.getReplyCode();
		
		if(!FTPReply.isPositiveCompletion(resultCode)) {
			System.out.println("FTP 서버와 통신 실패");
			throw new Exception("연결 실패");
		}
		else {
			client.setSoTimeout(1000);//파일 전송 간 딜레이 (1초)
			if(!client.login("rootrip", "0908")) {
				throw new Exception("로그인 실패");
			}
		}
	}
	
	static public void upload(File file) throws Exception {
		FileInputStream fi = new FileInputStream(file);
		client.setFileType(FTP.BINARY_FILE_TYPE);
		client.storeFile("지역사진/"+file.getName(), fi);
		
		client.logout();
		if(client.isConnected()) {
			client.disconnect();
		}
	}
	
	static public void download(String imageName) throws IOException {
		client.setFileType(FTP.BINARY_FILE_TYPE);
		/*
		 * FileOutputStream에는 이미지 파일을 저장할 경로 + 파일 이름이 들어가야 합니다.
		 * 다만 이클립스와 git을 연동하는 과정에서 프로젝트 폴더가 git 로컬 저장소로 옮겨지면서
		 * java의 경로를 확인하는 방법과 실제 저장되는 경로가 달라지게 되었습니다.
		 * 일단 모든 PC의 사용자 명이 같아 경로를 직접 입력 하였습니다.
		 * 지역 이미지 다운로드에 실패하는 경우 해당 경로를 수정해야 합니다.
		 * (현재 프로젝트 폴더를 확인하는 코드로는 System.getProperty("user.dir") 입니다.
		 * 이후 경로를 별도로 적어야 합니다.
		 */
		FileOutputStream fo = new FileOutputStream("C:\\Users\\sdedu\\git\\project-rootrip\\Project_Rootrip\\src\\main\\webapp\\resources\\img\\지역사진\\"+imageName);
		client.retrieveFile("지역사진/"+imageName, fo);
	}

}
