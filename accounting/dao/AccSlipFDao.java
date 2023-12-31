package kr.happyjob.study.accounting.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accounting.model.AccSlipFModel;


public interface AccSlipFDao {

	/** 회계전표 목록 조회 */
	public List<AccSlipFModel> accslipflist(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 목록 카운트 조회 */
	public int countaccslipflist(Map<String, Object> paramMap) throws Exception;

	/** 회계전표리스트 모달창 */
	public List<AccSlipFModel> accslipfmodal(Map<String, Object> paramMap) throws Exception;
	
	
	
}
