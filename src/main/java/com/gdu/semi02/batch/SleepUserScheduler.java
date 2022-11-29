package com.gdu.semi02.batch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.semi02.service.UserService;

@EnableScheduling
@Component
public class SleepUserScheduler {

	@Autowired
	private UserService userService;

	@Scheduled(cron="0 0 * * * *") 
	public void execute() {
		userService.sleepUserHandle();
	}
	
}
