package student.base.domain;

public class BbsInfoVo extends SearchDefaultVo  {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3864622156407354722L;
	private String rnum = "";
	private String bbs_id="";
	private String bbs_subject ="";
	private String bbs_cn ="";
	private String file_id ="";
	private String reg_date ="";
	private String upd_date ="";
	private String bbs_ids="";
	private String bbs_content="";
	private String bbs_gubun = "";
	private String hakneon = "";
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	public String getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(String bbs_id) {
		this.bbs_id = bbs_id;
	}
	public String getBbs_subject() {
		return bbs_subject;
	}
	public void setBbs_subject(String bbs_subject) {
		this.bbs_subject = bbs_subject;
	}
	public String getBbs_cn() {
		return bbs_cn;
	}
	public void setBbs_cn(String bbs_cn) {
		this.bbs_cn = bbs_cn;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getUpd_date() {
		return upd_date;
	}
	public void setUpd_date(String upd_date) {
		this.upd_date = upd_date;
	}
	public String getBbs_ids() {
		return bbs_ids;
	}
	public void setBbs_ids(String bbs_ids) {
		this.bbs_ids = bbs_ids;
	}
	public String getBbs_content() {
		return bbs_content;
	}
	public void setBbs_content(String bbs_content) {
		this.bbs_content = bbs_content;
	}
	public String getBbs_gubun() {
		return bbs_gubun;
	}
	public void setBbs_gubun(String bbs_gubun) {
		this.bbs_gubun = bbs_gubun;
	}
	public String getHakneon() {
		return hakneon;
	}
	public void setHakneon(String hakneon) {
		this.hakneon = hakneon;
	}
}
