package com.ezdev.sfy.service;

import java.util.Hashtable;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezdev.sfy.dto.QnaDTO;

@Service
public class QnaMapper {
	@Autowired
	private SqlSession sqlSession;
	
	//인자로 받은 startRow, endRow를 map 컬렉션에 넣고 해당 map타입의 값을 qna.xml의  아이디가 listBoard인 쿼리문에 인자로 넣는다
	public List<QnaDTO> listBoard(int startRow, int endRow){
			Map<String, Integer> map = new Hashtable<>();
			map.put("start", startRow);
			map.put("end", endRow);
			return sqlSession.selectList("listBoard", map);
	}
	
	public  int insertBoard(QnaDTO dto) {
			String sql = null;
			if (dto.getQna_no() == 0) {
				sql = "update qna set qna_re_step = qna_re_step + 1";
			}else {
				sql = "update qna set qna_re_step = qna_re_step + 1 where qna_re_step > "+dto.getQna_re_step();
				dto.setQna_re_step(dto.getQna_re_step()+1);
				dto.setQna_re_level(dto.getQna_re_level()+1);
			}
			Map<String, String> map = new Hashtable<>();
			map.put("sql", sql);
			sqlSession.update("plusRe_step", map);
			return sqlSession.insert("insertBoard", dto);
	}
	public QnaDTO getBoard(int qna_no, String mode) {
		if (mode.equals("qna_content")) {
			sqlSession.update("plusReadcount", qna_no);
		}
		return  sqlSession.selectOne("getBoard", qna_no);
}
	
	public int getCount() {
			return sqlSession.selectOne("getCount");
	}
	
//Qna 수정	
	public int updateBoard(QnaDTO dto) {
		QnaDTO dto2 = getBoard(dto.getQna_no(), "password");
		if (dto.getQna_passwd().equals(dto2.getQna_passwd())) {
				return sqlSession.update("updateBoard", dto);
		}else {
			return -1;
		}
	}
	public int deleteQna(QnaDTO dto) {
		return sqlSession.delete("deleteQna", dto);
	}
	//
	public int deleteQna(String qna_passwd, int qna_no) {
		Map<String,Object> map = new Hashtable<>();
		map.put("qna_passwd", qna_passwd);
		map.put("qna_no", qna_no);
		return sqlSession.delete("deleteOfQna", qna_no);
	}
	public List<QnaDTO> listOfQna(){
		return sqlSession.selectList("listOfQna");
	}

	public int getCountById(String qna_writer) {
		Map<String, String> map = new Hashtable<>();
		map.put("id", qna_writer);
		return sqlSession.selectOne("getCountById", map);
	}

	public List<QnaDTO> listBoardById(String qna_writer, int startRow, int endRow) {
		Map<String, Object> map = new Hashtable<>();
		map.put("id", qna_writer);
		map.put("start", startRow);
		map.put("end", endRow);
		return sqlSession.selectList("listBoardById", map);
	}
	
}