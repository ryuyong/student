package student.stud.pbc;

import java.util.List;

import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;

public interface StudStudService {
	public StudentVo getStudent(StudentVo StudentVo);
	public void insertAnswer(String path, String hakneon, AnswerVo answerVo) throws Exception ;
	public List<AnswerVo> getStudAnswer(AnswerVo answerVo);
	
	public List<BbsInfoVo> getBbsInfoList(BbsInfoVo bbsInfoVo);
	public int getBbsInfoListCnt(BbsInfoVo bbsInfoVo);
	
	
	public List<QnaInfoVo> getQnaInfoList(QnaInfoVo qnaInfoVo);
	public int getQnaInfoListCnt(QnaInfoVo qnaInfoVo);
	public void insertQnaInfo(QnaInfoVo qnaInfoVo);
	public void updateQnaInfo(QnaInfoVo qnaInfoVo);
	public void deleteQnaInfo(QnaInfoVo qnaInfoVo) throws Exception;
	public QnaInfoVo getDetailQnaInfo(QnaInfoVo qnaInfoVo);
}
