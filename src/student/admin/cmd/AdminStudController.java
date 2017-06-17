package student.admin.cmd;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import student.admin.pbc.AdminStudService;
import student.base.domain.AdminVo;
import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.FileVo;
import student.base.domain.HakwonVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;
import student.base.domain.WeekVo;
import student.base.util.FileMngUtil;
import student.base.util.FileUtil;
import student.base.util.PageUtil;
import student.base.util.PdfMergeUtil;
import student.base.util.StringUtil;
import student.common.pbc.CommonService;
import student.stud.pbc.StudStudService;

@Controller
public class AdminStudController {
	public static Logger logger = Logger.getLogger(AdminStudController.class);
	
	@Autowired
	AdminStudService adminstudService;
	
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	StudStudService studstudService;
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Resource(name="PageUtil")
	private PageUtil pageutil;
	
	@Resource(name="FileUtil")
	private FileUtil fileUtil;
	
	
	@Resource(name="FileMngUtil")
	private FileMngUtil fileMngUtil;
	
	@Resource(name="PdfMergeUtil")
	private PdfMergeUtil pdfMergeUtil;
	/**
	 * 학원리스트 가져오기
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/admin/hakwon_list.do")
	public ModelAndView hakwon_list(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			pageutil.setCurrentPageNo(hakwonVo.getPageIndex());
			pageutil.setPageSize(hakwonVo.getPageSize());
			pageutil.setRecordCountPerPage(hakwonVo.getPageUnit());
			hakwonVo.setFirstIndex(pageutil.getFirstRecordIndex());
			hakwonVo.setLastIndex(pageutil.getLastRecordIndex());
			
			
//			hakwonVo.setHakwon_cd("1");
//			hakwonVo.setHakwon_nm("메가스터디");
//			adminstudService.insertHakwon(hakwonVo);
			int totalcnt = adminstudService.getHakwonListCnt(hakwonVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<HakwonVo> hakwonList = adminstudService.getHakwonList(hakwonVo);
			mav.setViewName("admin");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/admin/hakwon_list.jsp");
			mav.addObject("hakwonList", hakwonList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/hakwon_insert.do")
	public ModelAndView hakwon_insert(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/hakwon_insert.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/hakwon_insertafter.do")
	public ModelAndView hakwon_insertafter(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String hakwon_cd = adminstudService.getMaxHakwoncd();
			hakwonVo.setHakwon_cd(hakwon_cd);
			adminstudService.insertHakwon(hakwonVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/hakwon_list.do");
			mav.addObject("message","학원을 등록하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/hakwon_update.do")
	public ModelAndView hakwon_update(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			HakwonVo result = adminstudService.getHakwonDetail(hakwonVo);
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/admin/hakwon_update.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/hakwon_updateafter.do")
	public ModelAndView hakwon_updateafter(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.updateHakwon(hakwonVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/hakwon_list.do");
			mav.addObject("message","학원을 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/hakwon_deleteafter.do")
	public ModelAndView hakwon_deleteafter(@ModelAttribute("HakwonVo") HakwonVo hakwonVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.deleteHakwon(hakwonVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/hakwon_list.do");
			mav.addObject("message","학원을 삭제하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	
	
	
	
	
	/**
	 * 학원리스트 가져오기
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/admin/student_list.do")
	public ModelAndView student_list(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			pageutil.setCurrentPageNo(studentVo.getPageIndex());
			pageutil.setPageSize(studentVo.getPageSize());
			pageutil.setRecordCountPerPage(studentVo.getPageUnit());
			studentVo.setFirstIndex(pageutil.getFirstRecordIndex());
			studentVo.setLastIndex(pageutil.getLastRecordIndex());
			
			int totalcnt = adminstudService.getStudentListCnt(studentVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<StudentVo> studentList = adminstudService.getStudentList(studentVo);
			mav.setViewName("admin");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/admin/student_list.jsp");
			mav.addObject("studentList", studentList);
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/student_insert.do")
	public ModelAndView student_insert(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/student_insert.jsp");
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/student_insertafter.do")
	public ModelAndView hakwon_insertafter(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			int cnt = adminstudService.getStudentStudidCnt(studentVo);
			if(cnt > 0) {
				String contextPath = request.getContextPath();
				mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
				mav.addObject("message","동일한 ID가 존재합니다.");
				mav.setViewName("/common/alert_message");
				return mav;
			}
			String stud_cd = adminstudService.getMaxStudcd();
			studentVo.setStud_cd(stud_cd);
			adminstudService.insertStudent(studentVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
			mav.addObject("message","학생을 등록하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/student_update.do")
	public ModelAndView student_update(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			StudentVo result = adminstudService.getStudentDetail(studentVo);
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/admin/student_update.jsp");
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/student_updateafter.do")
	public ModelAndView hakwon_updateafter(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String old_stud_id = studentVo.getOld_stud_id();
			String stud_id = studentVo.getStud_id();
			if(!old_stud_id.equals(stud_id)) {
				int cnt = adminstudService.getStudentStudidCnt(studentVo);
				if(cnt > 0) {
					String contextPath = request.getContextPath();
					mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
					mav.addObject("message","동일한 ID가 존재합니다.");
					mav.setViewName("/common/alert_message");
					return mav;
				}
			}
			adminstudService.updateStudent(studentVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
			mav.addObject("message","학생을 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/student_clinicupdate.do")
	public ModelAndView student_clinicupdate(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.updateStudentClinic(studentVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
			mav.addObject("message","클리닉 유형을 일괄 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	@RequestMapping(value="/admin/student_deleteafter.do")
	public ModelAndView student_deleteafter(@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.deleteStudent(studentVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/student_list.do");
			if(studentVo.getUse_yn() !=null && studentVo.getUse_yn().equals("Y")) {
				mav.addObject("message","학생을 탈퇴취소처리하였습니다.");
			} else {
				mav.addObject("message","학생을 탈퇴처리하였습니다.");
			}
			
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	
	/**
	 * 어드민 로그인 화면 표시
	 * @param AdminVo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login/alogin.do")
	public ModelAndView alogin(@ModelAttribute("AdminVo") AdminVo AdminVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("/login/alogin");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	

	
	
	/**
	 * 어드민 로그인 처리
	 * @param adminVo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login/adminlogin.do")
	public ModelAndView adminlogin(@ModelAttribute("AdminVo") AdminVo adminVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//로그인시 세션값 초기화
			request.getSession().invalidate();
			adminVo = adminstudService.getAdmin(adminVo);
			if (adminVo == null)
			{
				mav.addObject("message", "로그인 정보가 올바르지 않습니다.");
				mav.setViewName("/common/alert_message");
				return mav;
			} else {
				/* 로그인정보 및 메뉴 저장 */
				HttpSession session = request.getSession();
				String contextPath = request.getContextPath();
				session.setAttribute("admin", adminVo);
				mav.addObject("redirecturl", contextPath+"/admin/hakwon_list.do");
				mav.setViewName("/common/redirect_location");
			}

		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	/**
	 * 어드민 로그아웃
	 * @param AdminVo
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/alogout.do")
	public void alogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			//로그인시 세션값 초기화
			request.getSession().invalidate();
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/login/alogin.do");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
	}
	
	
	/**
	 * 문제별 정답리스트 표시 
	 * @param answerVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/answer_list.do")
	public ModelAndView answer_list(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			
			//answerVo.setFirstIndex(pageutil.getFirstRecordIndex());
			//answerVo.setLastIndex(pageutil.getLastRecordIndex());
			if(answerVo.getHakneon() == null || answerVo.getHakneon().length() == 0) {
				answerVo.setHakneon("1");
			}
			
			String weekvalue = answerVo.getWeekvalue();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvalues = weekvalue.split(":::::");
				//폴더명
				String foldername = weekvalues[0];
				String week = weekvalues[1];
				answerVo.setWeekval(week);
			}

			if(answerVo.getHakwon_cd() != null && answerVo.getHakwon_cd().length() > 0) {
				List<AnswerVo> answerststsList = adminstudService.getStudAnswerStats(answerVo);
				mav.addObject("answerststsList", answerststsList);
			}
			
			//학원리스트
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			//주차 리스트
			List<WeekVo> weeklist = fileUtil.getWeekList(pdfPath);
			mav.addObject("weeklist", weeklist);
			
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/answer_list.jsp");
			
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	/**
	 * 학생별 제출 리스트
	 * @param answerVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/answersubmit_list.do")
	public ModelAndView answersubmit_list(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			
			if(answerVo.getHakneon() == null || answerVo.getHakneon().length() == 0) {
				answerVo.setHakneon("1");
			}
			
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			
			List<WeekVo> weeklist = fileUtil.getWeekList(pdfPath);
			mav.addObject("weeklist", weeklist);
			
			String weekvalue = answerVo.getWeekvalue();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvalues = weekvalue.split(":::::");
				String foldername = weekvalues[0];
				String week = weekvalues[1];
				answerVo.setWeekval(week);
			}
			if(answerVo.getHakwon_cd() != null && answerVo.getHakwon_cd().length() > 0) {
				List<AnswerVo> answersubmitststsList = adminstudService.getStudAnswerSubmitStats(answerVo);
				mav.addObject("answersubmitststsList", answersubmitststsList);
			}
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/answersubmit_list.jsp");
			
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	/**
	 * 오답노트생성
	 * @param answerVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/wrongnote_make.do")
	public ModelAndView wrongnote_make(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			List<WeekVo> weeklist = fileUtil.getWeekList(pdfPath);
			mav.addObject("weeklist", weeklist);
			
			String weekvalue = answerVo.getWeekvalue();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvalues = weekvalue.split(":::::");
				String foldername = weekvalues[0];
				String week = weekvalues[1];
				answerVo.setWeekval(week);
			}
			String weekvalueto = answerVo.getWeekvalueto();
			if(weekvalueto != null && weekvalueto.length() > 0) {
				String[] weekvalues = weekvalueto.split(":::::");
				String foldername = weekvalues[0];
				String week = weekvalues[1];
				answerVo.setWeekvalto(week);
			}
			if(answerVo.getHakwon_cd() != null && answerVo.getHakwon_cd().length() > 0) {
				List<AnswerVo> answerwrongststsList = adminstudService.getStudAnswerWrongStats(answerVo);
				mav.addObject("answerwrongststsList", answerwrongststsList);
			}
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/wrongnote_make.jsp");
			
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/wrongnote_aftermake.do")
	public ModelAndView wrongnote_aftermake(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			String pdfsavePath = messageSourceAccessor.getMessage("pdf.save.home.dir");
			String pdftempPath = messageSourceAccessor.getMessage("pdf.save.temp.dir");
			String fontfile = messageSourceAccessor.getMessage("pdf.korean.font.file");
			String pdftitlefile = messageSourceAccessor.getMessage("pdf.wrong.title.file");
			String pdfendfile = messageSourceAccessor.getMessage("pdf.clinic.back.file");
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			
			
			List<WeekVo> weeklist = fileUtil.getWeekList(pdfPath);
			mav.addObject("weeklist", weeklist);
			
			String foldername = "";
			String weekvalue = answerVo.getWeekvalue();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvalues = weekvalue.split(":::::");
				foldername = weekvalues[0];
				String week = weekvalues[1];
				answerVo.setWeekval(week);
			}
			
			String foldernameto = "";
			String weekvalueto = answerVo.getWeekvalueto();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvaluetos = weekvalueto.split(":::::");
				foldernameto = weekvaluetos[0];
				String weekto = weekvaluetos[1];
				answerVo.setWeekvalto(weekto);
			}
			
			List<AnswerVo> studAnswerWrongList = adminstudService.getStudAnswerWrongList(answerVo);
			
			String prestud_cd = "";
			String prestud_nm = "";
			String prehakneon = "";
			String savepath = "";
			String contextPath = request.getContextPath();
			List<String> filenames = new ArrayList<String>();
			for(int i=0;i<studAnswerWrongList.size();i++) {
				AnswerVo detail = studAnswerWrongList.get(i);
				String hakwon_nm = detail.getHakwon_nm();
				File folder = new File(pdfsavePath+hakwon_nm);
				if(!folder.exists()) {
					folder.mkdir();
				}
				
				File folder2 = new File(pdfsavePath+hakwon_nm+"/"+answerVo.getWeekval()+"_"+answerVo.getWeekvalto());
				if(!folder2.exists()) {
					folder2.mkdir();
				} else {
					if(i == 0) {
						folder2.delete();
						folder2.mkdir();
					}
					
				}
				
				String stud_cd = detail.getStud_cd();
				String stud_nm = detail.getStud_nm();
				String hakneon = detail.getHakneon();
				
				try {
					fileUtil.getWrongTitlepdf(pdftempPath, pdftitlefile,weekvalue, detail.getStud_cd(),detail.getStud_nm(), fontfile);
				} catch (Exception e) {
					mav.addObject("redirecturl", contextPath+"/admin/wrongnote_make.do");
					mav.addObject("message",pdftitlefile+"파일이 존재하지 않습니다.");
					mav.setViewName("/common/redirect_location");
					return mav;
				}
				
				savepath = pdfsavePath + hakwon_nm + "/"+answerVo.getWeekval()+"_"+answerVo.getWeekvalto()+"/";
				String weeksetval = answerVo.getWeekval() + "~" + answerVo.getWeekvalto() + "주차";
				if(i == 0) {
					//fileUtil.makestudpdfs(pdftempPath+stud_nm+stud_cd+".pdf", stud_nm, weeksetval, fontfile);
					//fileUtil.makeblankpdfs(pdftempPath+"blank.pdf");
					filenames.add(pdftempPath+stud_nm+stud_cd+".pdf");
					//filenames.add(pdftempPath+"blank.pdf");
				} else if(!prestud_cd.equals(stud_cd)) {
					filenames.add(pdfendfile);
					pdfMergeUtil.makepdfmerge(filenames, savepath+prehakneon+"학년_"+prestud_nm+prestud_cd+"의오답노트.pdf");
					filenames = new ArrayList<String>();
					filenames.add(pdftempPath+stud_nm+stud_cd+".pdf");
				}
				String folderrightanswer = fileUtil.getRightAnswer(pdfPath,detail.getHakneon(), detail.getWeekvalue()+"_"+detail.getDayvalue()+"_"+detail.getQuestionvalue());
				System.out.println(pdfPath+":::::"+detail.getWeekvalue()+":::::"+detail.getDayvalue()+":::::"+detail.getQuestionvalue());
				String[] answers = folderrightanswer.split(":::::");
				String setfoldername = answers[0];
				String rightanswer = answers[1];
				filenames.add(pdfPath+setfoldername+"/"+"0" + detail.getHakneon() +"_"+ detail.getWeekvalue()+"_"+detail.getDayvalue()+"_"+detail.getQuestionvalue()+"_"+rightanswer+".pdf");
				if(i == studAnswerWrongList.size()-1) {
					filenames.add(pdfendfile);
					pdfMergeUtil.makepdfmerge(filenames, savepath+hakneon+"학년_"+stud_nm+stud_cd+"의오답노트.pdf");
					filenames = new ArrayList<String>();
				}
				
				prestud_cd = stud_cd;
				prestud_nm = stud_nm;
				prehakneon = hakneon;
			}
			//fileUtil.makepdfmerge(filenames, pdfsavePath+"wrongnote.pdf");
			String print = answerVo.getPrint();

			if(print != null && print.equals("1")) {
				mav.addObject("redirecturl", contextPath+"/admin/wrongnote_make.do?hakwon_cd="+answerVo.getHakwon_cd()+"&hakneon="+answerVo.getHakneon()+"&weekvalue="+answerVo.getWeekvalue()+"&weekvalueto="+answerVo.getWeekvalueto()+"&print=1&file_nm="+pdfsavePath+"wrongnote.pdf");
			} else {
				mav.addObject("redirecturl", contextPath+"/admin/wrongnote_make.do?hakwon_cd="+answerVo.getHakwon_cd()+"&hakneon="+answerVo.getHakneon()+"&weekvalue="+answerVo.getWeekvalue()+"&weekvalueto="+answerVo.getWeekvalueto());
				mav.addObject("message",savepath+"폴더에 오답노트를 생성하였습니다.");
			}
			
			mav.setViewName("/common/redirect_location");
			//mav.setViewName("admin");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	
	/**
	 * 오답노트생성
	 * @param answerVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/clinic_make.do")
	public ModelAndView clinic_make(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			String clinicpdfPath = messageSourceAccessor.getMessage("pdf.clinic.home.dir");
			String titlepdfPath = messageSourceAccessor.getMessage("pdf.title.home.dir");
			List<String> weeklist = fileUtil.getClinicWeekList(clinicpdfPath);
			List<String> titlelist = fileUtil.getClinicTitleList(titlepdfPath);
			mav.addObject("weeklist", weeklist);
			mav.addObject("titlelist", titlelist);
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/clinic_make.jsp");
			
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	/**
	 * 학원에 대한 학생리스트 가져오기
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/stud_selectlist.do")
	public ModelAndView stud_selectlist(@ModelAttribute("StudentVo") StudentVo studentVo, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("/common/resultMessage");
			List<StudentVo> studlist = commonService.getHakwonStudList(studentVo);
			String responseMsg = "";
			String stud_cd = studentVo.getStud_cd();
			if(studlist != null && studlist.size() > 0) {
				responseMsg = "<option value=''>선택</option>";
				for(int i=0;i<studlist.size();i++) {
					StudentVo detail = studlist.get(i);
					//String selected = "";
					
					if(stud_cd != null && stud_cd.equals(detail.getStud_cd())) {
						responseMsg += "<option value='"+detail.getStud_cd()+"' selected>"+detail.getStud_id()+":"+detail.getStud_nm()+"</option>";
					} else {
						responseMsg += "<option value='"+detail.getStud_cd()+"'>"+detail.getStud_id()+":"+detail.getStud_nm()+"</option>";
					}
				}
//				responseMsg += "</select>";
			}
			mav.addObject("responseMsg",responseMsg);
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/clinic_aftermake.do")
	public ModelAndView clinic_aftermake(@ModelAttribute("AnswerVo") AnswerVo answerVo,@ModelAttribute("StudentVo") StudentVo studentVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String pdfclinictitle = messageSourceAccessor.getMessage("pdf.title.home.dir") + answerVo.getTitlevalue();
			String pdfclinicback = messageSourceAccessor.getMessage("pdf.clinic.back.file");
			String pdfclinicPath = messageSourceAccessor.getMessage("pdf.clinic.home.dir");
			String pdfclinicsavePath = messageSourceAccessor.getMessage("pdf.clinicsave.home.dir");
			String pdftempsavePath = messageSourceAccessor.getMessage("pdf.save.temp.dir");
			String font = messageSourceAccessor.getMessage("pdf.korean.font.file");
			
			String contextPath = request.getContextPath();
			String hakwon_nm = commonService.getHakwonNm(answerVo.getHakwon_cd());
			String stud_cd = answerVo.getStud_cd();
			String weekvalue = answerVo.getWeekvalue();
			List<StudentVo> studentlist;
			if(stud_cd == null || stud_cd.length() == 0) {
				studentVo.setFirstIndex(0);
				studentVo.setLastIndex(100000);
				studentlist = adminstudService.getStudentList(studentVo);
			} else {
				studentlist = new ArrayList<StudentVo>();
				StudentVo param = adminstudService.getStudentDetail(studentVo);
				studentlist.add(param);
			}

			//String stud_nm = commonService.getStudNm(answerVo.getStud_cd());
			//String redirect = answerVo.getRedirect();
			String path = pdfclinicsavePath+hakwon_nm;
			
			File folder = new File(path);
			if(!folder.exists()) {
				folder.mkdir();
			}
			String resultvalue = "";
			String today = StringUtil.getToday();
			if(studentlist != null && studentlist.size() > 0) {
				for(int i=0;i<studentlist.size();i++) {
					StudentVo detail = studentlist.get(i);
					List<String> filenames = new ArrayList<String>();
					try {
						fileUtil.getClinicTitlepdf(pdftempsavePath, pdfclinictitle,weekvalue, detail.getStud_cd(),detail.getStud_nm(), font);
					} catch (Exception e) {
						mav.addObject("redirecturl", contextPath+"/admin/clinic_make.do");
						mav.addObject("message",pdfclinictitle+"파일이 존재하지 않습니다.");
						mav.setViewName("/common/redirect_location");
						return mav;
					}
					
					filenames.add(pdftempsavePath+"/"+detail.getStud_nm()+detail.getStud_cd()+".pdf");
					String clinictype = answerVo.getClinictype();
					if(clinictype == null || clinictype.length() == 0) {
						clinictype = detail.getClinictype();
					}
					if(clinictype != null && clinictype.length() > 0) {
						for(int j=0;j<clinictype.length();j++) {
							String fileindex = clinictype.substring(j,j+1)+"_"+weekvalue+"_";
							if(j < 9) {
								fileindex = fileindex+"0"+(j+1);
							} else {
								fileindex = fileindex + (j+1);
							}
							File tempfile = new File(pdfclinicPath+fileindex+".pdf");
							if(!tempfile.exists()) {
								mav.addObject("redirecturl", contextPath+"/admin/clinic_make.do");
								mav.addObject("message",pdfclinicPath+fileindex+".pdf파일이 존재하지 않습니다.");
								mav.setViewName("/common/redirect_location");
								return mav;
							}
							filenames.add(pdfclinicPath+fileindex+".pdf");
						}
						filenames.add(pdfclinicback);
						pdfMergeUtil.makepdfmerge(filenames, path+"/"+weekvalue+"주차_"+detail.getStud_nm()+clinictype+"_"+today+"_"+detail.getStud_cd()+".pdf");
					} else {
						resultvalue += detail.getStud_nm()+":";
					}
				}
				
			}
			/*
			if(redirect == null || !redirect.equals("Y")) {
				String day = fileUtil.getExistClinicFile(path,clinictype);
				if(day.length() > 0) {
					mav.setViewName("/common/redirect_confirmlocation");
					mav.addObject("redirecturlok", contextPath+"/admin/clinic_make.do?hakwon_cd="+answerVo.getHakwon_cd()+"&stud_cd="+answerVo.getStud_cd()+"&clinictype="+clinictype+"&redirect=Y");
					mav.addObject("redirecturlno", contextPath+"/admin/clinic_make.do?hakwon_cd="+answerVo.getHakwon_cd()+"&stud_cd="+answerVo.getStud_cd()+"&clinictype="+clinictype);
					mav.addObject("message",day+"날에 생성한 파일이 존재합니다.그래도 파일을 생성 하시겠습니까? ");
					return mav;
				}
			}*/
			/*
			File folder2 = new File(pdfclinicsavePath+hakwon_nm+"/"+stud_nm+answerVo.getStud_cd());
			if(!folder2.exists()) {
				folder2.mkdir();
			}*/
			//mav.addObject("redirecturl", contextPath+"/admin/clinic_make.do?hakwon_cd="+answerVo.getHakwon_cd()+"&weekvalue="+answerVo.getWeekvalue()+"&stud_cd="+answerVo.getStud_cd());
			mav.addObject("redirecturl", contextPath+"/admin/clinic_make.do");
			if(resultvalue.length() > 0) {
				mav.addObject("message",path+" 폴더에 클리닉을 생성하였습니다. "+resultvalue+" 학생은 클리닉 유형이 없어서 파일 생성 안함.");
			} else {
				mav.addObject("message",path+" 폴더에 클리닉을 생성하였습니다.");
			}
			
			
			mav.setViewName("/common/redirect_location");
			//mav.setViewName("admin");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="/admin/bbs_list.do")
	public ModelAndView bbs_list(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			pageutil.setCurrentPageNo(bbsInfoVo.getPageIndex());
			pageutil.setPageSize(bbsInfoVo.getPageSize());
			pageutil.setRecordCountPerPage(bbsInfoVo.getPageUnit());
			bbsInfoVo.setFirstIndex(pageutil.getFirstRecordIndex());
			bbsInfoVo.setLastIndex(pageutil.getLastRecordIndex());
			
			int totalcnt = adminstudService.getBbsInfoListCnt(bbsInfoVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<BbsInfoVo> bbsList = adminstudService.getBbsInfoList(bbsInfoVo);
			mav.setViewName("admin");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/admin/bbs_list.jsp");
			mav.addObject("bbsList", bbsList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/bbs_insert.do")
	public ModelAndView bbs_insert(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			mav.addObject("pageUrl", "/WEB-INF/view/admin/bbs_insert.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/bbs_insertafter.do")
	public ModelAndView bbs_insertafter(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,MultipartHttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			final Map<String, MultipartFile> files = request.getFileMap();
			
			String storedPath = messageSourceAccessor.getMessage("upload.sys.home.dir");
			
	    	// 첨부파일 관련 첨부파일ID 생성
			FileVo _result = null;
			String file_id = "";
			if(!files.isEmpty()){
				SortedMap<String,MultipartFile> files1 = new TreeMap<String,MultipartFile>();
				files1.putAll(files);
				_result = fileMngUtil.parseFileInf(files1, "STUD_", 1, storedPath);
				if(_result != null && _result.getFile_nm() != null && _result.getFile_nm().length() > 0) {
					file_id = commonService.getMaxFileId();
					_result.setFile_id(file_id);
					commonService.insertFileInf(_result);
				}
			}
			
			String bbs_id = commonService.getMaxBbsId();
			bbsInfoVo.setBbs_id(bbs_id);
			bbsInfoVo.setFile_id(file_id);
			adminstudService.insertBbsinfo(bbsInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/bbs_list.do");
			mav.addObject("message","공지사항을 등록하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/bbs_update.do")
	public ModelAndView bbs_update(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			BbsInfoVo result = adminstudService.getBbsinfoDetail(bbsInfoVo);
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/admin/bbs_update.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/bbs_updateafter.do")
	public ModelAndView bbs_updateafter(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,MultipartHttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			
			final Map<String, MultipartFile> files = request.getFileMap();
			
			String storedPath = messageSourceAccessor.getMessage("upload.sys.home.dir");
			
	    	// 첨부파일 관련 첨부파일ID 생성
			FileVo _result = null;
			String file_id = "";
			if(!files.isEmpty()){
				SortedMap<String,MultipartFile> files1 = new TreeMap<String,MultipartFile>();
				files1.putAll(files);
				_result = fileMngUtil.parseFileInf(files1, "STUD_", 1, storedPath);
				if(_result != null && _result.getFile_nm() != null && _result.getFile_nm().length() > 0) {
					file_id = commonService.getMaxFileId();
					_result.setFile_id(file_id);
					commonService.insertFileInf(_result);
				}
			}
			bbsInfoVo.setFile_id(file_id);
			adminstudService.updateBbsinfo(bbsInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/bbs_list.do");
			mav.addObject("message","공지사항을 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/bbs_deleteafter.do")
	public ModelAndView bbs_deleteafter(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.deleteBbsinfo(bbsInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/bbs_list.do");
			mav.addObject("message","공지사항을 삭제하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/qna_list.do")
	public ModelAndView qna_list(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			pageutil.setCurrentPageNo(qnaInfoVo.getPageIndex());
			pageutil.setPageSize(qnaInfoVo.getPageSize());
			pageutil.setRecordCountPerPage(qnaInfoVo.getPageUnit());
			qnaInfoVo.setFirstIndex(pageutil.getFirstRecordIndex());
			qnaInfoVo.setLastIndex(pageutil.getLastRecordIndex());
			
			int totalcnt = adminstudService.getQnaInfoListCnt(qnaInfoVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<QnaInfoVo> qnaList = adminstudService.getQnaInfoList(qnaInfoVo);
			mav.setViewName("admin");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/admin/qna_list.jsp");
			mav.addObject("qnaList", qnaList);
			
			List<HakwonVo> hakwonList = commonService.getHakwonList(new HakwonVo());
			mav.addObject("hakwonList", hakwonList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/qna_detail.do")
	public ModelAndView qna_detail(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("admin");
			QnaInfoVo result = studstudService.getDetailQnaInfo(qnaInfoVo);
			//result.setQna_content(result.getQna_content().trim());
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/admin/qna_detail.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/qna_updateafter.do")
	public ModelAndView qna_updateafter(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			
			adminstudService.updateQnaInfo(qnaInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/qna_list.do?searchKeyword="+qnaInfoVo.getSearchKeyword()+"&searchKeyword1="+qnaInfoVo.getSearchKeyword1()+"&pageIndex="+qnaInfoVo.getPageIndex()+"&hakwon_cd="+qnaInfoVo.getHakwon_cd()+"&search_qna_answer_state="+qnaInfoVo.getSearch_qna_answer_state());
			mav.addObject("message","Q&A를 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/admin/qna_deleteafter.do")
	public ModelAndView qna_deleteafter(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			studstudService.deleteQnaInfo(qnaInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/qna_list.do");
			mav.addObject("message","Q&A를 삭제하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/admin/deleteanswer.do")
	public ModelAndView deleteanswer(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.deleteanswer(answerVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/answersubmit_list.do");
			mav.addObject("message","제출한 답안를 삭제하였습니다.");
			mav.setViewName("/common/redirect_location");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	@RequestMapping(value="/admin/deleteanswernodayvalue.do")
	public ModelAndView deleteanswernodayvalue(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			adminstudService.deleteanswernodayvalue(answerVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/admin/wrongnote_make.do");
			mav.addObject("message","오답노트생성 오류 처리를 완료하였습니다.");
			mav.setViewName("/common/redirect_location");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}

	
}
