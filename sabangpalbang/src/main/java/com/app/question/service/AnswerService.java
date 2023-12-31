package com.app.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dto.AnswerDTO;
import com.app.dto.QuestionDTO;
import com.app.question.dao.AnswerDao;
import com.app.question.dto.AnswerDto;
import com.app.question.dto.titleDto;

@Service
public class AnswerService {
	@Autowired
	AnswerDao dao;

	public List<titleDto> titleSelect() {
		return dao.titleSelect();
	}

	public int answerInsert(AnswerDto dto) {
		return dao.answerInsert(dto);
	}

	public List<AnswerDto> answerSelect(int question_id) {
		return dao.answerSelect(question_id);
	}

	public int count(int question_id) {
		return dao.count(question_id);
	};
	
	public int deleteContent(int answer_id) {
		return dao.deleteContent(answer_id);
	}
	
	public int updateAnswer(AnswerDto dto){
		return dao.updateAnswer(dto);
	}

}
