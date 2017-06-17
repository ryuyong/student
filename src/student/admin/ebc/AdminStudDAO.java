package student.admin.ebc;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ModelAttribute;

import student.base.domain.AdminVo;
import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.HakwonVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;

public interface AdminStudDAO {
	
	public AdminVo getAdmin(@ModelAttribute("AdminVo") AdminVo AdminVo) throws DataAccessException;
	
	public List<AnswerVo> getStudAnswerStats(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
	public List<AnswerVo> getStudAnswerSubmitStats(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
	public List<AnswerVo> getStudAnswerWrongStats(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
	public List<AnswerVo> getStudAnswerWrongList(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
	
	public List<HakwonVo> getHakwonList(@ModelAttribute("HakwonVo") HakwonVo hakwonVo) throws DataAccessException;
	public int getHakwonListCnt(@ModelAttribute("HakwonVo") HakwonVo hakwonVo) throws DataAccessException;
	public void insertHakwon(@ModelAttribute("HakwonVo") HakwonVo HakwonVo) throws DataAccessException;
	public void updateHakwon(@ModelAttribute("HakwonVo") HakwonVo hakwonVo) throws DataAccessException;
	public void deleteHakwon(@ModelAttribute("HakwonVo") HakwonVo hakwonVo) throws DataAccessException;
	public String getMaxHakwoncd() throws DataAccessException;
	public HakwonVo getHakwonDetail(@ModelAttribute("HakwonVo") HakwonVo HakwonVo) throws DataAccessException;
	

	public List<StudentVo> getStudentList(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public int getStudentListCnt(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public void insertStudent(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public void updateStudent(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	
	public void updateStudentClinic(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public void deleteStudent(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public String getMaxStudcd() throws DataAccessException;
	public StudentVo getStudentDetail(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public int getStudentStudidCnt(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	
	public List<BbsInfoVo> getBbsInfoList(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	public int getBbsInfoListCnt(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	
	public void insertBbsinfo(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	public void updateBbsinfo(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	public void deleteBbsinfo(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	
	public BbsInfoVo getBbsinfoDetail(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	
	public List<QnaInfoVo> getQnaInfoList(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public int getQnaInfoListCnt(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public void updateQnaInfo(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	
	public void deleteanswer(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
	
	public void deleteanswernodayvalue(@ModelAttribute("AnswerVo") AnswerVo AnswerVo) throws DataAccessException;
}
