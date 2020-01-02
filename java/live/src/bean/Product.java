package bean;

import java.util.Date;

public class Product {
	private String p_code; //상품등록시 필요없지만, 검색시 필요함 
	private String p_id; // 세션으로 받아오는 놈
	private Date p_date; 
	
	
	private String p_kind  ;
	private String p_name ; 
	private int p_price ;
	private int p_qty ;
	private String p_contents ;
	private String p_oriFileName ; 
	private String p_sysFileName ;
	
	
	public String getP_code() {
		return p_code;
	}
	public void setP_code(String p_code) {
		this.p_code = p_code;
	}
	public String getP_id() {
		return p_id;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
	}
	public Date getP_date() {
		return p_date;
	}
	public void setP_date(Date p_date) {
		this.p_date = p_date;
	}
	public String getP_kind() {
		return p_kind;
	}
	public void setP_kind(String p_kind) {
		this.p_kind = p_kind;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public int getP_qty() {
		return p_qty;
	}
	public void setP_qty(int qty) {
		this.p_qty = qty;
	}
	public String getP_contents() {
		return p_contents;
	}
	public void setP_contents(String p_contents) {
		this.p_contents = p_contents;
	}
	public String getP_oriFileName() {
		return p_oriFileName;
	}
	public void setP_oriFileName(String p_oriFileName) {
		this.p_oriFileName = p_oriFileName;
	}
	public String getP_sysFileName() {
		return p_sysFileName;
	}
	public void setP_sysFileName(String p_sysFileName) {
		this.p_sysFileName = p_sysFileName;
	}
	
	
	
}
