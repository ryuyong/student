package student.admin.pbc;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ModelAttribute;

import student.base.domain.AdminVo;
import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.HakwonVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;

public interface AdminStudService {
	public AdminVo getAdmin(AdminVo AdminVo);
	public List<AnswerVo> getStudAnswerStats(AnswerVo AnswerVo);
	public List<AnswerVo> getStudAnswerSubmitStats(AnswerVo AnswerVo);
	public List<AnswerVo> getStudAnswerWrongStats(AnswerVo AnswerVo);
	public List<AnswerVo> getStudAnswerWrongList(AnswerVo AnswerVo);
	
	public List<HakwonVo> getHakwonList(HakwonVo hakwonVo);
	public int getHakwonListCnt(HakwonVo hakwonVo);
	public void insertHakwon(HakwonVo HakwonVo);
	public void updateHakwon(HakwonVo hakwonVo);
	
	public void deleteHakwon(HakwonVo hakwonVo) throws Exception;
	public String getMaxHakwoncd();
	public HakwonVo getHakwonDetail(HakwonVo HakwonVo);
	
	public List<StudentVo> getStudentList(StudentVo studentVo);
	public int getStudentListCnt(StudentVo studentVo);
	public void insertStudent(StudentVo studentVo);
	public void updateStudent(StudentVo studentVo);
	public void deleteStudent(StudentVo studentVo) throws Exception;
	public String getMaxStudcd();
	public StudentVo getStudentDetail(StudentVo studentVo);
	public int getStudentStudidCnt(StudentVo studentVo);
	
	public List<BbsInfoVo> getBbsInfoList(BbsInfoVo bbsInfoVo);
	public int getBbsInfoListCnt(BbsInfoVo bbsInfoVo);
	
	public void insertBbsinfo(BbsInfoVo bbsInfoVo);
	public void updateBbsinfo(BbsInfoVo bbsInfoVo);
	public void deleteBbsinfo(BbsInfoVo bbsInfoVo) throws Exception;
	public BbsInfoVo getBbsinfoDetail(BbsInfoVo bbsInfoVo);
	
	public void updateStudentClinic(StudentVo studentVo) throws Exception;
	
	public List<QnaInfoVo> getQnaInfoList(QnaInfoVo qnaInfoVo);
	public int getQnaInfoListCnt(QnaInfoVo qnaInfoVo);
	
	public void updateQnaInfo(QnaInfoVo qnaInfoVo);
	
	public void deleteanswer(AnswerVo AnswerVo);
	
	public void deleteanswernodayvalue(AnswerVo AnswerVo);
}
