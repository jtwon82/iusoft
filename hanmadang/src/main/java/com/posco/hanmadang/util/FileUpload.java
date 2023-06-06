package com.posco.hanmadang.util;

import java.io.File;

import com.posco.hanmadang.common.Constant;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.posco.hanmadang.common.Constant.UploadDirType;

@Component
public class FileUpload {
	@Value("${upload.file.dir}")
	private String WEB_HOME_DIRECTORY;
	@Value("${upload.file.deploy.dir}")
	private String DEPLOY_DIRECTORY;
	
	private Logger logger = Logger.getLogger(getClass());

	private static final char[] ALPHA = "abcdefghijklmnopqrstuvwxyz".toCharArray();
	private static final char[] ALPHANUMERIC = "abcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
	
	public String getHomeDir(){
		return WEB_HOME_DIRECTORY;
	}
	
	public String generateUploadDir() {
        String d1 = RandomStringUtils.random(2, ALPHA);
        String d2 = RandomStringUtils.random(8, ALPHANUMERIC);
        return new StringBuilder().append(d1).append("/").append(d2).toString();
    }
	
	public String generateFilename() {
        String f1 = RandomStringUtils.random(4, ALPHANUMERIC);
        String f2 = Long.toString(System.currentTimeMillis());
        return f1 + f2;
    }
	
//	public void deleteFile(String filePath){
//		File file = new File(WEB_HOME_DIRECTORY + filePath);
//		if(file.exists())
//			file.delete();
//	}
	
	public String uploadFile(MultipartFile file, UploadDirType type) {
		if(type == Constant.UploadDirType.war){
			return uploadWarFile(file, "");
		}
		else {
			return uploadFile(file, type.name() + "/" + generateUploadDir());
		}
	}
	private String uploadWarFile(MultipartFile file, String subDir) {
		return null;
	}

	private String uploadFile(MultipartFile file, String subDir) {
		
		try {
				if(file == null || file.isEmpty())
					return null;
			
				if(file.getOriginalFilename().toLowerCase().endsWith(".jpg") ||
						file.getOriginalFilename().toLowerCase().endsWith(".jpeg") ||
						file.getOriginalFilename().toLowerCase().endsWith(".png") ||
						file.getOriginalFilename().toLowerCase().endsWith(".gif") ||
						file.getOriginalFilename().toLowerCase().endsWith(".bmp")) {
					int pos = file.getOriginalFilename().lastIndexOf( "." );
					String ext = file.getOriginalFilename().substring( pos + 1 );
					
					File newFile = new File(WEB_HOME_DIRECTORY + "/" + subDir  + "/" + generateFilename() + "." + ext );
					
					if (newFile.exists())
						newFile = new File(WEB_HOME_DIRECTORY + "/" + subDir  + "/" + generateFilename() + "." + ext );
				
					FileUtils.writeByteArrayToFile(newFile, file.getBytes());
					
					StringBuilder sb = new StringBuilder("");
					sb.append(subDir);
					sb.append("/");
					sb.append(newFile.getName());
	
					logger.debug("upload File : " + sb);
					
					return sb.toString();
				}else{
					return null;
				}
				
		} catch(Exception e) {
			logger.error(this.getClass().getName(), e);
			return null;
		}
	}
}
