package service;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.Forward;

public class FileServiceMM {
	HttpServletRequest request;
	HttpServletResponse response;
	Forward fw = null;
	public FileServiceMM(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	
	 public Forward executefirst() {
	      
	      String uploadPath= "C:/liveproject/java/live/WebContent/img/mainhouse/";
	      int size=10*1024*1024; //10Mb까지
	      String housetype=null;
	      String attendance=null;
	      String address=null;
	      String addressDetail=null;
	      
	      String sysfileName=null;//upload폴더(서버)에 저장된 파일이름
	      String orifileName=null;//원래 파일 이름
	      
	      
	      File forder=new File(uploadPath);
	       if(!forder.exists()) {
	            forder.mkdir();
	            System.out.println("폴더가 생성됌");
	      }
	      
	       
	       try {
	         
	         MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
	         
	         housetype=multi.getParameter("housetype");
	         attendance=multi.getParameter("attendanceNum");
	         address=multi.getParameter("address");
	         addressDetail=multi.getParameter("addressDetail");
	         orifileName=multi.getOriginalFileName("mainpic");
	         sysfileName=multi.getFilesystemName("mainpic");
	         //응닫페이지 출력

	         System.out.println("housetype : " +housetype );
	         System.out.println("attendance : " +attendance );
	         System.out.println("address" +address );
	         System.out.println("addressDetail : " +addressDetail );
	         System.out.println("orifileName : " +orifileName );
	         System.out.println("sysfileName : " +sysfileName );

	         System.out.println("uploadPath : " +uploadPath );
	         
	         
	         request.setAttribute("housetype",housetype);
	         request.setAttribute("attendance",attendance);
	         request.setAttribute("address",address);
	         request.setAttribute("addressDetail",addressDetail);
	         request.setAttribute("orifileName",orifileName);
	         request.setAttribute("sysfileName",sysfileName);
	         
	        
	        
	         int i = -1;
	         i = sysfileName.lastIndexOf("."); // 파일 확장자 위치
	         String realFileName = "ha" + sysfileName.substring(i, sysfileName.length());  //현재시간과 확장자 합치기
	        
	         
	         
	         File oldFile = new File(uploadPath + sysfileName);
	         File newFile = new File(uploadPath + realFileName);
	        
	         
	         System.out.println(realFileName);
	         System.out.println(sysfileName);
	         
	         
	         oldFile.renameTo(newFile); // 파일명 변경

	         
	        
	         
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	      
	     fw = new Forward();
		 fw.setPath("./registHouseDetail.jsp");
		 fw.setRedireact(false);
			return fw;

			
	   }
	 
	 
	 
	 public Forward executesecond() {
	      
	      String uploadPath= "C:/liveproject/java/live/WebContent/img/detailhouse/";
	      int size=10*1024*1024; //10Mb까지
	    
	      String parkarea=null;
	      String roomscnt=null;
	      String bathcnt=null;
	      String bedcnt=null;
	      String toiletcnt = null;
	      String sysfileName=null;//upload폴더(서버)에 저장된 파일이름
	      String orifileName=null;//원래 파일 이름
	      
	      
	      File forder=new File(uploadPath);
	       if(!forder.exists()) {
	            forder.mkdir();
	            System.out.println("폴더가 생성됌");
	      }
	      
	       
	       try {
	         
	         MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
	         
	         parkarea=multi.getParameter("parkarea");
	         roomscnt=multi.getParameter("roomscnt");
	         bathcnt=multi.getParameter("bathcnt");
	         bedcnt=multi.getParameter("bedcnt");
	         toiletcnt=multi.getParameter("toiletcnt");
	         
	        // System.out.println("갯수 : " +test.length);

	         Enumeration files = multi.getFileNames();
	         
	         while(files.hasMoreElements()){        //파일 정보가 있다면
	        	  // 가져오는 파일 정보  함 보자.. ㅋㅋ
	        	 String f_name = (String)files.nextElement();    //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
	        	 String f_filename = multi.getFilesystemName(f_name);   //서버에 저장된 파일 이름
	        	// String f_original = multi.getOriginalFileName(f_name);  //전송전 원래의 파일 이름
	        	 //String f_type = multi.getContentType(f_name);    //전송된 파일의 내용 타입
	        	 System.out.println("?");
	        	 System.out.println("파일 명 : " + f_filename);
	        	 int i = -1;
		         i = f_filename.lastIndexOf("."); // 파일 확장자 위치
	        	 String realFileName = "ha" + f_filename.substring(i, f_filename.length());  //현재시간과 확장자 합치기
	 	        
	        	 File oldFile = new File(uploadPath + f_filename);
		         File newFile = new File(uploadPath + realFileName);
		         oldFile.renameTo(newFile); // 파일명 변경
	        }
		        
	         
	         //응닫페이지 출력

	         System.out.println("parkarea : " +parkarea );
	         System.out.println("roomscnt : " +roomscnt );
	         System.out.println("bathcnt" +bathcnt );
	         System.out.println("bedcnt : " +bedcnt );
	         System.out.println("toiletcnt : " +toiletcnt );
	         
	         System.out.println("orifileName : " +orifileName );
	         System.out.println("sysfileName : " +sysfileName );

	         System.out.println("uploadPath : " +uploadPath );
	         
	         
	         
	         request.setAttribute("parkarea",parkarea);
	         request.setAttribute("roomscnt",roomscnt);
	         request.setAttribute("bathcnt",bathcnt);
	         request.setAttribute("bedcnt",bedcnt);
	         request.setAttribute("toiletcnt",toiletcnt);
	         request.setAttribute("orifileName",orifileName);
	         request.setAttribute("sysfileName",sysfileName);
	         
	        
	        
//	         int i = -1;
//	         i = sysfileName.lastIndexOf("."); // 파일 확장자 위치
//	         String realFileName = "ha" + sysfileName.substring(i, sysfileName.length());  //현재시간과 확장자 합치기
//	        
//	         
//	         
//	         File oldFile = new File(uploadPath + sysfileName);
//	         File newFile = new File(uploadPath + realFileName);
//	        
//	         
//	         System.out.println(realFileName);
//	         System.out.println(sysfileName);
//	         
//	         
//	         oldFile.renameTo(newFile); // 파일명 변경

	         
	        
	         
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	      
	     fw = new Forward();
		 fw.setPath("./registHouseDetail.jsp");
		 fw.setRedireact(false);
			return fw;

			
	   }
	   
	
	
}
