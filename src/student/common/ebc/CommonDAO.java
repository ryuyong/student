package student.common.ebc;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ModelAttribute;

import student.base.domain.FileVo;
import student.base.domain.HakwonVo;
import student.base.domain.StudentVo;

public interface CommonDAO {
	public List<HakwonVo> getHakwonList(@ModelAttribute("HakwonVo") HakwonVo hakwonVo) throws DataAccessException;
	
	public List<StudentVo> getHakwonStudList(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public String getHakwonNm(@Param("hakwon_cd") String hakwon_cd) throws DataAccessException;
	public String getStudNm(@Param("stud_cd") String stud_cd) throws DataAccessException;
	
	public void insertFileMaster(@ModelAttribute("FileVo") FileVo fileVo) throws DataAccessException;
	public void insertFileDetail(@ModelAttribute("FileVo") FileVo fileVo) throws DataAccessException;
	public FileVo selectFileInf(FileVo fileVo) throws DataAccessException ;
	
	public String getMaxFileId() throws DataAccessException;
	public String getMaxBbsId() throws DataAccessException;
	
	public String getHakwonCd(@ModelAttribute("StudentVo") StudentVo studentVo) throws DataAccessException;
	public String getMaxQnaCd() throws DataAccessException;
}
