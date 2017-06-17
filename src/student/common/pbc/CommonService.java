package student.common.pbc;

import java.util.List;
import student.base.domain.FileVo;
import student.base.domain.HakwonVo;
import student.base.domain.StudentVo;

public interface CommonService {
	public List<HakwonVo> getHakwonList(HakwonVo hakwonVo);
	public List<StudentVo> getHakwonStudList(StudentVo studentVo);
	public String getHakwonNm(String hakwon_cd);
	public String getStudNm(String stud_cd);
	public String insertFileInf(FileVo fvo) throws Exception;
	public void insertFileMaster(FileVo fileVo);
	public void insertFileDetail(FileVo fileVo);
	public FileVo selectFileInf(FileVo fileVo);
	
	public String getMaxFileId();
	public String getMaxBbsId();
	
	public String getHakwonCd(StudentVo studentVo);
	public String getMaxQnaCd();
}
