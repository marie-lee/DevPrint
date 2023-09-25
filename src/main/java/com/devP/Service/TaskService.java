package com.devP.Service;


import java.util.List;
import java.util.Map;

import com.devP.VO.TaskListVO;
import org.springframework.ui.Model;

public interface TaskService {
	List<Map<String, Object>> getTask();

	int getUserTaskList(Model model);

	List<TaskListVO> getTaskList(Model model);
	
	void getTaskCount(Model model);
}
