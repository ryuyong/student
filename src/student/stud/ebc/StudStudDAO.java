package student.stud.ebc;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ModelAttribute;

import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;

public interface StudStudDAO {
	public StudentVo getStudent(@ModelAttribute("StudentVo") StudentVo StudentVo) throws DataAccessException;
	public void insertAnswer(@ModelAttribute("AnswerVo") AnswerVo answerVo) throws DataAccessException;
	public List<AnswerVo> getStudAnswer(@ModelAttribute("AnswerVo") AnswerVo answerVo) throws DataAccessException;
	
	public List<BbsInfoVo> getBbsInfoList(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	public int getBbsInfoListCnt(@ModelAttribute("BbsInfoVo") BbsInfoVo bbsInfoVo) throws DataAccessException;
	
	public List<QnaInfoVo> getQnaInfoList(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public int getQnaInfoListCnt(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public void insertQnaInfo(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public void updateQnaInfo(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public void deleteQnaInfo(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
	public QnaInfoVo getDetailQnaInfo(@ModelAttribute("QnaInfoVo") QnaInfoVo qnaInfoVo) throws DataAccessException;
}
