package com.posco.hanmadang.controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.posco.hanmadang.common.Constant.UploadDirType;
import com.posco.hanmadang.util.FileUpload;

@Controller
@RequestMapping("/rhksfl/vhtmzh/file")
public class FormEditController {

	private Logger logger = Logger.getLogger(getClass());

	@Autowired
	FileUpload fileUpload;

	/**
     * 이미지 업로드
     * @param request
     * @param response
     * @param upload
     */
    @RequestMapping(value = "/upload/image", method = RequestMethod.POST)
    public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, 
    		@RequestParam(value="upload", required=false) MultipartFile upload) {
 
        PrintWriter printWriter = null;
        response.setContentType("text/html; charset=UTF-8");
 
        try{
        	if(upload != null && !upload.isEmpty()){
				String uploadedFilePath = fileUpload.uploadFile(upload, UploadDirType.editor);
				if(!StringUtils.isEmpty(uploadedFilePath)) {
		            String callback = request.getParameter("CKEditorFuncNum");
		            callback = callback.replaceAll("<","&lt;");
		            callback = callback.replaceAll(">","&gt;");
		            
		            printWriter = response.getWriter();
		            String fileUrl = "/upload/" + uploadedFilePath;//url경로
		 
		            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
		                    + callback
		                    + ",'"
		                    + fileUrl
		                    + "','이미지를 업로드 하였습니다.'"
		                    + ")</script>");
		            printWriter.flush();
				}else {
					printWriter = response.getWriter();
					printWriter.println("<script type='text/javascript'>\\nalert('허용되지 않은 파일 유형입니다.');\\n</script>");
		            printWriter.flush();
				}
        	}
 
        }catch(IOException e){
        	logger.error(e.getMessage());
        } finally {
            if (printWriter != null)
                printWriter.close();
        }
 
        return;
    }
	
}
