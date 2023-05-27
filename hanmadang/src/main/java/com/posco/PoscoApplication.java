package com.posco;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@SpringBootApplication
@EnableScheduling
@EnableAsync
public class PoscoApplication {

	public static void main(String[] args) {
		SpringApplication.run(PoscoApplication.class, args);
	}
	
	@Bean 
	public TaskExecutor taskExecutor() { 
		ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor(); 
		taskExecutor.setCorePoolSize(10); 
		taskExecutor.setMaxPoolSize(20); 
		taskExecutor.setQueueCapacity(50); 
		return taskExecutor; 
	}
}
