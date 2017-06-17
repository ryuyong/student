package student.stud.cmd;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import student.admin.pbc.AdminStudService;
import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.HakwonVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;
import student.base.domain.WeekVo;
import student.base.util.FileUtil;
import student.base.util.PageUtil;
import student.common.pbc.CommonService;
import student.stud.pbc.StudStudService;

@Controller
public class StudStudController {
	public static Logger logger = Logger.getLogger(StudStudController.class);
	
	@Autowired
	StudStudService studstudService;
	
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	AdminStudService adminstudService;
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Resource(name="PageUtil")
	private PageUtil pageutil;
	
	@Resource(name="FileUtil")
	private FileUtil fileUtil;
	
	/**
	 * 학생용 로그인 화면 표시
	 * @param hakwonVo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login/slogin.do")
	public ModelAndView slogin(@ModelAttribute("HakwonVo") HakwonVo hakwonVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//List<HakwonVo> hakwonList = commonService.getHakwonList(hakwonVo);
			//mav.addObject("hakwonList", hakwonList);
			mav.setViewName("/login/slogin");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	/**
	 * 학생용 로그인 처리
	 * @param studentVo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login/studlogin.do")
	public ModelAndView studlogin(@ModelAttribute("StudentVo") StudentVo studentVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//로그인시 세션값 초기화
			request.getSession().invalidate();
			String hakwon_cd = commonService.getHakwonCd(studentVo);
			if(hakwon_cd != null && hakwon_cd.length() > 0) {
				studentVo.setHakwon_cd(hakwon_cd);
			} else {
				hakwon_cd = "";
			}
			studentVo = studstudService.getStudent(studentVo);
			if (studentVo == null)
			{
				mav.addObject("message", "로그인 정보가 올바르지 않습니다.");
				mav.setViewName("/common/alert_message");
				return mav;
			} else {
				/* 로그인정보 및 메뉴 저장 */
				HttpSession session = request.getSession();
				String contextPath = request.getContextPath();
				session.setAttribute("stud", studentVo);
				//mav.addObject("redirecturl", contextPath+"/stud/question_list.do");
				//mav.setViewName("/common/redirect_location");
				mav.addObject("redirecturl", contextPath+"/login/slogin.do");
				mav.setViewName("/common/redirect_location");
			}

		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	/**
	 * 학생용 로그아웃 처리
	 * @param AdminVo
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/slogout.do")
	public void alogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			//로그인시 세션값 초기화
			request.getSession().invalidate();
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/login/slogin.do");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
	}
	
	/**
	 * 주차에 대한 일차 리스트  Ajax
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/stud/day_list.do")
	public ModelAndView day_list(@ModelAttribute("AnswerVo") AnswerVo answerVo, HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			HttpSession session = request.getSession(false);
			StudentVo memberVo = (StudentVo)session.getAttribute("stud");
			
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			
			mav.setViewName("/common/resultMessage");
			String weekvalue = answerVo.getWeekvalue();
			String[] weekvalues = weekvalue.split(":::::");
			String foldername = weekvalues[0];//폴더명 01_04
			String week = weekvalues[1];//주차 01주차 02주차
			String hakneon = "";
			if(memberVo != null) {
				hakneon = memberVo.getHakneon();
			} else {
				//admin의 경우
				hakneon = answerVo.getHakneon();
			}
			 
			
			List<String> daylist = fileUtil.getDaylist(pdfPath+"/"+foldername, hakneon, week);
			Collections.sort(daylist);
			String responseMsg = "";
			if(daylist != null && daylist.size() > 0) {
				responseMsg = "<option value=''>선택</option>";
				for(int i=0;i<daylist.size();i++) {
					//String selected = "";
					String dayvalue = answerVo.getDayvalue();
					if(dayvalue != null && dayvalue.equals(daylist.get(i))) {
						responseMsg += "<option value='"+daylist.get(i)+"' selected>"+daylist.get(i)+"</option>";
					} else {
						responseMsg += "<option value='"+daylist.get(i)+"'>"+daylist.get(i)+"</option>";
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
	
	/**
	 * 학생용 답변화면 보여주기
	 * @param answerVo
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/stud/question_list.do")
	public ModelAndView question_list(@ModelAttribute("AnswerVo") AnswerVo answerVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			
			List<WeekVo> weeklist = fileUtil.getWeekList(pdfPath);
			mav.addObject("weeklist", weeklist);
			
			String weekvalue = answerVo.getWeekvalue();
			String dayvalue = answerVo.getDayvalue();
			if(weekvalue != null && weekvalue.length() > 0) {
				String[] weekvalues = weekvalue.split(":::::");
				String foldername = weekvalues[0];
				String week = weekvalues[1];
				
				answerVo.setWeekval(week);
				HttpSession session = request.getSession();
				StudentVo memberVo = (StudentVo)session.getAttribute("stud");
				answerVo.setStud_cd(memberVo.getStud_cd());
				
				//질문리스트
				String hakneon = memberVo.getHakneon();
				
				//학생의 답변리스트
				List<AnswerVo> answerlist = studstudService.getStudAnswer(answerVo);
				if(answerlist != null && answerlist.size() > 0) {
					for(int i=0;i<answerlist.size();i++) {
						AnswerVo deatil = answerlist.get(i);
						//String setweekvalue = deatil.getWeekvalue();
						//String setdayvalue = deatil.getDayvalue();
						//String setquestionvalue = deatil.getQuestionvalue();
						
						String folderrightanswer = fileUtil.getRightAnswer(pdfPath, hakneon, deatil.getWeekvalue()+"_"+deatil.getDayvalue()+"_"+deatil.getQuestionvalue());
						String[] answers = folderrightanswer.split(":::::");
						String setfoldername = answers[0];
						String rightanswer = answers[1];
						deatil.setRightanswer(rightanswer);
					}
				}
				mav.addObject("answerlist", answerlist);
				

				List<String> questionlist = fileUtil.getQuestionlist(pdfPath+"/"+foldername,hakneon,week,dayvalue);
				mav.addObject("questionlist", questionlist);
			}
			mav.setViewName("stud");
			mav.addObject("pageUrl", "/WEB-INF/view/stud/question_list.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	/**
	 * 학생 답안 제출
	 * @param answerVo
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/stud/answer_insert.do")
	public ModelAndView answer_insert(@ModelAttribute("AnswerVo") AnswerVo answerVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			HttpSession session = request.getSession();
			StudentVo memberVo = (StudentVo)session.getAttribute("stud");
			answerVo.setStud_cd(memberVo.getStud_cd());
			String pdfPath = messageSourceAccessor.getMessage("pdf.sys.home.dir");
			String weekval = answerVo.getWeekval();
			if(weekval != null && weekval.length() > 0) {
				String[] weekvals = weekval.split(":::::");
				String foldername = weekvals[0];
				String week = weekvals[1];
				answerVo.setWeekvalue(week);
				String hakneon = memberVo.getHakneon();
				studstudService.insertAnswer(pdfPath+foldername, hakneon, answerVo);
			}
			
			mav.addObject("message","답변을 등록하였습니다.");
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/stud/question_list.do?weekvalue="+weekval+"&dayvalue="+answerVo.getDayval());
			mav.setViewName("/common/redirect_location");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/stud/bbs_list.do")
	public ModelAndView bbs_list(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			HttpSession session = request.getSession();
			StudentVo memberVo = (StudentVo)session.getAttribute("stud");
			String hakneon = memberVo.getHakneon();
			
			pageutil.setCurrentPageNo(bbsInfoVo.getPageIndex());
			pageutil.setPageSize(bbsInfoVo.getPageSize());
			pageutil.setRecordCountPerPage(bbsInfoVo.getPageUnit());
			bbsInfoVo.setFirstIndex(pageutil.getFirstRecordIndex());
			bbsInfoVo.setLastIndex(pageutil.getLastRecordIndex());
			bbsInfoVo.setHakneon(hakneon);
			int totalcnt = studstudService.getBbsInfoListCnt(bbsInfoVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<BbsInfoVo> bbsList = studstudService.getBbsInfoList(bbsInfoVo);
			mav.setViewName("stud");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/stud/bbs_list.jsp");
			mav.addObject("bbsList", bbsList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/stud/bbs_detail.do")
	public ModelAndView bbs_detail(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("stud");
			BbsInfoVo result = adminstudService.getBbsinfoDetail(bbsInfoVo);
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/stud/bbs_detail.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/stud/qna_list.do")
	public ModelAndView qna_list(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			pageutil.setCurrentPageNo(qnaInfoVo.getPageIndex());
			pageutil.setPageSize(qnaInfoVo.getPageSize());
			pageutil.setRecordCountPerPage(qnaInfoVo.getPageUnit());
			qnaInfoVo.setFirstIndex(pageutil.getFirstRecordIndex());
			qnaInfoVo.setLastIndex(pageutil.getLastRecordIndex());
			HttpSession session = request.getSession();
			StudentVo memberVo = (StudentVo)session.getAttribute("stud");
			qnaInfoVo.setStud_cd(memberVo.getStud_cd());
			
			int totalcnt = studstudService.getQnaInfoListCnt(qnaInfoVo);
			pageutil.setTotalRecordCount(totalcnt);
			
			List<QnaInfoVo> qnaList = studstudService.getQnaInfoList(qnaInfoVo);
			mav.setViewName("stud");
			mav.addObject("pageUtil",pageutil.getPaging());
			mav.addObject("pageUrl", "/WEB-INF/view/stud/qna_list.jsp");
			mav.addObject("qnaList", qnaList);
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	@RequestMapping(value="/stud/qna_insert.do")
	public ModelAndView qna_insert(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("stud");
			mav.addObject("pageUrl", "/WEB-INF/view/stud/qna_insert.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/stud/qna_insertafter.do")
	public ModelAndView qna_insertafter(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			String qna_cd = commonService.getMaxQnaCd();
			qnaInfoVo.setQna_cd(qna_cd);
			qnaInfoVo.setQna_answer_state("N");
			HttpSession session = request.getSession();
			StudentVo memberVo = (StudentVo)session.getAttribute("stud");
			qnaInfoVo.setStud_cd(memberVo.getStud_cd());
			
			studstudService.insertQnaInfo(qnaInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/stud/qna_list.do");
			mav.addObject("message","Q&A를 등록하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/stud/qna_detail.do")
	public ModelAndView qna_detail(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("stud");
			QnaInfoVo result = studstudService.getDetailQnaInfo(qnaInfoVo);
			//result.setQna_content(result.getQna_content().trim());
			mav.addObject("result",result );
			mav.addObject("pageUrl", "/WEB-INF/view/stud/qna_detail.jsp");
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	@RequestMapping(value="/stud/qna_updateafter.do")
	public ModelAndView qna_updateafter(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			studstudService.updateQnaInfo(qnaInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/stud/qna_list.do?searchKeyword="+qnaInfoVo.getSearchKeyword()+"&searchKeyword1="+qnaInfoVo.getSearchKeyword1()+"&pageIndex="+qnaInfoVo.getPageIndex());
			mav.addObject("message","Q&A를 수정하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
	
	
	
	@RequestMapping(value="/stud/qna_deleteafter.do")
	public ModelAndView qna_deleteafter(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo,HttpServletRequest request) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			studstudService.deleteQnaInfo(qnaInfoVo);
			String contextPath = request.getContextPath();
			mav.addObject("redirecturl", contextPath+"/stud/qna_list.do?searchKeyword="+qnaInfoVo.getSearchKeyword()+"&pageIndex="+qnaInfoVo.getPageIndex());
			mav.addObject("message","Q&A를 삭제하였습니다.");
			mav.setViewName("/common/redirect_location");
			
		} catch(Exception e) {
			logger.error(e);
			throw e;
		}
		return mav;
	}
}
