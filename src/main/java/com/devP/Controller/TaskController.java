package com.devP.Controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devP.Service.TaskService;
import com.devP.VO.TaskVO;

@Controller
@RequestMapping("task")
public class TaskController {
	

	@Autowired
	private TaskService taskService;
	//업무 가져오기
    @RequestMapping(value="/getTask.do", method= RequestMethod.GET, produces="application/json;charset=UTF-8")
    @ResponseBody
	    public List<Map<String, Object>> getTask(){
	    return taskService.getTask();
  	}
}
