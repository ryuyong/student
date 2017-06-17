package student.admin.pbc.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import student.admin.ebc.AdminStudDAO;
import student.admin.pbc.AdminStudService;
import student.base.domain.AdminVo;
import student.base.domain.AnswerVo;
import student.base.domain.BbsInfoVo;
import student.base.domain.HakwonVo;
import student.base.domain.QnaInfoVo;
import student.base.domain.StudentVo;
import student.common.ebc.CommonDAO;

@Service
public class AdminStudServiceImpl implements AdminStudService {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public AdminVo getAdmin(AdminVo AdminVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getAdmin(AdminVo);
	}

	@Override
	public List<AnswerVo> getStudAnswerStats(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudAnswerStats(AnswerVo);
	}

	@Override
	public List<AnswerVo> getStudAnswerSubmitStats(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudAnswerSubmitStats(AnswerVo);
	}

	@Override
	public List<AnswerVo> getStudAnswerWrongStats(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudAnswerWrongStats(AnswerVo);
	}

	@Override
	public List<AnswerVo> getStudAnswerWrongList(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudAnswerWrongList(AnswerVo);
	}

	@Override
	public List<HakwonVo> getHakwonList(HakwonVo hakwonVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getHakwonList(hakwonVo);
	}

	@Override
	public int getHakwonListCnt(HakwonVo hakwonVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getHakwonListCnt(hakwonVo);
	}

	@Override
	public void insertHakwon(HakwonVo HakwonVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.insertHakwon(HakwonVo);
	}

	@Override
	public void updateHakwon(HakwonVo hakwonVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.updateHakwon(hakwonVo);
	}

	@Override
	public void deleteHakwon(HakwonVo hakwonVo) throws Exception  {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		try{
			AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
			String hakwon_cds = hakwonVo.getHakwon_cds();
			String[] hakwon_cd = hakwon_cds.split(":::::");
			for(int i=0;i<hakwon_cd.length;i++) {
				hakwonVo.setHakwon_cd(hakwon_cd[i]);
				AdminStudDAO.deleteHakwon(hakwonVo);
			}
		} catch (Exception e) {
			transactionManager.rollback(status);
			throw e;
		}
		transactionManager.commit(status);
	}

	@Override
	public String getMaxHakwoncd() {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getMaxHakwoncd();
	}

	@Override
	public HakwonVo getHakwonDetail(HakwonVo HakwonVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getHakwonDetail(HakwonVo);
	}

	@Override
	public List<StudentVo> getStudentList(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudentList(studentVo);
	}

	@Override
	public int getStudentListCnt(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudentListCnt(studentVo);
	}

	@Override
	public void insertStudent(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.insertStudent(studentVo);
	}

	@Override
	public void updateStudent(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.updateStudent(studentVo);
	}

	@Override
	public void deleteStudent(StudentVo studentVo) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		try{
			AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
			String stud_cds = studentVo.getStud_cds();
			String[] stud_cd = stud_cds.split(":::::");
			for(int i=0;i<stud_cd.length;i++) {
				studentVo.setStud_cd(stud_cd[i]);
				AdminStudDAO.deleteStudent(studentVo);
			}
		} catch (Exception e) {
			transactionManager.rollback(status);
			throw e;
		}
		transactionManager.commit(status);
	}

	@Override
	public String getMaxStudcd() {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getMaxStudcd();
	}

	@Override
	public StudentVo getStudentDetail(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudentDetail(studentVo);
	}

	@Override
	public int getStudentStudidCnt(StudentVo studentVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getStudentStudidCnt(studentVo);
	}

	@Override
	public List<BbsInfoVo> getBbsInfoList(BbsInfoVo bbsInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getBbsInfoList(bbsInfoVo);
	}

	@Override
	public int getBbsInfoListCnt(BbsInfoVo bbsInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getBbsInfoListCnt(bbsInfoVo);
	}

	@Override
	public void insertBbsinfo(BbsInfoVo bbsInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.insertBbsinfo(bbsInfoVo);
	}

	@Override
	public void updateBbsinfo(BbsInfoVo bbsInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.updateBbsinfo(bbsInfoVo);
	}

	@Override
	public void deleteBbsinfo(BbsInfoVo bbsInfoVo) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
			String bbs_ids = bbsInfoVo.getBbs_ids();
			String[] bbs_id = bbs_ids.split(":::::");
			for(int i=0;i<bbs_id.length;i++) {
				bbsInfoVo.setBbs_id(bbs_id[i]);
				AdminStudDAO.deleteBbsinfo(bbsInfoVo);
			}
		} catch (Exception e) {
			transactionManager.rollback(status);
			throw e;
		}
		transactionManager.commit(status);

	}

	@Override
	public BbsInfoVo getBbsinfoDetail(BbsInfoVo bbsInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getBbsinfoDetail(bbsInfoVo);
	}

	@Override
	public void updateStudentClinic(StudentVo studentVo) throws Exception {
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
			AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
			String stud_cds = studentVo.getStud_cds();
			String clinictypes = studentVo.getClinictypes();
			
			String[] stud_cd = stud_cds.split(":::::");
			String[] clinictype = clinictypes.split(":::::");
			for(int i=0;i<stud_cd.length;i++) {
				studentVo.setStud_cd(stud_cd[i]);
				if(clinictype[i] != null && clinictype[i].equals("NULL")) {
					studentVo.setClinictype("");
				} else {
					studentVo.setClinictype(clinictype[i]);
				}
				AdminStudDAO.updateStudentClinic(studentVo);
			}
		} catch (Exception e) {
			transactionManager.rollback(status);
			throw e;
		}
		transactionManager.commit(status);
	}

	@Override
	public List<QnaInfoVo> getQnaInfoList(QnaInfoVo qnaInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getQnaInfoList(qnaInfoVo);
	}

	@Override
	public int getQnaInfoListCnt(QnaInfoVo qnaInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		return AdminStudDAO.getQnaInfoListCnt(qnaInfoVo);
	}

	@Override
	public void updateQnaInfo(QnaInfoVo qnaInfoVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.updateQnaInfo(qnaInfoVo);
	}
	
	@Override
	public void deleteanswer(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.deleteanswer(AnswerVo);
	}
	
	@Override
	public void deleteanswernodayvalue(AnswerVo AnswerVo) {
		AdminStudDAO AdminStudDAO = sqlSession.getMapper(AdminStudDAO.class);
		AdminStudDAO.deleteanswernodayvalue(AnswerVo);
	}
	
}
