package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload Form");
	}
	
//	Seit.499 파일 저장
	/*
	 * @PostMapping("/uploadFormAction") public void uploadFormPost(MultipartFile[]
	 * uploadFile, Model model) {
	 * 
	 * String uploadFolder ="C:\\upload";
	 * 
	 * for(MultipartFile multipartFile : uploadFile) {
	 * 
	 * log.info("-------------uploadFormPost--------------");
	 * log.info("Upload file Name : "+multipartFile.getOriginalFilename());
	 * log.info("Upload File Size : "+multipartFile.getSize());
	 * 
	 * File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
	 * 
	 * try { multipartFile.transferTo(saveFile); }catch(Exception e) {
	 * log.error(e.getMessage()); } } }
	 */
	
//	Seit.500 Ajax를 이용한 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload Ajax");
	}
	
//	Seit.504 
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxPost(MultipartFile[] uploadFile)
//	(S.724) 로그인 시큐리티 설정
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
			
		log.info("----------upload Ajax Post----------");
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder ="C:\\upload";
		
		String uploadFolderPath = getFolder();
		
//		new Folder Anfang.
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
//		new Folder End.
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			log.info("-------------uploadAjaxPost--------------");
			log.info("Upload file Name : "+multipartFile.getOriginalFilename());
			log.info("Upload File Size : "+multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
//			IE용 경로
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
//substring(uploadFileName.lastIndexOf("\\")+1); = C:\\upload\\banana.png = 'b'부터 모든 문자열 추출.
			
			log.info("only file name : "+uploadFileName);
			attachDTO.setFileName(uploadFileName);
			
//			(Seit.511) UUID : 파일 이름 중복 방지
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			log.info("UUID upload Filename : " + uploadFileName);
			
//			File saveFile = new File(uploadFolder, uploadFileName);			
						
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
//				check image type file
				if(checkImageType(saveFile)) {
					
					attachDTO.setImage(true);
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
//				add to List
				list.add(attachDTO);
				
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
//	(Seit.508) 저장 폴더 갯수 늘리기
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
//	(Seit.513) 이미지 파일 판단하는 메서드(썸네일용)
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
//	(Seit.526) 썸네일 데이터 전송하기 
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		
		log.info("getFile()메서드의 fileName : " + fileName);
		
		File file = new File("c:\\upload\\"+fileName);
		
		log.info("file : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
											header, HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();			
		}
		
		return result;
	}
	
//	(Seit.531) 첨부파일 다운로드 처리
	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
//	public ResponseEntity<Resource> downloadFile(String fileName){
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent,
			String fileName){
		
		log.info("download file : " + fileName);
		
		Resource resource = new FileSystemResource("c:\\upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		log.info("resource file : " + resource);
		
//		(Seit.532) HttpHeaders 객체를 이용한 파일이름 처리
		String resourceName = resource.getFilename();
		
//		(Seit.539) 파일 다운로드시 UUID 제거
		String resourceOriginalName = resourceName.substring(resourceName.lastIndexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		try {
//			(Seit. 534) IE 다운로드 오류 처리
			String downloadName = null;
			
			if(userAgent.contains("Trident")) { // IE브라우저 설정
				
				log.info("IE Browser");
								
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
				
			}else if(userAgent.contains("Edge")) { // Edge브라우저 설정
				
				log.info("Edge Browser");
				
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				
				//log.info("Edge Name : "+downloadName);
				
			}else {  // Chrome 브라우저 설정
				
				log.info("Chrome Browser");
				
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
				log.info("Crome DownloadName : "+ downloadName);
			}
			
			log.info("DownloadName : " + downloadName);
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
//	(Seit.548) 첨부파일 삭제 
	@PreAuthorize("isAuthenticated()") //(S.724) 로그인 시큐리티 설정
	@PostMapping("/deleteFile")
	@ResponseBody	
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		log.info("delete File: " + fileName);
		
		File file;
		
		try {
			
			file = new File("c:\\upload\\"+ URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			if(type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);				
				file.delete();
			}
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
}
