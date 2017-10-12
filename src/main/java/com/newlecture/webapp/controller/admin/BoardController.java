package com.newlecture.webapp.controller.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.newlecture.webapp.dao.NoticeDao;
import com.newlecture.webapp.entity.Notice;
import com.newlecture.webapp.entity.NoticeView;


@Controller
@RequestMapping("/admin/board/*")
public class BoardController {
	
	   @Autowired
	   private NoticeDao noticeDao;
	   
	@RequestMapping("notice")
		   public String notice(@RequestParam(value="p", defaultValue="1") Integer page, 
			         @RequestParam(value="f", defaultValue="title") String field,
			         @RequestParam(value="q", defaultValue="") String query,
			         Model model) {
			      
			      List<NoticeView> list = noticeDao.getList(page, field, query);
			      model.addAttribute("list", list);
			      
			      /*String output = String.format("p:%s, q:%s", page, query);
			      output += String.format("title : %s\n", list.get(0).getTitle());
			      */
			      //return "customer/notice";
		return "admin.board.notice.list";
	}
	
	   @RequestMapping("notice/{id}")
	   public String noticeDetail(@PathVariable("id") String id,Model model) {
	      
	      model.addAttribute("n", noticeDao.get(id));
	      model.addAttribute("prev", noticeDao.getPrev(id));
	      model.addAttribute("next", noticeDao.getNext(id));
	      
	      
	      return "admin.board.notice.detail";
	   }
	   
	   @RequestMapping(value="notice/reg", method=RequestMethod.GET)
	   public String noticeReg() {
	      
	      return "admin.board.notice.reg";
	   }
	   
	   @RequestMapping(value="notice/reg", method=RequestMethod.POST)
	   public String noticeReg(Notice notice,MultipartFile file,HttpServletRequest request) throws IOException {
	      
		   //title = new String(title.getBytes("ISO-8859-1"),"UTF-8");  //한글깨짐 방지
		  // System.out.println(title);
		   
		   //Date curDate = new Date(); //날짜 얻는법1
		   
		   Calendar cal = Calendar.getInstance(); //날짜 얻는법2
		  // Date curdate2 = cal.getTime();
		   int year = cal.get(Calendar.YEAR);
		   
		   /*SimpleDateFormat fmt = new SimpleDateFormat("hh:mm:ss"); //날짜 얻는법3
		   fmt.format(arg0);*/
		   String nextId = noticeDao.getNextId();
		   
		   ServletContext ctx = request.getServletContext();
		   String path = ctx.getRealPath(String.format("/resource/customer/notice"+year+"/"+nextId));
		   
		   System.out.println(path);
		   
		   File f = new File(path);
		   
		   if(!f.exists()) {
			   if(!f.mkdirs())
				   System.out.println("디렉토리를 생성할수 없습니다.");
		   }
		   
		   path+= File.separator+file.getOriginalFilename();
		   File f2 = new File(path);
		   
		   InputStream fis = file.getInputStream();
		   OutputStream fos = new FileOutputStream(f2);
		   
		   
		   //file.getInputStream();
		   String fileName = file.getOriginalFilename();
		   System.out.println(fileName);
		   
		   String writerId = "newlec";
		   notice.setWriterId(writerId);
		   //int row = noticeDao.insert(title, content, writerId);
		  int row = noticeDao.insert(notice);
		   
	      return "redirect:../notice";
	   }
	   
}
